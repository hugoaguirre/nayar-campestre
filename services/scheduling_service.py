import streamlit as st
import pandas as pd
from datetime import datetime, timedelta
import itertools
from utils.supabase_client import get_supabase_client


class SchedulingService:
    @staticmethod
    def generate_round_robin_matches(tournament_id):
        """
        Reads all saved draws from 'tournament_draws' and dynamically injects
        Round-Robin phase pairings into the 'matches' table if they haven't been generated yet.
        """
        try:
            supabase = get_supabase_client()

            # 1. Wipe all existing 'Grupos' matches for this tournament to prevent historical accumulation
            supabase.table("matches").delete().eq("tournament_id", tournament_id).eq(
                "stage", "Grupos"
            ).execute()

            # Fetch all saved draws for the tournament
            draws_resp = (
                supabase.table("tournament_draws")
                .select("*")
                .eq("tournament_id", tournament_id)
                .execute()
            )
            if not draws_resp.data:
                return False

            # For each draw, extract the groups and generate pairings
            for draw in draws_resp.data:
                fmt = draw["format_text"]  # Singles / Dobles
                cat_id = draw["category_id"]
                scat_id = draw["subcategory_id"]
                groups = draw["draw_json"]

                for group_name, players in groups.items():
                    # Generate all unique pairs in this group (Round-Robin)
                    pairings = list(itertools.combinations(players, 2))

                    for p1, p2 in pairings:
                        # Extract IDs
                        # In the draw_json, we only saved 'Nombre', 'Apellido', 'Pago'.
                        # Wait! draw.py line 155 does `eligible_df.loc[...].to_dict('records')`.
                        # 'ID_Jugador' is inside eligible_df!

                        team_a_p1 = p1.get("ID_Jugador")
                        team_a_p2 = p1.get("ID_Pareja") if fmt == "Dobles" else None
                        team_b_p1 = p2.get("ID_Jugador")
                        team_b_p2 = p2.get("ID_Pareja") if fmt == "Dobles" else None

                        # Check if this exact match pairing already exists
                        existing = (
                            supabase.table("matches")
                            .select("id")
                            .eq("tournament_id", tournament_id)
                            .eq("category_id", cat_id)
                            .eq("subcategory_id", scat_id)
                            .eq("player1_id", team_a_p1)
                            .eq("player2_id", team_b_p1)
                            .execute()
                        )

                        # Mirror check
                        existing_rev = (
                            supabase.table("matches")
                            .select("id")
                            .eq("tournament_id", tournament_id)
                            .eq("category_id", cat_id)
                            .eq("subcategory_id", scat_id)
                            .eq("player1_id", team_b_p1)
                            .eq("player2_id", team_a_p1)
                            .execute()
                        )

                        if not existing.data and not existing_rev.data:
                            # Insert Match
                            payload = {
                                "tournament_id": tournament_id,
                                "category_id": cat_id,
                                "subcategory_id": scat_id,
                                "match_type": fmt,
                                "stage": "Grupos",
                                "player1_id": team_a_p1,
                                "team1_partner_id": team_a_p2,
                                "player2_id": team_b_p1,
                                "team2_partner_id": team_b_p2,
                                "status": "Scheduled",
                            }
                            supabase.table("matches").insert(payload).execute()

            return True
        except Exception as e:
            print(f"Match Gen Error: {e}")
            return False

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

    @staticmethod
    def check_match_constraints(match, slot_time, scheduled_matrix):
        """
        Evaluates physical overlaps and chronological rest periods.
        Returns: 'PASS', 'FAIL_CONSECUTIVE', 'FAIL_SAME_DAY', 'FAIL_SAME_TIME'
        """
        p_ids = [
            match.get("player1_id"),
            match.get("player2_id"),
            match.get("team1_partner_id"),
            match.get("team2_partner_id"),
        ]
        p_ids = [p for p in p_ids if p is not None]

        worst_failure = "PASS"

        for p in p_ids:
            # Check all assignments for this player
            p_matches = scheduled_matrix.get(p, [])
            for pm_time in p_matches:
                time_diff_sec = abs((slot_time - pm_time).total_seconds())

                if time_diff_sec == 0:
                    return "FAIL_SAME_TIME"  # Hard block

                if slot_time.date() == pm_time.date():
                    worst_failure = "FAIL_SAME_DAY"

                if abs((slot_time.date() - pm_time.date()).days) == 1:
                    if worst_failure == "PASS":
                        worst_failure = "FAIL_CONSECUTIVE"

        return worst_failure

    @staticmethod
    def auto_schedule_matches(
        tournament_id, start_date_str, end_date_str, num_courts=6
    ):
        """
        The Master Engine: Assigns un-scheduled matches to active courts
        using a Multi-Pass Greedy Engine with Relaxing Constraints.
        Configurable for flash tournaments via num_courts limit.
        """
        try:
            start_date = datetime.strptime(start_date_str, "%Y-%m-%d")
            end_date = datetime.strptime(end_date_str, "%Y-%m-%d")

            supabase = get_supabase_client()

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

            unscheduled = (
                supabase.table("matches")
                .select(
                    "id, category_id, subcategory_id, stage, subcategories(name), "
                    "player1_id, player2_id, team1_partner_id, team2_partner_id"
                )
                .eq("tournament_id", tournament_id)
                .is_("scheduled_time", "null")
                .execute()
            )

            if not unscheduled.data:
                return True

            slots = []
            curr_day = start_date
            while curr_day <= end_date:
                weekday = curr_day.weekday()
                if 1 <= weekday <= 4:
                    hours = [16, 17, 19, 20]
                    mins = [0, 30, 0, 30]
                elif weekday >= 5:
                    hours = [9, 10, 12, 13, 15, 16, 18]
                    mins = [0, 30, 0, 30, 0, 30, 0]
                else:
                    curr_day += timedelta(days=1)
                    continue

                for i in range(len(hours)):
                    slot_time = curr_day.replace(hour=hours[i], minute=mins[i])
                    slots.append({"time": slot_time, "is_prime": (hours[i] >= 19)})

                curr_day += timedelta(days=1)

            booked_resp = (
                supabase.table("matches")
                .select(
                    "court_id, scheduled_time, player1_id, player2_id, team1_partner_id, team2_partner_id"
                )
                .eq("tournament_id", tournament_id)
                .not_.is_("scheduled_time", "null")
                .execute()
            )

            book_map = set()  # "courtId_isoTime" -> Taken
            scheduled_matrix = {}  # "player_id" -> [datetime, datetime]

            if booked_resp.data:
                for b in booked_resp.data:
                    dt = datetime.fromisoformat(
                        b["scheduled_time"].replace("Z", "+00:00")
                    ).replace(tzinfo=None)
                    book_map.add(f"{b['court_id']}_{dt.isoformat()}")

                    for pk in [
                        "player1_id",
                        "player2_id",
                        "team1_partner_id",
                        "team2_partner_id",
                    ]:
                        if b.get(pk):
                            if b[pk] not in scheduled_matrix:
                                scheduled_matrix[b[pk]] = []
                            scheduled_matrix[b[pk]].append(dt)

            queue = unscheduled.data
            prime_targets = ["AA", "A", "B+"]
            updates = []

            # --- MULTI-PASS ALGORITHM ---
            # Pass 1: Strict (Requires PASS)
            # Pass 2: Relaxed (Allows FAIL_CONSECUTIVE)
            # Pass 3: Desperate (Allows FAIL_SAME_DAY)

            for pass_num in [1, 2, 3]:
                for slot in slots:
                    if len(queue) == 0:
                        break

                    dt_val = slot["time"]
                    dt_iso = dt_val.isoformat()
                    is_prime = slot["is_prime"]

                    for c_id in courts:
                        if len(queue) == 0:
                            break

                        key = f"{c_id}_{dt_iso}"
                        if key in book_map:
                            continue

                        chosen_idx = -1

                        for i, match in enumerate(queue):
                            # Analyze constraints
                            constraint_result = (
                                SchedulingService.check_match_constraints(
                                    match, dt_val, scheduled_matrix
                                )
                            )

                            is_valid = False
                            if pass_num == 1 and constraint_result == "PASS":
                                is_valid = True
                            elif pass_num == 2 and constraint_result in [
                                "PASS",
                                "FAIL_CONSECUTIVE",
                            ]:
                                is_valid = True
                            elif pass_num == 3 and constraint_result in [
                                "PASS",
                                "FAIL_CONSECUTIVE",
                                "FAIL_SAME_DAY",
                            ]:
                                is_valid = True

                            if is_valid:
                                # Check prime rules
                                sc_name = match.get("subcategories", {}).get("name", "")
                                if is_prime and sc_name in prime_targets:
                                    chosen_idx = i
                                    break  # Perfect match found!
                                elif not is_prime:
                                    chosen_idx = i
                                    break  # Good enough!

                        if chosen_idx != -1:
                            best_match = queue.pop(chosen_idx)
                            updates.append(
                                {
                                    "id": best_match["id"],
                                    "court_id": c_id,
                                    "scheduled_time": dt_iso,
                                    "status": "Scheduled",
                                }
                            )
                            book_map.add(key)

                            # Book players into the matrix
                            for pk in [
                                "player1_id",
                                "player2_id",
                                "team1_partner_id",
                                "team2_partner_id",
                            ]:
                                pid = best_match.get(pk)
                                if pid:
                                    if pid not in scheduled_matrix:
                                        scheduled_matrix[pid] = []
                                    scheduled_matrix[pid].append(dt_val)

            # Push all to DB
            for u in updates:
                supabase.table("matches").update(
                    {
                        "court_id": u["court_id"],
                        "scheduled_time": u["scheduled_time"],
                        "status": "Scheduled",
                    }
                ).eq("id", u["id"]).execute()

            return True
        except Exception as e:
            print(f"Auto-schedule Error: {e}")
            return False

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
