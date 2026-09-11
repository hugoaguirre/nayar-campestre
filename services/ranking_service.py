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
import random
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
    def get_weeks(category_id, limit=10):
        """
        Fetch recent ranking weeks for a category, newest first.

        Args:
            category_id: UUID of the ranking category.
            limit: max number of weeks to return (default 10).

        Returns:
            List of ranking_weeks rows ordered by week_number descending.
        """
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

    @staticmethod
    def create_week(category_id, week_number, phase, config):
        """
        Create a ranking week with schedule configuration.

        Args:
            config: dict with keys:
                weekday_first_game, weekday_last_game,
                saturday_first_game, saturday_last_game,
                sunday_first_game, sunday_last_game,
                num_courts, week_start_date, week_end_date
        """
        supabase = get_supabase_client()
        resp = supabase.table("ranking_weeks").insert({
            "category_id": category_id,
            "week_number": week_number,
            "phase": phase,
            "weekday_first_game": config["weekday_first_game"],
            "weekday_last_game": config["weekday_last_game"],
            "saturday_first_game": config["saturday_first_game"],
            "saturday_last_game": config["saturday_last_game"],
            "sunday_first_game": config["sunday_first_game"],
            "sunday_last_game": config["sunday_last_game"],
            "num_courts": config["num_courts"],
            "week_start_date": str(config["week_start_date"]),
            "week_end_date": str(config["week_end_date"]),
        }).execute()
        return resp.data[0] if resp.data else None

    @staticmethod
    def schedule_ranking_week(week_id, pairings, week_data, preview_matches=None):
        """
        Assign matches to time slots across the week (Tue-Sun).
        If preview_matches is provided, inserts those exact previewed match pairings
        and slot allocations. Otherwise, dynamically builds slots and shuffles pairings.

        Args:
            week_id:          UUID of the ranking_week.
            pairings:         list of (defender_id, def_pos, challenger_id, chal_pos).
            week_data:        dict with schedule config from ranking_weeks row.
            preview_matches:  optional list of pre-scheduled match dicts.
        """
        supabase = get_supabase_client()

        if preview_matches:
            matches_to_insert = []
            for m in preview_matches:
                match_row = {
                    "week_id": week_id,
                    "defender_id": m["defender_id"],
                    "challenger_id": m["challenger_id"],
                    "defender_position": m["defender_position"],
                    "challenger_position": m["challenger_position"],
                    "scheduled_date": m.get("scheduled_date"),
                    "scheduled_time": m.get("scheduled_time"),
                    "court_number": m.get("court_number"),
                }
                matches_to_insert.append(match_row)

            if matches_to_insert:
                supabase.table("ranking_matches").insert(matches_to_insert).execute()

            return len(matches_to_insert)

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
        sat_first = parse_time(week_data["saturday_first_game"])
        sat_last = parse_time(week_data["saturday_last_game"])
        sun_first = parse_time(week_data["sunday_first_game"])
        sun_last = parse_time(week_data["sunday_last_game"])
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
            # Tue(1)–Thu(3) = weekday config; Fri(4) = closed; Sat(5); Sun(6)
            if weekday == 4:
                current_date += timedelta(days=1)
                continue
            elif weekday == 5:
                first_g, last_g = sat_first, sat_last
            elif weekday == 6:
                first_g, last_g = sun_first, sun_last
            else:
                first_g, last_g = wd_first, wd_last

            day_slots = generate_time_slots(current_date, first_g, last_g)
            for slot_dt in day_slots:
                for court in range(1, num_courts + 1):
                    all_slots.append((current_date, slot_dt.time(), court))

            current_date += timedelta(days=1)

        # Shuffle pairings so slot assignments vary each week
        pairings = list(pairings)
        random.shuffle(pairings)

        # Assign matches to slots
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

    @staticmethod
    def preview_schedule(ladder, phase, config):
        """
        Build a preview of the scheduled matches WITHOUT writing to the DB.

        Uses the same pairing + slot-building logic as the real scheduler,
        but returns in-memory match dicts ready for PDF generation.

        Args:
            ladder: ordered ladder list (from get_current_ladder).
            phase:  'challenge' or 'defend'.
            config: dict with weekday_first_game, weekday_last_game,
                    saturday_first_game, saturday_last_game,
                    sunday_first_game, sunday_last_game,
                    num_courts, week_start_date, week_end_date.

        Returns:
            (preview_matches, resting_ids)
            preview_matches: list of dicts matching get_week_matches() shape.
            resting_ids: list of player_ids who rest this week.
        """
        pairings, resting = RankingService.generate_pairings(ladder, phase)

        # Parse time configs
        def parse_time(t):
            if isinstance(t, time):
                return t
            if isinstance(t, str):
                parts = t.split(":")
                return time(int(parts[0]), int(parts[1]))
            return t

        wd_first = parse_time(config["weekday_first_game"])
        wd_last = parse_time(config["weekday_last_game"])
        sat_first = parse_time(config["saturday_first_game"])
        sat_last = parse_time(config["saturday_last_game"])
        sun_first = parse_time(config["sunday_first_game"])
        sun_last = parse_time(config["sunday_last_game"])
        num_courts = config["num_courts"]

        start = config["week_start_date"]
        end = config["week_end_date"]
        if isinstance(start, str):
            start = datetime.strptime(start, "%Y-%m-%d").date()
        if isinstance(end, str):
            end = datetime.strptime(end, "%Y-%m-%d").date()

        # Build slot grid
        all_slots = []
        current_date = start
        while current_date <= end:
            if is_club_closed(current_date):
                current_date += timedelta(days=1)
                continue
            weekday = current_date.weekday()
            # Tue(1)–Thu(3) = weekday config; Fri(4) = closed; Sat(5); Sun(6)
            if weekday == 4:
                current_date += timedelta(days=1)
                continue
            elif weekday == 5:
                first_g, last_g = sat_first, sat_last
            elif weekday == 6:
                first_g, last_g = sun_first, sun_last
            else:
                first_g, last_g = wd_first, wd_last

            day_slots = generate_time_slots(current_date, first_g, last_g)
            for slot_dt in day_slots:
                for court in range(1, num_courts + 1):
                    all_slots.append((current_date, slot_dt.time(), court))
            current_date += timedelta(days=1)

        # Build player name lookup from ladder
        player_map = {}
        for entry in ladder:
            player_map[entry["player_id"]] = {
                "first_name": entry.get("first_name", ""),
                "last_name": entry.get("last_name", ""),
            }

        # Shuffle pairings so slot assignments vary each week
        pairings = list(pairings)
        random.shuffle(pairings)

        # Assign pairings to slots
        preview_matches = []
        for i, (def_id, def_pos, chal_id, chal_pos) in enumerate(pairings):
            m = {
                "defender_id": def_id,
                "challenger_id": chal_id,
                "defender_position": def_pos,
                "challenger_position": chal_pos,
                "defender": player_map.get(def_id, {}),
                "challenger": player_map.get(chal_id, {}),
                "is_completed": False,
            }
            if i < len(all_slots):
                s_date, s_time, s_court = all_slots[i]
                m["scheduled_date"] = str(s_date)
                m["scheduled_time"] = s_time.strftime("%H:%M")
                m["court_number"] = s_court
            else:
                m["scheduled_date"] = None
                m["scheduled_time"] = None
                m["court_number"] = None

            preview_matches.append(m)

        return preview_matches, resting

    @staticmethod
    def delete_week(week_id):
        """
        Delete a ranking week and all its matches.

        Only safe to call on weeks where no matches have been completed
        (caller must verify this before calling).

        Returns True on success.
        """
        supabase = get_supabase_client()
        try:
            # 1. Delete all matches for this week
            supabase.table("ranking_matches").delete().eq(
                "week_id", week_id
            ).execute()

            # 2. Delete the week itself
            supabase.table("ranking_weeks").delete().eq(
                "id", week_id
            ).execute()

            return True
        except Exception as e:
            print(f"Error deleting week: {e}")
            return False

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
            try:
                # Re-fetch CURRENT positions from the ladder (they may have
                # shifted if earlier matches in the same batch triggered swaps).
                def_row = (
                    supabase.table("ranking_ladders")
                    .select("id, position")
                    .eq("category_id", category_id)
                    .eq("player_id", defender_id)
                    .limit(1)
                    .execute()
                )
                chal_row = (
                    supabase.table("ranking_ladders")
                    .select("id, position")
                    .eq("category_id", category_id)
                    .eq("player_id", challenger_id)
                    .limit(1)
                    .execute()
                )

                if not def_row.data or not chal_row.data:
                    print(f"Swap skipped — player not found in ladder for match {match_id}")
                    return {"swapped": False, "error": "Player not found in ladder"}

                live_def_pos = def_row.data[0]["position"]
                live_chal_pos = chal_row.data[0]["position"]
                def_entry_id = def_row.data[0]["id"]
                chal_entry_id = chal_row.data[0]["id"]

                # Clean up any stale sentinel positions from interrupted swaps
                supabase.table("ranking_ladders").delete().eq(
                    "category_id", category_id
                ).eq("position", -1).execute()

                # Use sentinel position to avoid unique constraint violation
                supabase.table("ranking_ladders").update(
                    {"position": -1}
                ).eq("id", chal_entry_id).execute()

                supabase.table("ranking_ladders").update(
                    {"position": live_chal_pos}
                ).eq("id", def_entry_id).execute()

                supabase.table("ranking_ladders").update(
                    {"position": live_def_pos}
                ).eq("id", chal_entry_id).execute()

                swapped = True
            except Exception as e:
                print(f"Position swap error for match {match_id}: {e}")
                return {"swapped": False, "error": f"Position swap failed: {e}"}

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
    # DRAFT RESULTS (staging layer before commit)
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def save_draft_result(match_id, winner_id, scores, is_forfeit=False, entered_by=None):
        """
        Upsert a draft result into ranking_match_drafts.

        This stores scores temporarily — nothing is written to ranking_matches
        or ranking_ladders until commit_week_drafts() is called.

        Args:
            match_id:   UUID of the ranking_match.
            winner_id:  UUID of the winning player.
            scores:     dict with set1_defender, set1_challenger, etc.
            is_forfeit: bool.
            entered_by: UUID of the coach (auth.users.id).

        Returns:
            The upserted draft row, or None on failure.
        """
        supabase = get_supabase_client()

        draft_row = {
            "match_id": match_id,
            "winner_id": winner_id,
            "is_forfeit": is_forfeit,
            **scores,
        }
        if entered_by:
            draft_row["entered_by"] = entered_by

        try:
            resp = (
                supabase.table("ranking_match_drafts")
                .upsert(draft_row, on_conflict="match_id")
                .execute()
            )
            return resp.data[0] if resp.data else None
        except Exception as e:
            print(f"Error saving draft: {e}")
            return None

    @staticmethod
    def get_week_drafts(week_id):
        """
        Fetch all draft results for a given week.

        Joins through ranking_matches.week_id to find all drafts
        belonging to matches in this week.

        Returns:
            dict mapping match_id → draft row.
        """
        supabase = get_supabase_client()

        # First get all match IDs for this week
        matches_resp = (
            supabase.table("ranking_matches")
            .select("id")
            .eq("week_id", week_id)
            .execute()
        )
        match_ids = [m["id"] for m in (matches_resp.data or [])]
        if not match_ids:
            return {}

        # Fetch drafts for these matches
        drafts_resp = (
            supabase.table("ranking_match_drafts")
            .select("*")
            .in_("match_id", match_ids)
            .execute()
        )

        return {d["match_id"]: d for d in (drafts_resp.data or [])}

    @staticmethod
    def get_draft_for_match(match_id):
        """
        Fetch a single draft for a specific match.

        Returns:
            Draft row dict, or None if no draft exists.
        """
        supabase = get_supabase_client()
        resp = (
            supabase.table("ranking_match_drafts")
            .select("*")
            .eq("match_id", match_id)
            .limit(1)
            .execute()
        )
        return resp.data[0] if resp.data else None

    @staticmethod
    def commit_week_drafts(week_id, entered_by=None):
        """
        Batch-commit all drafts for a week.

        For each draft:
          1. Calls apply_match_result() (writes to ranking_matches + swaps positions).
          2. Deletes the draft row.

        Processes matches in position order (highest-ranked first) to ensure
        consistent swap behavior.

        Args:
            week_id:    UUID of the ranking_week.
            entered_by: UUID of the coach.

        Returns:
            dict with {committed: int, errors: list[str]}
        """
        supabase = get_supabase_client()
        drafts_map = RankingService.get_week_drafts(week_id)

        if not drafts_map:
            return {"committed": 0, "errors": []}

        # Fetch match details to sort by defender_position (highest rank first)
        matches_resp = (
            supabase.table("ranking_matches")
            .select("id, defender_position")
            .in_("id", list(drafts_map.keys()))
            .order("defender_position")
            .execute()
        )
        ordered_match_ids = [m["id"] for m in (matches_resp.data or [])]

        committed = 0
        errors = []

        for match_id in ordered_match_ids:
            draft = drafts_map.get(match_id)
            if not draft:
                continue

            scores = {
                "set1_defender": draft.get("set1_defender"),
                "set1_challenger": draft.get("set1_challenger"),
                "set2_defender": draft.get("set2_defender"),
                "set2_challenger": draft.get("set2_challenger"),
                "set3_defender": draft.get("set3_defender"),
                "set3_challenger": draft.get("set3_challenger"),
            }

            try:
                result = RankingService.apply_match_result(
                    match_id,
                    draft["winner_id"],
                    scores,
                    is_forfeit=draft.get("is_forfeit", False),
                    entered_by=entered_by,
                )

                if result.get("error"):
                    errors.append(f"Match {match_id}: {result['error']}")
                else:
                    committed += 1
            except Exception as e:
                errors.append(f"Match {match_id}: {e}")

            # Delete the draft after successful commit
            try:
                supabase.table("ranking_match_drafts").delete().eq(
                    "match_id", match_id
                ).execute()
            except Exception as e:
                errors.append(f"Draft cleanup {match_id}: {e}")

        return {"committed": committed, "errors": errors}

    @staticmethod
    def delete_draft(match_id):
        """
        Delete a single draft result.

        Returns True on success.
        """
        supabase = get_supabase_client()
        try:
            supabase.table("ranking_match_drafts").delete().eq(
                "match_id", match_id
            ).execute()
            return True
        except Exception as e:
            print(f"Error deleting draft: {e}")
            return False

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
    def get_player_recent_matches(player_id, limit=5):
        """
        Fetch completed recent matches for a specific player (as defender or challenger).

        Returns list of match dicts with parsed opponent info, set scores, and outcome.
        """
        supabase = get_supabase_client()
        resp = (
            supabase.table("ranking_matches")
            .select(
                "*, "
                "ranking_weeks(week_number, phase), "
                "defender:players!defender_id(first_name, last_name), "
                "challenger:players!challenger_id(first_name, last_name)"
            )
            .eq("is_completed", True)
            .or_(f"defender_id.eq.{player_id},challenger_id.eq.{player_id}")
            .order("created_at", desc=True)
            .limit(limit)
            .execute()
        )

        raw_matches = resp.data or []
        parsed = []
        for m in raw_matches:
            is_defender = m["defender_id"] == player_id
            opponent = m.get("challenger", {}) if is_defender else m.get("defender", {})
            opponent_pos = m.get("challenger_position") if is_defender else m.get("defender_position")
            player_pos = m.get("defender_position") if is_defender else m.get("challenger_position")
            won = m.get("winner_id") == player_id

            # Parse set scores relative to (player, opponent)
            sets = []
            s1_p = m.get("set1_defender") if is_defender else m.get("set1_challenger")
            s1_o = m.get("set1_challenger") if is_defender else m.get("set1_defender")
            if s1_p is not None and s1_o is not None:
                sets.append((s1_p, s1_o))

            s2_p = m.get("set2_defender") if is_defender else m.get("set2_challenger")
            s2_o = m.get("set2_challenger") if is_defender else m.get("set2_defender")
            if s2_p is not None and s2_o is not None:
                sets.append((s2_p, s2_o))

            s3_p = m.get("set3_defender") if is_defender else m.get("set3_challenger")
            s3_o = m.get("set3_challenger") if is_defender else m.get("set3_defender")
            if s3_p is not None and s3_o is not None:
                sets.append((s3_p, s3_o))

            parsed.append({
                "match_id": m["id"],
                "won": won,
                "is_forfeit": m.get("is_forfeit", False),
                "opponent_name": f"{opponent.get('first_name', '')} {opponent.get('last_name', '')}".strip(),
                "opponent_pos": opponent_pos,
                "player_pos": player_pos,
                "week_number": (m.get("ranking_weeks") or {}).get("week_number"),
                "phase": (m.get("ranking_weeks") or {}).get("phase"),
                "scheduled_date": m.get("scheduled_date"),
                "sets": sets,
            })

        return parsed

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

    # ═══════════════════════════════════════════════════════════
    # MODIFY SAVED RESULTS (Active & Past Weeks)
    # ═══════════════════════════════════════════════════════════

    @staticmethod
    def get_players_with_history(category_id, search_query=""):
        """
        Fetch all players relevant to the category (in ladder or with completed matches),
        optionally filtered by a search query string.

        Returns list of dicts:
            [{id, first_name, last_name, full_name, position, completed_matches_count}, ...]
        """
        supabase = get_supabase_client()

        # 1. Fetch current ladder positions for this category
        ladder_resp = (
            supabase.table("ranking_ladders")
            .select("position, player_id, players(id, first_name, last_name)")
            .eq("category_id", category_id)
            .eq("is_active", True)
            .order("position")
            .execute()
        )
        ladder_map = {}
        players_dict = {}

        for row in (ladder_resp.data or []):
            p_id = row["player_id"]
            pos = row["position"]
            ladder_map[p_id] = pos
            p_data = row.get("players") or {}
            if p_data:
                first = p_data.get("first_name", "") or ""
                last = p_data.get("last_name", "") or ""
                players_dict[p_id] = {
                    "id": p_id,
                    "first_name": first,
                    "last_name": last,
                    "full_name": f"{first} {last}".strip(),
                    "position": pos,
                    "completed_matches_count": 0,
                }

        # 2. Count completed matches per player in this category
        matches_resp = (
            supabase.table("ranking_matches")
            .select(
                "defender_id, challenger_id, "
                "defender:players!defender_id(id, first_name, last_name), "
                "challenger:players!challenger_id(id, first_name, last_name), "
                "ranking_weeks!inner(category_id)"
            )
            .eq("ranking_weeks.category_id", category_id)
            .eq("is_completed", True)
            .execute()
        )

        for m in (matches_resp.data or []):
            def_id = m.get("defender_id")
            chal_id = m.get("challenger_id")
            for pid, player_rel in [(def_id, m.get("defender")), (chal_id, m.get("challenger"))]:
                if not pid:
                    continue
                if pid not in players_dict:
                    p_info = player_rel or {}
                    first = p_info.get("first_name", "") or ""
                    last = p_info.get("last_name", "") or ""
                    players_dict[pid] = {
                        "id": pid,
                        "first_name": first,
                        "last_name": last,
                        "full_name": f"{first} {last}".strip(),
                        "position": ladder_map.get(pid),
                        "completed_matches_count": 0,
                    }
                players_dict[pid]["completed_matches_count"] += 1

        # 3. Filter by search query if provided
        players_list = list(players_dict.values())
        if search_query and search_query.strip():
            q = search_query.strip().lower()
            players_list = [
                p for p in players_list
                if q in p["full_name"].lower()
            ]

        # 4. Sort: players with matches first, then by position/name
        def _sort_key(p):
            has_matches = 0 if p["completed_matches_count"] > 0 else 1
            pos = p["position"] if p["position"] is not None else 9999
            return (has_matches, pos, p["full_name"])

        players_list.sort(key=_sort_key)
        return players_list

    @staticmethod
    def get_completed_matches_by_player(player_id, category_id=None):
        """
        Fetch all completed matches (ignoring drafts) for a player in a category.
        Includes active and past weeks, ordered by date/created_at descending.

        Returns list of parsed match dicts.
        """
        supabase = get_supabase_client()

        query = (
            supabase.table("ranking_matches")
            .select(
                "id, week_id, defender_id, challenger_id, defender_position, challenger_position, "
                "scheduled_date, scheduled_time, court_number, "
                "set1_defender, set1_challenger, set2_defender, set2_challenger, set3_defender, set3_challenger, "
                "winner_id, is_forfeit, is_completed, completed_at, created_at, "
                "ranking_weeks!inner(id, category_id, week_number, phase, week_start_date, week_end_date, is_completed), "
                "defender:players!defender_id(id, first_name, last_name), "
                "challenger:players!challenger_id(id, first_name, last_name)"
            )
            .eq("is_completed", True)
            .or_(f"defender_id.eq.{player_id},challenger_id.eq.{player_id}")
        )

        if category_id:
            query = query.eq("ranking_weeks.category_id", category_id)

        resp = query.order("scheduled_date", desc=True).order("created_at", desc=True).execute()
        raw = resp.data or []

        parsed = []
        for m in raw:
            is_defender = m["defender_id"] == player_id
            opponent = m.get("challenger", {}) if is_defender else m.get("defender", {})
            opponent_id = m["challenger_id"] if is_defender else m["defender_id"]
            opponent_first = opponent.get("first_name", "") or ""
            opponent_last = opponent.get("last_name", "") or ""
            opponent_name = f"{opponent_first} {opponent_last}".strip()

            player_pos = m["defender_position"] if is_defender else m["challenger_position"]
            opponent_pos = m["challenger_position"] if is_defender else m["defender_position"]
            won = m.get("winner_id") == player_id

            week = m.get("ranking_weeks", {}) or {}
            week_num = week.get("week_number")
            phase = week.get("phase")
            week_is_completed = week.get("is_completed", False)

            sets = []
            s1_d, s1_c = m.get("set1_defender"), m.get("set1_challenger")
            s2_d, s2_c = m.get("set2_defender"), m.get("set2_challenger")
            s3_d, s3_c = m.get("set3_defender"), m.get("set3_challenger")

            if s1_d is not None and s1_c is not None:
                sets.append((s1_d if is_defender else s1_c, s1_c if is_defender else s1_d))
            if s2_d is not None and s2_c is not None:
                sets.append((s2_d if is_defender else s2_c, s2_c if is_defender else s2_d))
            if s3_d is not None and s3_c is not None:
                sets.append((s3_d if is_defender else s3_c, s3_c if is_defender else s3_d))

            parsed.append({
                "id": m["id"],
                "week_id": m["week_id"],
                "week_number": week_num,
                "phase": phase,
                "week_is_completed": week_is_completed,
                "week_start_date": week.get("week_start_date"),
                "scheduled_date": m.get("scheduled_date"),
                "scheduled_time": m.get("scheduled_time"),
                "court_number": m.get("court_number"),
                "is_defender": is_defender,
                "defender_id": m["defender_id"],
                "challenger_id": m["challenger_id"],
                "defender_name": f"{(m.get('defender') or {}).get('first_name', '')} {(m.get('defender') or {}).get('last_name', '')}".strip(),
                "challenger_name": f"{(m.get('challenger') or {}).get('first_name', '')} {(m.get('challenger') or {}).get('last_name', '')}".strip(),
                "defender_position": m["defender_position"],
                "challenger_position": m["challenger_position"],
                "player_pos": player_pos,
                "opponent_id": opponent_id,
                "opponent_name": opponent_name,
                "opponent_pos": opponent_pos,
                "won": won,
                "winner_id": m.get("winner_id"),
                "is_forfeit": m.get("is_forfeit", False),
                "set1_defender": s1_d,
                "set1_challenger": s1_c,
                "set2_defender": s2_d,
                "set2_challenger": s2_c,
                "set3_defender": s3_d,
                "set3_challenger": s3_c,
                "sets_player_view": sets,
            })

        return parsed

    @staticmethod
    def update_saved_match_result(match_id, winner_id, scores, is_forfeit=False, entered_by=None):
        """
        Update a previously saved/committed match result.

        1. Updates ranking_matches with corrected scores, winner, and forfeit state.
        2. Ladder position rule:
           - Past weeks (is_completed == True): NEVER modify ladder positions.
           - Active week (is_completed == False): If winner changed, swap Challenger
             and Defender in ranking_ladders (or swap back if Defender wins).
        3. Cleans up any orphaned drafts for this match.
        4. Clears Streamlit cache to immediately recalculate win/loss records.

        Returns dict:
            {"success": bool, "swapped": bool, "swap_msg": str, "error": str}
        """
        supabase = get_supabase_client()

        # 1. Fetch match and week details
        match_resp = (
            supabase.table("ranking_matches")
            .select("*, ranking_weeks!inner(category_id, is_completed, week_number)")
            .eq("id", match_id)
            .execute()
        )
        if not match_resp.data:
            return {"success": False, "swapped": False, "error": "Partido no encontrado"}

        match = match_resp.data[0]
        old_winner_id = match.get("winner_id")
        category_id = match["ranking_weeks"]["category_id"]
        week_is_completed = match["ranking_weeks"]["is_completed"]
        week_number = match["ranking_weeks"]["week_number"]
        defender_id = match["defender_id"]
        challenger_id = match["challenger_id"]

        # 2. Update ranking_matches row
        update_data = {
            "winner_id": winner_id,
            "is_forfeit": is_forfeit,
            "is_completed": True,
            "completed_at": datetime.utcnow().isoformat(),
            **scores,
        }
        if entered_by:
            update_data["entered_by"] = entered_by

        try:
            supabase.table("ranking_matches").update(update_data).eq("id", match_id).execute()
        except Exception as e:
            return {"success": False, "swapped": False, "error": f"Error al actualizar el partido: {e}"}

        # 3. Position swap rule:
        # ONLY apply position adjustments if the week is currently ACTIVE (not completed)
        swapped = False
        swap_msg = ""

        if not week_is_completed and old_winner_id != winner_id:
            try:
                def_row = (
                    supabase.table("ranking_ladders")
                    .select("id, position")
                    .eq("category_id", category_id)
                    .eq("player_id", defender_id)
                    .limit(1)
                    .execute()
                )
                chal_row = (
                    supabase.table("ranking_ladders")
                    .select("id, position")
                    .eq("category_id", category_id)
                    .eq("player_id", challenger_id)
                    .limit(1)
                    .execute()
                )

                if def_row.data and chal_row.data:
                    d_pos = def_row.data[0]["position"]
                    c_pos = chal_row.data[0]["position"]
                    d_entry_id = def_row.data[0]["id"]
                    c_entry_id = chal_row.data[0]["id"]

                    # Determine if a ladder swap is required:
                    # - If challenger now won, and challenger is ranked lower (d_pos < c_pos) -> swap!
                    # - If defender now won, but challenger was placed higher (c_pos < d_pos) -> swap back!
                    should_swap = False
                    if winner_id == challenger_id and d_pos < c_pos:
                        should_swap = True
                    elif winner_id == defender_id and c_pos < d_pos:
                        should_swap = True

                    if should_swap:
                        # Clean up any stale sentinel position
                        supabase.table("ranking_ladders").delete().eq(
                            "category_id", category_id
                        ).eq("position", -1).execute()

                        # Sentinel swap to avoid unique constraint
                        supabase.table("ranking_ladders").update({"position": -1}).eq("id", c_entry_id).execute()
                        supabase.table("ranking_ladders").update({"position": c_pos}).eq("id", d_entry_id).execute()
                        supabase.table("ranking_ladders").update({"position": d_pos}).eq("id", c_entry_id).execute()

                        swapped = True
                        swap_msg = f"Posiciones en la escalera intercambiadas (#{d_pos} ↔ #{c_pos}) por pertenecer a la semana activa (Semana {week_number})."
            except Exception as e:
                print(f"Error al actualizar posiciones de la escalera: {e}")
                swap_msg = f"No se pudieron ajustar las posiciones de la escalera: {e}"

        # 4. Clean up any lingering draft for this match
        try:
            supabase.table("ranking_match_drafts").delete().eq("match_id", match_id).execute()
        except Exception:
            pass

        # 5. Clear Streamlit cache so historical records update immediately
        try:
            import streamlit as st
            st.cache_data.clear()
        except Exception:
            pass

        return {
            "success": True,
            "swapped": swapped,
            "swap_msg": swap_msg,
            "is_active_week": not week_is_completed,
        }

