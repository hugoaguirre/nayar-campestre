#!/usr/bin/env python3
"""
Test Suite: Parity BYE Anti-Rematch Engine for Ranking Ladder
Verifies:
1. Normal alternating weeks (Challenge / Defend) with no departures
2. Single departure (Loser leaves) -> 0 duplicate rematches, winner rewarded with BYE
3. Multiple departures in the same week -> Localized parity healing, 0 rematches
4. Departure + Addition in the same week -> Smooth handling, 0 rematches
5. Multi-week cycle (Week 1 -> Week 2 with BYE -> Week 3 Challenge)
"""
import sys
import os

# Add workspace to path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from services.ranking_service import RankingService


def assert_no_rematches(pairings, previous_matches, test_name):
    """Ensure no pair in pairings played each other in previous_matches."""
    prev_pairs = set()
    for m in previous_matches:
        d, c = m.get("defender_id"), m.get("challenger_id")
        if d and c:
            prev_pairs.add(frozenset([d, c]))

    for def_id, def_pos, chal_id, chal_pos in pairings:
        current_pair = frozenset([def_id, chal_id])
        if current_pair in prev_pairs:
            raise AssertionError(
                f"[{test_name}] REMATCH DETECTED between {def_id} (#{def_pos}) and {chal_id} (#{chal_pos})!"
            )


def run_tests():
    print("=================================================================")
    print("RUNNING RANKING LADDER PAIRING ENGINE TESTS")
    print("=================================================================")

    # ─────────────────────────────────────────────────────────────
    # TEST 1: Normal Alternating Cycle (No Departures)
    # ─────────────────────────────────────────────────────────────
    print("\n[TEST 1] Normal Cycle: Challenge -> Defend (No departures)")
    # 8 players: P1 to P8
    ladder_w1 = [{"player_id": f"P{i}", "position": i} for i in range(1, 9)]
    pairings_w1, resting_w1 = RankingService.generate_pairings(ladder_w1, "challenge")

    # In Challenge: P1 rests, P8 rests (odd player out of remaining 7)
    assert "P1" in resting_w1, "P1 must rest on Challenge week"
    assert "P8" in resting_w1, "P8 must rest as odd player out"
    assert len(pairings_w1) == 3, f"Expected 3 matches, got {len(pairings_w1)}"
    expected_w1_pairs = [("P2", "P3"), ("P4", "P5"), ("P6", "P7")]
    actual_w1_pairs = [(p[0], p[2]) for p in pairings_w1]
    assert actual_w1_pairs == expected_w1_pairs, f"Expected {expected_w1_pairs}, got {actual_w1_pairs}"

    # Results of W1:
    matches_w1 = [
        {"defender_id": "P2", "challenger_id": "P3", "winner_id": "P2"},
        {"defender_id": "P4", "challenger_id": "P5", "winner_id": "P4"},
        {"defender_id": "P6", "challenger_id": "P7", "winner_id": "P6"},
    ]

    # Week 2 Defend (normal, no departures):
    pairings_w2_norm, resting_w2_norm = RankingService.generate_pairings(
        ladder_w1, "defend", previous_matches=matches_w1
    )
    assert len(resting_w2_norm) == 0, "No players should rest in 8-player Defend week"
    assert_no_rematches(pairings_w2_norm, matches_w1, "TEST 1 Defend")
    expected_w2_pairs = [("P1", "P2"), ("P3", "P4"), ("P5", "P6"), ("P7", "P8")]
    actual_w2_pairs = [(p[0], p[2]) for p in pairings_w2_norm]
    assert actual_w2_pairs == expected_w2_pairs, f"Expected {expected_w2_pairs}, got {actual_w2_pairs}"
    print("  ✓ TEST 1 PASSED: Standard alternating cycle preserves Seed #1 and expected pairings.")

    # ─────────────────────────────────────────────────────────────
    # TEST 2: Single Departure (Loser P3 Leaves)
    # ─────────────────────────────────────────────────────────────
    print("\n[TEST 2] Single Departure: Loser P3 leaves before Defend Week")
    # P3 leaves -> P4 shifts to 3, P5 to 4, P6 to 5, P7 to 6, P8 to 7
    ladder_w2_leave = [
        {"player_id": "P1", "position": 1},
        {"player_id": "P2", "position": 2},
        {"player_id": "P4", "position": 3},  # Winner of 4v5 last week
        {"player_id": "P5", "position": 4},  # Loser of 4v5 last week
        {"player_id": "P6", "position": 5},  # Winner of 6v7 last week
        {"player_id": "P7", "position": 6},  # Loser of 6v7 last week
        {"player_id": "P8", "position": 7},
    ]

    pairings_w2_l, resting_w2_l = RankingService.generate_pairings(
        ladder_w2_leave, "defend", previous_matches=matches_w1
    )
    assert_no_rematches(pairings_w2_l, matches_w1, "TEST 2 Single Departure")
    assert "P4" in resting_w2_l, "P4 (Winner of 4v5) must be rewarded with the BYE"

    # P5 (Loser) must play P6 (Winner climbing from below)
    p5_opp = next((p[2] if p[0] == "P5" else p[0] for p in pairings_w2_l if "P5" in (p[0], p[2])), None)
    assert p5_opp == "P6", f"P5 should play P6, but got {p5_opp}"

    # P7 plays P8
    p7_opp = next((p[2] if p[0] == "P7" else p[0] for p in pairings_w2_l if "P7" in (p[0], p[2])), None)
    assert p7_opp == "P8", f"P7 should play P8, but got {p7_opp}"
    print("  ✓ TEST 2 PASSED: Zero rematches, Winner P4 received BYE, P5 paired with P6.")

    # ─────────────────────────────────────────────────────────────
    # TEST 3: Multiple Departures in Same Week (P3 and P7 Leave)
    # ─────────────────────────────────────────────────────────────
    print("\n[TEST 3] Multiple Departures: P3 leaves at tier 2, P7 leaves at tier 4")
    # Ladder after P3 and P7 leave:
    ladder_w2_multi = [
        {"player_id": "P1", "position": 1},
        {"player_id": "P2", "position": 2},
        {"player_id": "P4", "position": 3},
        {"player_id": "P5", "position": 4},
        {"player_id": "P6", "position": 5},
        {"player_id": "P8", "position": 6},
    ]
    pairings_w2_m, resting_w2_m = RankingService.generate_pairings(
        ladder_w2_multi, "defend", previous_matches=matches_w1
    )
    assert_no_rematches(pairings_w2_m, matches_w1, "TEST 3 Multiple Departures")
    assert "P4" in resting_w2_m, "P4 must receive BYE from first fault line"
    print(f"  Pairings: {[(p[0], p[2]) for p in pairings_w2_m]}")
    print(f"  Resting: {resting_w2_m}")
    print("  ✓ TEST 3 PASSED: Multiple departures handled gracefully without rematches.")

    # ─────────────────────────────────────────────────────────────
    # TEST 4: Departure + Addition in Same Week
    # ─────────────────────────────────────────────────────────────
    print("\n[TEST 4] Departure + Addition: P3 leaves, new player P9 joins at pos 5")
    ladder_w2_add = [
        {"player_id": "P1", "position": 1},
        {"player_id": "P2", "position": 2},
        {"player_id": "P4", "position": 3},
        {"player_id": "P5", "position": 4},
        {"player_id": "P9", "position": 5},  # New player
        {"player_id": "P6", "position": 6},
        {"player_id": "P7", "position": 7},
        {"player_id": "P8", "position": 8},
    ]
    pairings_w2_a, resting_w2_a = RankingService.generate_pairings(
        ladder_w2_add, "defend", previous_matches=matches_w1
    )
    assert_no_rematches(pairings_w2_a, matches_w1, "TEST 4 Departure + Addition")
    print(f"  Pairings: {[(p[0], p[2]) for p in pairings_w2_a]}")
    print(f"  Resting: {resting_w2_a}")
    print("  ✓ TEST 4 PASSED: Departure + Addition handled with zero rematches.")

    # ─────────────────────────────────────────────────────────────
    # TEST 5: Week 3 Challenge Phase after a Week 2 BYE
    # ─────────────────────────────────────────────────────────────
    print("\n[TEST 5] Multi-week progression: Week 3 (Challenge) after Week 2 BYE")
    # Matches in W2 from TEST 2:
    # (P1, P2) -> P1 wins
    # (P5, P6) -> P5 wins
    # (P7, P8) -> P7 wins
    # P4 rested
    matches_w2 = [
        {"defender_id": "P1", "challenger_id": "P2", "winner_id": "P1"},
        {"defender_id": "P5", "challenger_id": "P6", "winner_id": "P5"},
        {"defender_id": "P7", "challenger_id": "P8", "winner_id": "P7"},
    ]
    ladder_w3 = [
        {"player_id": "P1", "position": 1},
        {"player_id": "P2", "position": 2},
        {"player_id": "P4", "position": 3},
        {"player_id": "P5", "position": 4},
        {"player_id": "P6", "position": 5},
        {"player_id": "P7", "position": 6},
        {"player_id": "P8", "position": 7},
    ]
    pairings_w3, resting_w3 = RankingService.generate_pairings(
        ladder_w3, "challenge", previous_matches=matches_w2
    )
    assert_no_rematches(pairings_w3, matches_w2, "TEST 5 Week 3 Progression")
    assert "P1" in resting_w3, "Seed #1 must rest in Week 3 Challenge phase"
    print(f"  Pairings: {[(p[0], p[2]) for p in pairings_w3]}")
    print(f"  Resting: {resting_w3}")
    print("  ✓ TEST 5 PASSED: Multi-week progression maintains 0 rematches and Seed #1 rests.")

    print("\n=================================================================")
    print("ALL 5 TEST SUITES PASSED WITH 100% SUCCESS!")
    print("=================================================================")


if __name__ == "__main__":
    run_tests()
