"""
Ranking Service — Core business logic for the Ladder Ranking System.

Handles:
  - Ladder CRUD (add/remove/reorder players)
  - Pairing generation (challenge/defend weeks)
  - Weekly scheduling (assigns matches to time slots)
  - Match result processing (position swaps)
  - Sub-category boundary management
"""
from datetime import datetime, timedelta, time, date as date_type
from collections import defaultdict
from utils.supabase_client import get_supabase_client
from core.scheduling_utils import (
    generate_time_slots,
    is_club_closed,
    SLOT_DURATION_MINUTES,
)


class RankingService:
    """Static methods for all ranking operations."""

    # ═══════════════════════════════════════════════════════════
    # LADDER READS
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def get_current_ladder(category_id):
        """
        Fetch the full ordered ladder with player names and sub-category labels.

        Returns list of dicts:
            [{position, player_id, first_name, last_name, subcategory, is_active}, ...]
        """
        supabase = get_supabase_client()

        # 1. Fetch ladder entries with player names
        resp = (
            supabase.table("ranking_ladders")
            .select("position, player_id, is_active, players(first_name, last_name)")
            .eq("category_id", category_id)
            .eq("is_active", True)
            .order("position")
            .execute()
        )
        ladder = resp.data or []

        # 2. Fetch sub-category ranges
        ranges = RankingService.get_subcategory_ranges(category_id)

        # 3. Merge: assign sub-category label based on position
        for entry in ladder:
            player = entry.get("players", {}) or {}
            entry["first_name"] = player.get("first_name", "")
            entry["last_name"] = player.get("last_name", "")
            entry["subcategory"] = ""
            for r in ranges:
                if r["position_start"] <= entry["position"] <= r["position_end"]:
                    entry["subcategory"] = r.get("subcategory_name", "")
                    break

        return ladder

    @staticmethod
    def get_ladder_player_ids(category_id):
        """Return set of player_ids currently in the ladder for a category."""
        supabase = get_supabase_client()
        resp = (
            supabase.table("ranking_ladders")
            .select("player_id")
            .eq("category_id", category_id)
            .execute()
        )
        return {r["player_id"] for r in (resp.data or [])}

    # ═══════════════════════════════════════════════════════════
    # LADDER MUTATIONS
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def add_player_to_ladder(category_id, player_id, position):
        """
        Insert a player at a specific position.
        Shifts all players at position >= target down by 1.
        """
        supabase = get_supabase_client()

        # 1. Fetch players at or below this position (bottom-up to avoid unique constraint)
        resp = (
            supabase.table("ranking_ladders")
            .select("id, position")
            .eq("category_id", category_id)
            .gte("position", position)
            .order("position", desc=True)
            .execute()
        )

        # 2. Shift each one down (from bottom up)
        for entry in (resp.data or []):
            supabase.table("ranking_ladders").update(
                {"position": entry["position"] + 1}
            ).eq("id", entry["id"]).execute()

        # 3. Insert the new player
        supabase.table("ranking_ladders").insert({
            "category_id": category_id,
            "player_id": player_id,
            "position": position,
            "is_active": True,
        }).execute()

    @staticmethod
    def remove_player_from_ladder(category_id, player_id):
        """
        Remove a player and compact positions (shift everyone below up by 1).
        """
        supabase = get_supabase_client()

        # 1. Get the player's current position
        resp = (
            supabase.table("ranking_ladders")
            .select("id, position")
            .eq("category_id", category_id)
            .eq("player_id", player_id)
            .execute()
        )
        if not resp.data:
            return

        removed_pos = resp.data[0]["position"]
        removed_id = resp.data[0]["id"]

        # 2. Delete the entry
        supabase.table("ranking_ladders").delete().eq("id", removed_id).execute()

        # 3. Shift everyone below up by 1 (top-down order)
        below = (
            supabase.table("ranking_ladders")
            .select("id, position")
            .eq("category_id", category_id)
            .gt("position", removed_pos)
            .order("position")
            .execute()
        )
        for entry in (below.data or []):
            supabase.table("ranking_ladders").update(
                {"position": entry["position"] - 1}
            ).eq("id", entry["id"]).execute()

    @staticmethod
    def reorder_player(category_id, player_id, new_position):
        """
        Move a player to a new position. Shifts affected players accordingly.
        """
        supabase = get_supabase_client()

        # 1. Get current position
        resp = (
            supabase.table("ranking_ladders")
            .select("id, position")
            .eq("category_id", category_id)
            .eq("player_id", player_id)
            .execute()
        )
        if not resp.data:
            return
        old_pos = resp.data[0]["position"]
        entry_id = resp.data[0]["id"]

        if old_pos == new_position:
            return

        # 2. Temporarily move to sentinel position
        supabase.table("ranking_ladders").update(
            {"position": -1}
        ).eq("id", entry_id).execute()

        # 3. Shift affected players
        if new_position < old_pos:
            # Moving UP: shift players in [new_pos, old_pos-1] down by 1
            affected = (
                supabase.table("ranking_ladders")
                .select("id, position")
                .eq("category_id", category_id)
                .gte("position", new_position)
                .lte("position", old_pos - 1)
                .order("position", desc=True)
                .execute()
            )
            for e in (affected.data or []):
                supabase.table("ranking_ladders").update(
                    {"position": e["position"] + 1}
                ).eq("id", e["id"]).execute()
        else:
            # Moving DOWN: shift players in [old_pos+1, new_pos] up by 1
            affected = (
                supabase.table("ranking_ladders")
                .select("id, position")
                .eq("category_id", category_id)
                .gte("position", old_pos + 1)
                .lte("position", new_position)
                .order("position")
                .execute()
            )
            for e in (affected.data or []):
                supabase.table("ranking_ladders").update(
                    {"position": e["position"] - 1}
                ).eq("id", e["id"]).execute()

        # 4. Place player at new position
        supabase.table("ranking_ladders").update(
            {"position": new_position}
        ).eq("id", entry_id).execute()

    # ═══════════════════════════════════════════════════════════
    # PAIRING ENGINE
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def generate_pairings(ladder, phase):
        """
        Generate match pairings from an ordered ladder based on week phase.

        Args:
            ladder: list of dicts with at least {player_id, position}, sorted by position.
            phase:  'challenge' or 'defend'.

        Returns:
            (pairings, resting)
            pairings: list of (defender_id, defender_pos, challenger_id, challenger_pos)
            resting:  list of player_ids who rest this week
        """
        if not ladder:
            return [], []

        positions = [(p["player_id"], p["position"]) for p in ladder]
        pairings = []
        resting = []

        if phase == "challenge":
            # #1 rests, then pairs: (2,3), (4,5), (6,7), ...
            resting.append(positions[0][0])
            remaining = positions[1:]
        else:
            # Defend: pairs (1,2), (3,4), (5,6), ...
            remaining = positions

        # Pair adjacent players
        i = 0
        while i + 1 < len(remaining):
            defender_id, defender_pos = remaining[i]
            challenger_id, challenger_pos = remaining[i + 1]
            pairings.append((defender_id, defender_pos, challenger_id, challenger_pos))
            i += 2

        # Odd player out rests
        if i < len(remaining):
            resting.append(remaining[i][0])

        return pairings, resting

    # ═══════════════════════════════════════════════════════════
    # WEEK MANAGEMENT
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def determine_next_phase(category_id):
        """
        Determines phase for the next week. Alternates challenge/defend.
        First week defaults to 'challenge'.
        Returns (next_week_number, next_phase).
        """
        supabase = get_supabase_client()
        resp = (
            supabase.table("ranking_weeks")
            .select("week_number, phase")
            .eq("category_id", category_id)
            .order("week_number", desc=True)
            .limit(1)
            .execute()
        )
        if not resp.data:
            return 1, "challenge"

        last = resp.data[0]
        next_num = last["week_number"] + 1
        next_phase = "defend" if last["phase"] == "challenge" else "challenge"
        return next_num, next_phase

    @staticmethod
    def create_week(category_id, week_number, phase, config):
        """
        Create a ranking week with schedule configuration.

        Args:
            config: dict with keys:
                weekday_first_game, weekday_last_game,
                weekend_first_game, weekend_last_game,
                num_courts, week_start_date, week_end_date
        """
        supabase = get_supabase_client()
        resp = supabase.table("ranking_weeks").insert({
            "category_id": category_id,
            "week_number": week_number,
            "phase": phase,
            "weekday_first_game": config["weekday_first_game"],
            "weekday_last_game": config["weekday_last_game"],
            "weekend_first_game": config["weekend_first_game"],
            "weekend_last_game": config["weekend_last_game"],
            "num_courts": config["num_courts"],
            "week_start_date": str(config["week_start_date"]),
            "week_end_date": str(config["week_end_date"]),
        }).execute()
        return resp.data[0] if resp.data else None

    @staticmethod
    def schedule_ranking_week(week_id, pairings, week_data):
        """
        Assign matches to time slots across the week (Tue-Sun).
        Simple sequential fill — no penalty engine needed since each
        player plays at most once per week.

        Args:
            week_id:   UUID of the ranking_week.
            pairings:  list of (defender_id, def_pos, challenger_id, chal_pos).
            week_data: dict with schedule config from ranking_weeks row.
        """
        supabase = get_supabase_client()

        # Parse time configs
        def parse_time(t):
            if isinstance(t, time):
                return t
            if isinstance(t, str):
                parts = t.split(":")
                return time(int(parts[0]), int(parts[1]))
            return t

        wd_first = parse_time(week_data["weekday_first_game"])
        wd_last = parse_time(week_data["weekday_last_game"])
        we_first = parse_time(week_data["weekend_first_game"])
        we_last = parse_time(week_data["weekend_last_game"])
        num_courts = week_data["num_courts"]

        start = datetime.strptime(str(week_data["week_start_date"]), "%Y-%m-%d").date()
        end = datetime.strptime(str(week_data["week_end_date"]), "%Y-%m-%d").date()

        # Build slot grid: [(date, time, court_number), ...]
        all_slots = []
        current_date = start
        while current_date <= end:
            if is_club_closed(current_date):
                current_date += timedelta(days=1)
                continue

            weekday = current_date.weekday()
            if weekday <= 4:
                first_g, last_g = wd_first, wd_last
            else:
                first_g, last_g = we_first, we_last

            day_slots = generate_time_slots(current_date, first_g, last_g)
            for slot_dt in day_slots:
                for court in range(1, num_courts + 1):
                    all_slots.append((current_date, slot_dt.time(), court))

            current_date += timedelta(days=1)

        # Assign matches to slots sequentially
        matches_to_insert = []
        for i, (def_id, def_pos, chal_id, chal_pos) in enumerate(pairings):
            match_row = {
                "week_id": week_id,
                "defender_id": def_id,
                "challenger_id": chal_id,
                "defender_position": def_pos,
                "challenger_position": chal_pos,
            }
            if i < len(all_slots):
                s_date, s_time, s_court = all_slots[i]
                match_row["scheduled_date"] = str(s_date)
                match_row["scheduled_time"] = s_time.strftime("%H:%M")
                match_row["court_number"] = s_court

            matches_to_insert.append(match_row)

        if matches_to_insert:
            supabase.table("ranking_matches").insert(matches_to_insert).execute()

        return len(matches_to_insert)

    # ═══════════════════════════════════════════════════════════
    # MATCH RESULTS
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def apply_match_result(match_id, winner_id, scores, is_forfeit=False, entered_by=None):
        """
        Process a single match result.

        1. Updates ranking_matches with scores + winner.
        2. If challenger won → swap positions in ranking_ladders.
        3. If defender won → no position change.

        Args:
            match_id:   UUID of the ranking_match.
            winner_id:  UUID of the winning player.
            scores:     dict with keys: set1_defender, set1_challenger,
                        set2_defender, set2_challenger, set3_defender, set3_challenger.
            is_forfeit: bool — if True, scores represent a forfeit (6-0 6-0).
            entered_by: UUID of the coach entering the result (auth.users.id).

        Returns:
            dict with {swapped: bool, new_defender_pos, new_challenger_pos}
        """
        supabase = get_supabase_client()

        # 1. Fetch the match details
        match_resp = (
            supabase.table("ranking_matches")
            .select("*, ranking_weeks(category_id)")
            .eq("id", match_id)
            .execute()
        )
        if not match_resp.data:
            return {"swapped": False, "error": "Match not found"}

        match = match_resp.data[0]
        category_id = match["ranking_weeks"]["category_id"]
        defender_id = match["defender_id"]
        challenger_id = match["challenger_id"]
        defender_pos = match["defender_position"]
        challenger_pos = match["challenger_position"]

        # 2. Update match record
        update_data = {
            "winner_id": winner_id,
            "is_forfeit": is_forfeit,
            "is_completed": True,
            "completed_at": datetime.utcnow().isoformat(),
            **scores,
        }
        if entered_by:
            update_data["entered_by"] = entered_by

        supabase.table("ranking_matches").update(update_data).eq("id", match_id).execute()

        # 3. Position swap logic
        swapped = False
        if winner_id == challenger_id:
            # Challenger wins → SWAP positions
            # Use sentinel position to avoid unique constraint violation
            supabase.table("ranking_ladders").update(
                {"position": -1}
            ).eq("category_id", category_id).eq("player_id", challenger_id).execute()

            supabase.table("ranking_ladders").update(
                {"position": challenger_pos}
            ).eq("category_id", category_id).eq("player_id", defender_id).execute()

            supabase.table("ranking_ladders").update(
                {"position": defender_pos}
            ).eq("category_id", category_id).eq("player_id", challenger_id).execute()

            swapped = True

        return {
            "swapped": swapped,
            "new_defender_pos": challenger_pos if swapped else defender_pos,
            "new_challenger_pos": defender_pos if swapped else challenger_pos,
        }

    @staticmethod
    def complete_week(week_id):
        """
        Mark a week as completed. Apply forfeit (6-0 6-0) to any
        incomplete matches where one player showed up.
        """
        supabase = get_supabase_client()

        # Fetch incomplete matches
        resp = (
            supabase.table("ranking_matches")
            .select("id, defender_id, challenger_id")
            .eq("week_id", week_id)
            .eq("is_completed", False)
            .execute()
        )

        # Auto-forfeit: for simplicity, defender wins by default on incomplete
        # (coaches should have manually entered forfeits for no-shows)
        for match in (resp.data or []):
            RankingService.apply_match_result(
                match["id"],
                match["defender_id"],
                {
                    "set1_defender": 6, "set1_challenger": 0,
                    "set2_defender": 6, "set2_challenger": 0,
                    "set3_defender": None, "set3_challenger": None,
                },
                is_forfeit=True,
            )

        # Mark week complete
        supabase.table("ranking_weeks").update(
            {"is_completed": True}
        ).eq("id", week_id).execute()

    # ═══════════════════════════════════════════════════════════
    # MATCH & WEEK READS
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def get_week_matches(week_id):
        """Fetch all matches for a week with player names."""
        supabase = get_supabase_client()
        resp = (
            supabase.table("ranking_matches")
            .select(
                "*, "
                "defender:players!defender_id(first_name, last_name), "
                "challenger:players!challenger_id(first_name, last_name)"
            )
            .eq("week_id", week_id)
            .order("scheduled_date")
            .order("scheduled_time")
            .order("court_number")
            .execute()
        )
        return resp.data or []

    @staticmethod
    def get_weeks(category_id, limit=20):
        """Fetch recent weeks for a category, newest first."""
        supabase = get_supabase_client()
        resp = (
            supabase.table("ranking_weeks")
            .select("*")
            .eq("category_id", category_id)
            .order("week_number", desc=True)
            .limit(limit)
            .execute()
        )
        return resp.data or []

    # ═══════════════════════════════════════════════════════════
    # SUB-CATEGORY BOUNDARIES
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def get_subcategory_ranges(category_id):
        """Fetch sub-category boundary definitions with names."""
        supabase = get_supabase_client()
        resp = (
            supabase.table("ranking_subcategory_ranges")
            .select("*, subcategories(name)")
            .eq("category_id", category_id)
            .order("position_start")
            .execute()
        )
        result = []
        for r in (resp.data or []):
            r["subcategory_name"] = (r.get("subcategories") or {}).get("name", "")
            result.append(r)
        return result

    @staticmethod
    def save_subcategory_ranges(category_id, ranges):
        """
        Save sub-category boundary definitions.

        Args:
            ranges: list of dicts with {subcategory_id, position_start, position_end}
        """
        supabase = get_supabase_client()

        # Delete existing ranges for this category
        supabase.table("ranking_subcategory_ranges").delete().eq(
            "category_id", category_id
        ).execute()

        # Insert new ranges
        rows = [
            {
                "category_id": category_id,
                "subcategory_id": r["subcategory_id"],
                "position_start": r["position_start"],
                "position_end": r["position_end"],
            }
            for r in ranges
        ]
        if rows:
            supabase.table("ranking_subcategory_ranges").insert(rows).execute()

    # ═══════════════════════════════════════════════════════════
    # SEASON ARCHIVE & RESET
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def archive_season(category_id, season_name, ended_by=None):
        """
        Snapshot the current ranking state into ranking_seasons.

        Stores:
          - final_ladder: full ordered ladder with player names + subcategory
          - weekly_results: all weeks with their match details and scores

        Returns the created season row or None on failure.
        """
        supabase = get_supabase_client()

        # 1. Snapshot the final ladder
        ladder = RankingService.get_current_ladder(category_id)
        ladder_snapshot = [
            {
                "position": entry["position"],
                "player_id": entry["player_id"],
                "first_name": entry["first_name"],
                "last_name": entry["last_name"],
                "subcategory": entry.get("subcategory", ""),
            }
            for entry in ladder
        ]

        # 2. Snapshot all weeks and their matches
        weeks = RankingService.get_weeks(category_id, limit=999)
        weekly_snapshot = []
        for w in weeks:
            matches = RankingService.get_week_matches(w["id"])
            matches_clean = []
            for m in matches:
                defender = m.get("defender", {}) or {}
                challenger = m.get("challenger", {}) or {}
                matches_clean.append({
                    "defender": {
                        "player_id": m["defender_id"],
                        "position": m["defender_position"],
                        "first_name": defender.get("first_name", ""),
                        "last_name": defender.get("last_name", ""),
                    },
                    "challenger": {
                        "player_id": m["challenger_id"],
                        "position": m["challenger_position"],
                        "first_name": challenger.get("first_name", ""),
                        "last_name": challenger.get("last_name", ""),
                    },
                    "scores": {
                        "set1_defender": m.get("set1_defender"),
                        "set1_challenger": m.get("set1_challenger"),
                        "set2_defender": m.get("set2_defender"),
                        "set2_challenger": m.get("set2_challenger"),
                        "set3_defender": m.get("set3_defender"),
                        "set3_challenger": m.get("set3_challenger"),
                    },
                    "winner_id": m.get("winner_id"),
                    "is_forfeit": m.get("is_forfeit", False),
                    "is_completed": m.get("is_completed", False),
                    "scheduled_date": str(m.get("scheduled_date", "")),
                    "scheduled_time": str(m.get("scheduled_time", ""))[:5] if m.get("scheduled_time") else None,
                    "court_number": m.get("court_number"),
                })

            weekly_snapshot.append({
                "week_number": w["week_number"],
                "phase": w["phase"],
                "week_start_date": str(w.get("week_start_date", "")),
                "week_end_date": str(w.get("week_end_date", "")),
                "is_completed": w.get("is_completed", False),
                "matches": matches_clean,
            })

        # 3. Insert the season record
        import json
        row = {
            "category_id": category_id,
            "season_name": season_name,
            "total_weeks": len(weeks),
            "final_ladder": json.dumps(ladder_snapshot),
            "weekly_results": json.dumps(weekly_snapshot),
        }
        if ended_by:
            row["ended_by"] = ended_by

        resp = supabase.table("ranking_seasons").insert(row).execute()
        return resp.data[0] if resp.data else None

    @staticmethod
    def reset_ranking(category_id):
        """
        Wipe all live ranking data for a category:
          1. ranking_matches (via CASCADE from ranking_weeks)
          2. ranking_weeks
          3. ranking_ladders
          4. ranking_subcategory_ranges

        Returns True on success.
        """
        supabase = get_supabase_client()
        try:
            # ranking_matches cascade-delete via ranking_weeks FK
            supabase.table("ranking_weeks").delete().eq(
                "category_id", category_id
            ).execute()

            supabase.table("ranking_ladders").delete().eq(
                "category_id", category_id
            ).execute()

            supabase.table("ranking_subcategory_ranges").delete().eq(
                "category_id", category_id
            ).execute()

            return True
        except Exception as e:
            print(f"Error resetting ranking: {e}")
            return False
