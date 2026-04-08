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

            # 1. Wipe all existing matches for this tournament to prevent historical accumulation
            supabase.table("matches").delete().eq("tournament_id", tournament_id).in_(
                "stage", ["Grupos", "Eliminatoria"]
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
                            
                # 2. Knockout Placeholder Engine
                num_groups = len(groups)
                num_playoffs = num_groups - 1
                
                if num_playoffs > 0:
                    for _ in range(num_playoffs):
                        playoff_payload = {
                            "tournament_id": tournament_id,
                            "category_id": cat_id,
                            "subcategory_id": scat_id,
                            "match_type": fmt,
                            "stage": "Eliminatoria",
                            "status": "Scheduled",
                        }
                        supabase.table("matches").insert(playoff_payload).execute()

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
        using a Scoring Engine with Penalty logic to balance days.
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
                    # Tuesday to Friday
                    hours = [16, 17, 19, 20]
                    mins = [0, 30, 0, 30]
                    for i in range(len(hours)):
                        slot_time = curr_day.replace(hour=hours[i], minute=mins[i])
                        slots.append({"time": slot_time, "is_prime": (hours[i] >= 19)})
                elif weekday == 5:
                    # Saturday: 9:00 AM to 8:30 PM (20:30)
                    hours = [9, 10, 12, 13, 16, 17, 19, 20]
                    mins = [0, 30, 0, 30, 0, 30, 0, 30] # 20:30 is the last match
                    for i in range(len(hours)):
                        slot_time = curr_day.replace(hour=hours[i], minute=mins[i])
                        slots.append({"time": slot_time, "is_prime": True})
                elif weekday == 6:
                    # Sunday: 9:00 AM to 7:00 PM (19:00)
                    hours = [9, 10, 12, 13, 16, 17, 19]
                    mins = [0, 30, 0, 30, 0, 30, 0] # 19:00 is the last match
                    for i in range(len(hours)):
                        slot_time = curr_day.replace(hour=hours[i], minute=mins[i])
                        slots.append({"time": slot_time, "is_prime": True})
                else:
                    # Monday (closed)
                    pass

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
            day_usage = {} # "YYYY-MM-DD" -> count of matches

            if booked_resp.data:
                for b in booked_resp.data:
                    dt = datetime.fromisoformat(
                        b["scheduled_time"].replace("Z", "+00:00")
                    ).replace(tzinfo=None)
                    book_map.add(f"{b['court_id']}_{dt.isoformat()}")

                    date_str = dt.strftime("%Y-%m-%d")
                    day_usage[date_str] = day_usage.get(date_str, 0) + 1

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

            # Sort queue: Prime matches first
            def match_sort_key(m):
                sc_name = m.get("subcategories", {}).get("name", "")
                return 0 if sc_name in prime_targets else 1

            queue.sort(key=match_sort_key)

            updates = []
            failed_count = 0
            
            for match in queue:
                best_slot = None
                best_court = None
                best_score = float('inf')
                
                sc_name = match.get("subcategories", {}).get("name", "")
                is_prime_match = sc_name in prime_targets
                
                for slot in slots:
                    dt_val = slot["time"]
                    dt_iso = dt_val.isoformat()
                    is_prime_slot = slot["is_prime"]
                    
                    # Check if there's an available court for this slot
                    available_courts = []
                    for c_id in courts:
                        if f"{c_id}_{dt_iso}" not in book_map:
                            available_courts.append(c_id)
                            
                    if not available_courts:
                        continue # Fully booked
                        
                    constraint_result = SchedulingService.check_match_constraints(
                        match, dt_val, scheduled_matrix
                    )
                    
                    if constraint_result == "FAIL_SAME_TIME":
                        continue

                    penalty = 0
                    
                    # 1. Constraint Penalty
                    if constraint_result == "FAIL_SAME_DAY":
                        penalty += 5000
                    elif constraint_result == "FAIL_CONSECUTIVE":
                        penalty += 1000
                        
                    # 2. Day Load Balancing (Spread matches across empty days)
                    date_str = dt_val.strftime("%Y-%m-%d")
                    curr_day_usage = day_usage.get(date_str, 0)
                    penalty += curr_day_usage * 50
                    
                    # 3. Eliminatoria End-Date Bias
                    if match.get("stage") == "Eliminatoria":
                        days_from_end = (end_date.date() - dt_val.date()).days
                        # Heavily penalize scheduling playoff games early
                        penalty += days_from_end * 20000
                    
                    # 3. Prime Alignment
                    if is_prime_match:
                        if not is_prime_slot:
                            # Not a prime slot (weekday early slot).
                            penalty += 100
                            # The later the better: penalize early hours.
                            penalty += (24 - dt_val.hour) * 2
                    else:
                        if is_prime_slot and dt_val.weekday() < 5:
                            # Regular match taking a weekday prime slot.
                            penalty += 100
                            # The earlier the better: penalize late hours.
                            penalty += dt_val.hour * 2

                    if penalty < best_score:
                        best_score = penalty
                        best_slot = slot
                        best_court = available_courts[0]

                if best_slot and best_court:
                    dt_val = best_slot["time"]
                    dt_iso = best_slot["time"].isoformat()
                    
                    updates.append({
                        "id": match["id"],
                        "court_id": best_court,
                        "scheduled_time": dt_iso,
                        "status": "Scheduled",
                    })
                    
                    book_map.add(f"{best_court}_{dt_iso}")
                    
                    date_str = dt_val.strftime("%Y-%m-%d")
                    day_usage[date_str] = day_usage.get(date_str, 0) + 1
                    
                    for pk in [
                        "player1_id",
                        "player2_id",
                        "team1_partner_id",
                        "team2_partner_id",
                    ]:
                        pid = match.get(pk)
                        if pid:
                            if pid not in scheduled_matrix:
                                scheduled_matrix[pid] = []
                            scheduled_matrix[pid].append(dt_val)
                else:
                    failed_count += 1

            # Push all to DB
            for u in updates:
                supabase.table("matches").update(
                    {
                        "court_id": u["court_id"],
                        "scheduled_time": u["scheduled_time"],
                        "status": "Scheduled",
                    }
                ).eq("id", u["id"]).execute()

            return {"success": True, "failed": failed_count}
        except Exception as e:
            print(f"Auto-schedule Error: {e}")
            return {"success": False, "failed": 0}

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
