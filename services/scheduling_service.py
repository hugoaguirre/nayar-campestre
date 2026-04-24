import re
import math
import streamlit as st
import pandas as pd
from datetime import datetime, timedelta
import itertools
from collections import defaultdict
from utils.supabase_client import get_supabase_client

# ═══════════════════════════════════════════════════════════════════════════
# Constants & Pre-compiled Patterns
# ═══════════════════════════════════════════════════════════════════════════

_R_TAG = re.compile(r'\[R(\d+)\]')

# Constraint severity ranking (higher = more severe, used for cascading)
_SEVERITY = {
    "PASS": 0,
    "FAIL_CONSECUTIVE": 1,
    "FAIL_SAME_DAY": 2,
    "FAIL_MAX_GAMES": 3,
    "FAIL_SAME_TIME": 4,
}

# Time-Grid Architecture: Continuous 90-minute blocks
_SLOT_MIN = 90
_PRIME_HOUR = 19

# Closing ceremony: last match must FINISH by this hour on the final day.
# The slot generator truncates the last day so no match starts past
# (cutoff_hour × 60 − _SLOT_MIN) minutes.
_CEREMONY_CUTOFF_WEEKEND = 15   # 3:00 PM on Sat/Sun
_CEREMONY_CUTOFF_WEEKDAY = 18   # 6:00 PM on Mon-Fri

# Weekday int (0=Mon … 6=Sun) → (start_hour, number_of_slots)
# Monday (0) intentionally absent — club is closed on Mondays.
_GRID_CONFIG = {
    1: (16, 4),   # Tuesday    → 16:00, 17:30, 19:00, 20:30
    2: (16, 4),   # Wednesday
    3: (16, 4),   # Thursday
    4: (16, 4),   # Friday
    5: (9, 8),    # Saturday   → 09:00, 10:30, 12:00, 13:30, 15:00, 16:30, 18:00, 19:30
    6: (9, 8),    # Sunday     → 09:00, 10:30, 12:00, 13:30, 15:00, 16:30, 18:00, 19:30
}

# ── Tier-Based Scheduling Order ──────────────────────────────────────────
# Lower number = scheduled FIRST. Kids get the earliest available slots,
# then low-tier categories fill the next blocks, and high-tier (prime-time)
# categories are scheduled last—natural affinity toward evening hours.
_SUBCATEGORY_TIER = {
    "Mini-Tenis": 0,   # Kids — earliest slots
    "8-10 años":  1,   # Kids
    "D":          2,   # Low tier
    "C":          3,   # Low tier
    "B":          4,   # Low tier (after C, D)
    "B+":         5,   # High tier — first of the primes
    "A":          6,   # High tier
    "AA":         7,   # High tier — last
}

# Category sets for time-preference penalties
_MINORS_CATS = {"Mini-Tenis", "8-10 años"}
_PRIME_CATS = {"AA", "A", "B+"}

# Knockout round naming (Spanish) — mapped relative to the FINAL round.
# offset_from_end=0 → Final, 1 → Semifinal, 2 → Cuartos, etc.
_KO_NAMES_BY_OFFSET = {
    0: "Final",
    1: "Semifinal",
    2: "Cuartos de Final",
    3: "Octavos de Final",
    4: "Dieciseisavos de Final",
}

# Default daily match cap per player (normal pass). Overflow pass raises to 3.
_DAILY_MATCH_CAP_NORMAL = 2
_DAILY_MATCH_CAP_OVERFLOW = 3


# ═══════════════════════════════════════════════════════════════════════════
# Helper Functions
# ═══════════════════════════════════════════════════════════════════════════

def _build_day_slots(day: datetime) -> list:
    """Generate the continuous 90-minute slot array for a single calendar day."""
    config = _GRID_CONFIG.get(day.weekday())
    if config is None:
        return []
    start_hour, num_slots = config
    slots = []
    t = day.replace(hour=start_hour, minute=0, second=0, microsecond=0)
    for _ in range(num_slots):
        slots.append({"time": t, "is_prime": t.hour >= _PRIME_HOUR})
        t += timedelta(minutes=_SLOT_MIN)
    return slots


def _worse(current: str, candidate: str) -> str:
    """Return the more severe constraint result."""
    return candidate if _SEVERITY.get(candidate, 0) > _SEVERITY.get(current, 0) else current


def _extract_round(match: dict) -> int:
    """Extract the highest [R#] playoff round number from a match's placeholder strings.
    
    Falls back to content-based inference for Eliminatoria matches whose
    [R#] tags could not be parsed (e.g., missing score fields).
    """
    score_a = match.get("score_team_a", "") or ""
    score_b = match.get("score_team_b", "") or ""
    a = _R_TAG.search(score_a)
    b = _R_TAG.search(score_b)
    round_val = max(int(a.group(1)) if a else 0, int(b.group(1)) if b else 0)

    # Fallback: if tags are absent but the match IS a knockout, infer from content.
    # "Ganador de Llave" references are only generated for R2+ rounds.
    if round_val == 0 and match.get("stage") == "Eliminatoria":
        has_llave_ref = "Ganador de Llave" in score_a or "Ganador de Llave" in score_b
        round_val = 2 if has_llave_ref else 1

    return round_val


def _ko_round_name(round_num: int, total_rounds: int) -> str:
    """Compute the human-readable Spanish name for a knockout round.
    
    E.g., if total_rounds=3: R1=Cuartos, R2=Semifinal, R3=Final.
    """
    offset_from_end = total_rounds - round_num
    return _KO_NAMES_BY_OFFSET.get(offset_from_end, f"Ronda {round_num}")


class SchedulingService:
    # ── Match Generation ──────────────────────────────────────────────────

    @staticmethod
    def generate_round_robin_matches(tournament_id):
        """
        Reads all saved draws from 'tournament_draws' and dynamically injects
        Round-Robin phase pairings + Knockout placeholders into the 'matches' table.
        Wipes existing matches first for a clean regeneration.
        
        Single-group categories skip knockout generation entirely — the
        round-robin winner is the champion.
        """
        try:
            supabase = get_supabase_client()

            # 1. Wipe all existing matches for this tournament to prevent accumulation
            supabase.table("matches").delete().eq(
                "tournament_id", tournament_id
            ).in_("stage", ["Grupos", "Eliminatoria"]).execute()

            # 2. Fetch all saved draws for the tournament
            draws_resp = (
                supabase.table("tournament_draws")
                .select("*")
                .eq("tournament_id", tournament_id)
                .execute()
            )
            if not draws_resp.data:
                return False

            for draw in draws_resp.data:
                fmt = draw["format_text"]       # Singles / Dobles
                cat_id = draw["category_id"]
                scat_id = draw["subcategory_id"]
                groups = draw["draw_json"]

                # ── Round-Robin Pairings (batch insert) ───────────────
                rr_batch = []
                for group_name, players in groups.items():
                    for p1, p2 in itertools.combinations(players, 2):
                        rr_batch.append({
                            "tournament_id": tournament_id,
                            "category_id": cat_id,
                            "subcategory_id": scat_id,
                            "match_type": fmt,
                            "stage": "Grupos",
                            "player1_id": p1.get("ID_Jugador"),
                            "team1_partner_id": p1.get("ID_Pareja") if fmt == "Dobles" else None,
                            "player2_id": p2.get("ID_Jugador"),
                            "team2_partner_id": p2.get("ID_Pareja") if fmt == "Dobles" else None,
                            "status": "Scheduled",
                        })

                if rr_batch:
                    supabase.table("matches").insert(rr_batch).execute()

                # ── Guard: Skip knockouts for single-group categories ─
                if len(groups) <= 1:
                    continue

                # ── Knockout Placeholders (ATP/WTA Binary Seeding) ────
                def get_pow2(n):
                    if n <= 2:
                        return 2
                    return 2 ** math.ceil(math.log2(n))

                seeds = []
                unseeded = []

                # Sort groups lexicographically so Grupo 1 is securely anchored
                for g_name, pts in sorted(groups.items()):
                    seeded_player = next((p for p in pts if p.get("is_seed")), None)
                    if seeded_player:
                        seed_name = f"{seeded_player['Nombre']} {seeded_player['Apellido']}".strip()
                        seeds.append(f"[R1] Gan. {g_name} ({seed_name})")
                    else:
                        unseeded.append(f"[R1] Gan. {g_name}")

                total_groups = len(seeds) + len(unseeded)
                if total_groups > 0:
                    pow2 = get_pow2(total_groups)
                    if pow2 < 4:
                        pow2 = 4

                    while len(seeds) + len(unseeded) < pow2:
                        unseeded.append("BYE")

                    def seed_tree(depth):
                        if depth == 1:
                            return [0, 1]
                        prev = seed_tree(depth - 1)
                        size = 2 ** depth
                        result = []
                        for val in prev:
                            result.append(val)
                            result.append(size - 1 - val)
                        return result

                    positions = seed_tree(int(math.log2(pow2)))
                    bracket = [None] * pow2

                    for i, s in enumerate(seeds):
                        bracket[positions[i]] = s

                    unseeded.sort(key=lambda x: x != "BYE")
                    ui = 0
                    for pos in positions:
                        if bracket[pos] is None:
                            bracket[pos] = unseeded[ui]
                            ui += 1

                    # Walk the bracket tree, generating knockout match rows
                    ko_batch = []
                    current = bracket
                    r_num = 1

                    # Pre-compute total rounds for naming
                    total_ko_rounds = int(math.log2(pow2))

                    while len(current) > 1:
                        nxt = []
                        round_name = _ko_round_name(r_num, total_ko_rounds)
                        for i in range(0, len(current), 2):
                            p1, p2 = current[i], current[i + 1]
                            if p1 == "BYE":
                                nxt.append(p2)
                            elif p2 == "BYE":
                                nxt.append(p1)
                            else:
                                ko_batch.append({
                                    "tournament_id": tournament_id,
                                    "category_id": cat_id,
                                    "subcategory_id": scat_id,
                                    "match_type": fmt,
                                    "stage": "Eliminatoria",
                                    "status": "Scheduled",
                                    "score_team_a": p1,
                                    "score_team_b": p2,
                                })
                                nxt.append(
                                    f"[R{r_num + 1}] Ganador de Llave {len(nxt) + 1}"
                                )

                        current = nxt
                        r_num += 1

                    if ko_batch:
                        supabase.table("matches").insert(ko_batch).execute()

            return True
        except Exception as e:
            print(f"Match Gen Error: {e}")
            return False

    # ── Match Fetching ────────────────────────────────────────────────────

    @staticmethod
    def get_all_matches(tournament_id):
        """Fetches all matches including player names and court assignments."""
        try:
            supabase = get_supabase_client()
            resp = (
                supabase.table("matches")
                .select(
                    "*, "
                    "categories(name), subcategories(name), courts(name), "
                    "p1:players!player1_id(first_name, last_name), "
                    "p1_par:players!team1_partner_id(first_name, last_name), "
                    "p2:players!player2_id(first_name, last_name), "
                    "p2_par:players!team2_partner_id(first_name, last_name)"
                )
                .eq("tournament_id", tournament_id)
                .execute()
            )

            return resp.data if resp.data else []
        except Exception as e:
            print(f"Error fetching matches: {e}")
            return []

    # ── Constraint Engine ─────────────────────────────────────────────────

    @staticmethod
    def check_match_constraints(match, slot_time, scheduled_matrix, daily_cap=_DAILY_MATCH_CAP_NORMAL):
        """
        Evaluates physical overlaps and chronological rest periods for all
        players involved in the match.

        Args:
            daily_cap: Maximum matches per player per day. Set to 2 for normal
                       pass, 3 for overflow "strictly necessary" pass.

        Returns the most severe applicable constraint:
            'PASS'              — No conflicts
            'FAIL_CONSECUTIVE'  — Adjacent calendar day (soft penalty in scheduler)
            'FAIL_SAME_DAY'     — Another match already on same day (soft penalty)
            'FAIL_MAX_GAMES'    — daily_cap matches already booked on this day
            'FAIL_SAME_TIME'    — Exact time-slot collision (hard block always)
        """
        p_ids = [
            match.get("player1_id"),
            match.get("player2_id"),
            match.get("team1_partner_id"),
            match.get("team2_partner_id"),
        ]
        p_ids = [p for p in p_ids if p is not None]

        # Knockout placeholders without player bindings bypass constraint checks
        if not p_ids:
            return "PASS"

        worst = "PASS"

        for p in p_ids:
            p_matches = scheduled_matrix.get(p, [])

            # ── Absolute daily cap ──────────────────────────────────
            same_day = [pm for pm in p_matches if pm["time"].date() == slot_time.date()]
            if len(same_day) >= daily_cap:
                return "FAIL_MAX_GAMES"

            for pm in p_matches:
                pm_time = pm["time"]

                # ── Exact time-slot collision (hard block) ──────────
                if abs((slot_time - pm_time).total_seconds()) == 0:
                    return "FAIL_SAME_TIME"

                # ── Same calendar day (soft penalty) ────────────────
                if slot_time.date() == pm_time.date():
                    worst = _worse(worst, "FAIL_SAME_DAY")

                # ── Adjacent calendar day (soft penalty) ────────────
                if abs((slot_time.date() - pm_time.date()).days) == 1:
                    worst = _worse(worst, "FAIL_CONSECUTIVE")

        return worst

    # ── The Master Scheduling Engine ──────────────────────────────────────

    @staticmethod
    def auto_schedule_matches(
        tournament_id, start_date_str, end_date_str, num_courts=6
    ):
        """
        Tier-Based Scheduling Engine with reactive Eliminatoria phases,
        density spreading, knockout rest-day enforcement, and overflow valve.

        Scheduling philosophy:
          1. GROUP STAGE matches are sorted by tier (Kids→Low→High) and
             population size, ensuring kids play at the earliest available
             slots and larger brackets start sooner.
          2. KNOCKOUT early rounds (QF, etc.) are scheduled reactively —
             as soon as their parent group phase finishes.
          3. KNOCKOUT semi-finals and finals gravitate toward the last days.
          4. A player may play at most 2 matches per calendar day. If a match
             cannot be placed under this constraint, an overflow pass retries
             with a relaxed cap of 3 matches/day.

        Returns a diagnostics dict:
            {
                "success": bool,
                "total_scheduled": int,
                "failed": int,
                "failed_ids": list,
                "overflow_count": int,
                "day_distribution": dict,
                "court_distribution": dict,
            }
        """
        try:
            start_date = datetime.strptime(start_date_str, "%Y-%m-%d")
            end_date = datetime.strptime(end_date_str, "%Y-%m-%d")
            total_days = (end_date.date() - start_date.date()).days

            supabase = get_supabase_client()

            # ── Resolve active courts ─────────────────────────────────
            courts_resp = (
                supabase.table("courts")
                .select("id, name")
                .eq("is_active", True)
                .execute()
            )
            if not courts_resp.data:
                return False

            sorted_courts = sorted(courts_resp.data, key=lambda x: x["name"])
            courts = [c["id"] for c in sorted_courts[:num_courts]]

            # ── Fetch unscheduled matches ─────────────────────────────
            unscheduled = (
                supabase.table("matches")
                .select(
                    "id, category_id, subcategory_id, stage, match_type, "
                    "subcategories(name), score_team_a, score_team_b, "
                    "player1_id, player2_id, team1_partner_id, team2_partner_id"
                )
                .eq("tournament_id", tournament_id)
                .is_("scheduled_time", "null")
                .execute()
            )

            if not unscheduled.data:
                return {"success": True, "total_scheduled": 0, "failed": 0}

            # ── Build the full time-slot grid (continuous 90-min blocks) ──
            slots = []
            curr_day = start_date
            while curr_day <= end_date:
                day_slots = _build_day_slots(curr_day)

                # Truncate the LAST day for the closing ceremony
                if curr_day.date() == end_date.date():
                    is_weekend = curr_day.weekday() >= 5  # Sat=5, Sun=6
                    cutoff = _CEREMONY_CUTOFF_WEEKEND if is_weekend else _CEREMONY_CUTOFF_WEEKDAY
                    max_start_min = cutoff * 60 - _SLOT_MIN
                    day_slots = [
                        s for s in day_slots
                        if s["time"].hour * 60 + s["time"].minute <= max_start_min
                    ]

                slots.extend(day_slots)
                curr_day += timedelta(days=1)

            # ── Hydrate existing bookings ─────────────────────────────
            booked_resp = (
                supabase.table("matches")
                .select(
                    "court_id, scheduled_time, stage, match_type, "
                    "category_id, subcategory_id, score_team_a, score_team_b, "
                    "player1_id, player2_id, team1_partner_id, team2_partner_id"
                )
                .eq("tournament_id", tournament_id)
                .not_.is_("scheduled_time", "null")
                .execute()
            )

            book_map = set()                # "courtId_isoTime" → Taken
            scheduled_matrix = {}           # player_id → [dicts]
            day_usage = defaultdict(int)    # date → total match count
            court_usage = defaultdict(int)  # court_id → total match count

            # Reactivity maps: seed from already-booked matches so that
            # cascading phase locks work even on subsequent scheduler runs.
            group_end_dates = {}            # "cat_scat_isDoubles" → date
            eliminatoria_end_dates = {}     # "cat_scat_isDoubles_R#" → date

            if booked_resp.data:
                for b in booked_resp.data:
                    dt = datetime.fromisoformat(
                        b["scheduled_time"].replace("Z", "+00:00")
                    ).replace(tzinfo=None)
                    book_map.add(f"{b['court_id']}_{dt.isoformat()}")
                    day_usage[dt.date()] += 1
                    if b.get("court_id"):
                        court_usage[b["court_id"]] += 1

                    b_stage = b.get("stage", "Grupos")
                    b_is_doubles = b.get("match_type") == "Dobles"

                    for pk in ["player1_id", "player2_id", "team1_partner_id", "team2_partner_id"]:
                        if b.get(pk):
                            scheduled_matrix.setdefault(b[pk], []).append(
                                {"time": dt, "stage": b_stage, "is_doubles": b_is_doubles}
                            )

                    # ── Seed cascading locks from booked matches ──────
                    b_h = f"{b.get('category_id')}_{b.get('subcategory_id')}_{b_is_doubles}"
                    if b_stage == "Grupos":
                        prev = group_end_dates.get(b_h, start_date.date())
                        if dt.date() > prev:
                            group_end_dates[b_h] = dt.date()
                    elif b_stage == "Eliminatoria":
                        b_round = _extract_round(b)
                        if b_round > 0:
                            rk = f"{b_h}_R{b_round}"
                            prev = eliminatoria_end_dates.get(rk, start_date.date())
                            if dt.date() > prev:
                                eliminatoria_end_dates[rk] = dt.date()

            # ── Population map for queue sorting ──────────────────────
            queue = unscheduled.data
            population_map = defaultdict(int)
            for m in queue:
                h = f"{m.get('category_id')}_{m.get('subcategory_id')}_{m.get('match_type') == 'Dobles'}"
                population_map[h] += 1

            # ── Sort the scheduling queue ─────────────────────────────
            # Priority: Stage → Tier → Population(desc) → Round → Modality
            # This ensures:
            #   1. All group matches before any knockouts
            #   2. Kids (tier 0-1) fill earliest available slots
            #   3. Low-tier (D→C→B) follows
            #   4. High-tier (B+→A→AA) goes last → natural prime-time
            #   5. Larger categories get priority within same tier
            def sort_key(m):
                stage_val = 0 if m.get("stage") == "Grupos" else 1
                round_val = _extract_round(m)
                sc_name = (m.get("subcategories") or {}).get("name", "")
                tier = _SUBCATEGORY_TIER.get(sc_name, 99)
                h = f"{m.get('category_id')}_{m.get('subcategory_id')}_{m.get('match_type') == 'Dobles'}"
                pop = population_map[h]
                dbl = 1 if m.get("match_type") == "Dobles" else 0
                return (stage_val, tier, -pop, round_val, dbl)

            queue.sort(key=sort_key)

            # ── Knockout depth map ────────────────────────────────
            # Compute the deepest round per subcategory so the end-date
            # gravitation can correctly identify semi-finals and finals.
            max_ko_round = defaultdict(int)
            if booked_resp.data:
                for b in booked_resp.data:
                    if b.get("stage") == "Eliminatoria":
                        b_dbl = b.get("match_type") == "Dobles"
                        b_h = f"{b.get('category_id')}_{b.get('subcategory_id')}_{b_dbl}"
                        max_ko_round[b_h] = max(max_ko_round[b_h], _extract_round(b))
            for m in queue:
                if m.get("stage") == "Eliminatoria":
                    h = f"{m.get('category_id')}_{m.get('subcategory_id')}_{m.get('match_type') == 'Dobles'}"
                    max_ko_round[h] = max(max_ko_round[h], _extract_round(m))

            # ── Days remaining tracker for rest-day feasibility ───
            remaining_playable_days = set()
            d = start_date
            while d <= end_date:
                if d.weekday() != 0:  # Not Monday
                    remaining_playable_days.add(d.date())
                d += timedelta(days=1)

            # ── Run the main scheduling pass ──────────────────────
            updates, failed_count, failed_ids, overflow_ids = _run_scheduling_pass(
                queue, slots, courts, start_date, end_date, total_days,
                book_map, scheduled_matrix, day_usage, court_usage,
                group_end_dates, eliminatoria_end_dates, max_ko_round,
                population_map, remaining_playable_days,
                daily_cap=_DAILY_MATCH_CAP_NORMAL,
            )

            # ── Overflow pass: retry failed matches with relaxed cap ──
            overflow_count = 0
            if failed_ids:
                overflow_queue = [m for m in queue if m["id"] in set(failed_ids)]
                if overflow_queue:
                    ov_updates, ov_failed, ov_failed_ids, _ = _run_scheduling_pass(
                        overflow_queue, slots, courts, start_date, end_date, total_days,
                        book_map, scheduled_matrix, day_usage, court_usage,
                        group_end_dates, eliminatoria_end_dates, max_ko_round,
                        population_map, remaining_playable_days,
                        daily_cap=_DAILY_MATCH_CAP_OVERFLOW,
                    )
                    updates.extend(ov_updates)
                    overflow_count = len(ov_updates)
                    failed_count = ov_failed
                    failed_ids = ov_failed_ids

            # ── Persist to database ───────────────────────────────────
            for u in updates:
                supabase.table("matches").update({
                    "court_id": u["court_id"],
                    "scheduled_time": u["scheduled_time"],
                    "status": "Scheduled",
                }).eq("id", u["id"]).execute()

            return {
                "success": True,
                "total_scheduled": len(updates),
                "failed": failed_count,
                "failed_ids": failed_ids,
                "overflow_count": overflow_count,
                "day_distribution": dict(day_usage),
                "court_distribution": {str(k): v for k, v in court_usage.items()},
            }

        except Exception as e:
            print(f"Auto-schedule Error: {e}")
            return {"success": False, "total_scheduled": 0, "failed": 0}

    # ── Schedule Reset ────────────────────────────────────────────────────

    @staticmethod
    def wipe_schedules(tournament_id):
        """Removes all assigned courts and times for a complete reset."""
        try:
            supabase = get_supabase_client()
            supabase.table("matches").update(
                {"court_id": None, "scheduled_time": None, "status": "Pending"}
            ).eq("tournament_id", tournament_id).execute()
            return True
        except Exception as e:
            print(f"Error wiping schedules: {e}")
            return False


# ═══════════════════════════════════════════════════════════════════════════
# Internal Scheduling Pass (shared between normal and overflow)
# ═══════════════════════════════════════════════════════════════════════════

def _run_scheduling_pass(
    queue, slots, courts, start_date, end_date, total_days,
    book_map, scheduled_matrix, day_usage, court_usage,
    group_end_dates, eliminatoria_end_dates, max_ko_round,
    population_map, remaining_playable_days,
    daily_cap=_DAILY_MATCH_CAP_NORMAL,
):
    """
    Core scheduling loop. Evaluates every match in `queue` against every
    available slot, computing a penalty score. The slot with the lowest
    penalty wins.

    Returns (updates, failed_count, failed_ids, overflow_ids).
    """
    updates = []
    failed_count = 0
    failed_ids = []

    for match in queue:
        round_val = _extract_round(match)
        sc_name = (match.get("subcategories") or {}).get("name", "")
        is_prime_match = sc_name in _PRIME_CATS
        is_minors_match = sc_name in _MINORS_CATS

        m_stage = match.get("stage", "Grupos")
        m_is_doubles = match.get("match_type") == "Dobles"
        h_react = f"{match.get('category_id')}_{match.get('subcategory_id')}_{m_is_doubles}"

        # Player IDs for rest-gap penalty calculation
        m_player_ids = [
            match.get(k)
            for k in ["player1_id", "player2_id", "team1_partner_id", "team2_partner_id"]
            if match.get(k)
        ]

        # Knockout round classification
        total_rounds = max_ko_round.get(h_react, round_val)
        is_final = (m_stage == "Eliminatoria" and round_val == total_rounds and total_rounds > 0)
        is_semifinal = (m_stage == "Eliminatoria" and round_val == total_rounds - 1 and total_rounds > 1)
        is_late_ko = is_final or is_semifinal

        # ── Compute rest-day gap for knockout cascading ───────────
        # If tournament has enough remaining days, enforce 1 full rest
        # day between knockout rounds. Otherwise fall back to next-day.
        ko_rest_gap = 1  # Minimum: next calendar day
        if m_stage == "Eliminatoria" and len(remaining_playable_days) > (total_rounds - round_val + 2):
            ko_rest_gap = 2  # 1 full rest day between rounds

        best_slot = None
        best_court = None
        best_score = float("inf")

        for slot in slots:
            dt_val = slot["time"]
            dt_iso = dt_val.isoformat()
            slot_date = dt_val.date()

            # ── Cascading phase locks ─────────────────────────────
            # Eliminatoria cannot begin until its parent phase
            # (groups or prior knockout round) finishes, with a rest gap.
            if m_stage == "Eliminatoria":
                if round_val > 1:
                    parent_end = eliminatoria_end_dates.get(
                        f"{h_react}_R{round_val - 1}"
                    )
                else:
                    parent_end = group_end_dates.get(h_react)

                # Enforce rest gap: slot must be at least `ko_rest_gap`
                # days after the parent phase ends.
                if parent_end and (slot_date - parent_end).days < ko_rest_gap:
                    continue

            # ── Court availability ────────────────────────────────
            available_courts = [
                c for c in courts if f"{c}_{dt_iso}" not in book_map
            ]
            if not available_courts:
                continue

            # ── Constraint check ──────────────────────────────────
            constraint = SchedulingService.check_match_constraints(
                match, dt_val, scheduled_matrix, daily_cap
            )
            if constraint in ("FAIL_SAME_TIME", "FAIL_MAX_GAMES"):
                continue

            # ═════════════════════════════════════════════════════
            # PENALTY SCORING — the lower the score, the better
            # ═════════════════════════════════════════════════════
            penalty = 0

            # P1: Constraint-based soft penalties ──────────────────
            if constraint == "FAIL_SAME_DAY":
                penalty += 5000
            elif constraint == "FAIL_CONSECUTIVE":
                penalty += 4000

            # P2: Day density spread ──────────────────────────────
            # Distributes matches evenly across the tournament
            penalty += day_usage.get(slot_date, 0) * 50

            # P3: Chronological driver (bifurcated by stage) ───────
            days_from_start = (slot_date - start_date.date()).days

            if m_stage == "Grupos":
                # Groups prefer earlier days (front-loading)
                penalty += days_from_start * 300
            elif is_late_ko:
                # Semi-finals and Finals gravitate toward the end
                if is_final:
                    target_date = end_date.date()
                else:
                    target_date = end_date.date() - timedelta(days=1)
                distance = abs((slot_date - target_date).days)
                penalty += distance * 2000
            else:
                # Early knockout rounds: schedule ASAP after groups resolve.
                # The cascading locks handle sequencing; this penalty just
                # prefers sooner available dates over later ones.
                penalty += days_from_start * 200

            # P4: Insufficient rest penalty ───────────────────────
            # Penalizes back-to-back slots for the same player.
            for pid in m_player_ids:
                for pm in scheduled_matrix.get(pid, []):
                    if pm["time"].date() == slot_date:
                        gap_min = abs((dt_val - pm["time"]).total_seconds()) / 60
                        if gap_min == _SLOT_MIN:  # Back-to-back: 0 actual rest
                            penalty += 3000

            # P5: Category-specific time preferences ──────────────
            if is_minors_match:
                # Kids: strongly prefer early morning slots (9-10AM range)
                penalty += max(0, dt_val.hour - 10) * 2000
            elif is_prime_match:
                # AA/A/B+ prefer prime-time (19:00+) slots
                if not slot["is_prime"]:
                    penalty += 2500
                # Small gradient favoring later hours
                penalty += (24 - dt_val.hour) * 20
            else:
                # Neutral categories: slight avoidance of prime weekday slots
                if slot["is_prime"] and dt_val.weekday() < 5:
                    penalty += 1000
                # Mild preference for mid-afternoon
                penalty += abs(dt_val.hour - 16) * 30

            # ── Select best slot + court ──────────────────────────
            if penalty < best_score:
                best_score = penalty
                best_slot = slot
                # Load-balanced court selection: pick the least-used court
                best_court = min(
                    available_courts,
                    key=lambda c: court_usage.get(c, 0)
                )

        # ── Commit assignment ─────────────────────────────────────
        if best_slot and best_court:
            dt_val = best_slot["time"]
            dt_iso = dt_val.isoformat()
            slot_date = dt_val.date()

            updates.append({
                "id": match["id"],
                "court_id": best_court,
                "scheduled_time": dt_iso,
                "status": "Scheduled",
            })

            book_map.add(f"{best_court}_{dt_iso}")
            day_usage[slot_date] += 1
            court_usage[best_court] += 1

            # Update cascading reactivity maps
            if m_stage == "Grupos":
                prev = group_end_dates.get(h_react, start_date.date())
                if slot_date > prev:
                    group_end_dates[h_react] = slot_date
            elif m_stage == "Eliminatoria":
                rk = f"{h_react}_R{round_val}"
                prev = eliminatoria_end_dates.get(rk, start_date.date())
                if slot_date > prev:
                    eliminatoria_end_dates[rk] = slot_date

            # Update player fatigue matrix
            for pk in ["player1_id", "player2_id", "team1_partner_id", "team2_partner_id"]:
                pid = match.get(pk)
                if pid:
                    scheduled_matrix.setdefault(pid, []).append(
                        {"time": dt_val, "stage": m_stage, "is_doubles": m_is_doubles}
                    )
        else:
            failed_count += 1
            failed_ids.append(match["id"])

    return updates, failed_count, failed_ids, failed_ids
