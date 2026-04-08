import streamlit as st
from utils.supabase_client import get_supabase_client
import pandas as pd
from datetime import datetime

class TournamentService:
    @staticmethod
    def get_all_tournaments():
        """
        Fetches all tournaments from the database, ordered by creation date.
        """
        try:
            supabase = get_supabase_client()
            response = supabase.table('tournaments')\
                .select('*')\
                .order('created_at', desc=True)\
                .execute()
            
            return response.data if response.data else []
        except Exception as e:
            st.error(f"Error fetching tournaments: {e}")
            return []

    @staticmethod
    def create_tournament(name, start_date, end_date, num_courts, categories, subcategories):
        """
        Creates a new tournament and sets its status to 'active'.
        Note: Currently categories/subcategories are stored in their own tables, 
        and golfers are registered to them. For now, we just create the tournament record.
        """
        try:
            supabase = get_supabase_client()
            
            # 2. Insert new tournament
            payload = {
                "name": name,
                "start_date": start_date.strftime('%Y-%m-%d') if start_date else None,
                "end_date": end_date.strftime('%Y-%m-%d') if end_date else None,
                "num_courts": num_courts,
                "status": "active"
            }
            
            response = supabase.table('tournaments').insert(payload).execute()
            if response.data:
                return response.data[0]
            return None
        except Exception as e:
            st.error(f"Error creating tournament: {e}")
            return None

    @staticmethod
    def delete_tournament(tournament_id):
        """
        Explicitly cascades the deletion of a tournament, aggressively purging 
        all dependent schedule matches, draws, and registrations first.
        """
        try:
            supabase = get_supabase_client()
            
            # 1. Purge scheduled matches
            supabase.table('matches').delete().eq('tournament_id', tournament_id).execute()
            
            # 2. Purge logic draws
            supabase.table('tournament_draws').delete().eq('tournament_id', tournament_id).execute()
            
            # 3. Purge player registrations from this tournament
            supabase.table('tournament_registrations').delete().eq('tournament_id', tournament_id).execute()
            
            # 4. Annihilate the core tournament
            response = supabase.table('tournaments').delete().eq('id', tournament_id).execute()
            
            return True if response.data else False
        except Exception as e:
            st.error(f"Error deleting tournament: {e}")
            return False

    @staticmethod
    def fetch_config_options():
        """
        Fetches available Categories and Subcategories from the database.
        """
        try:
            supabase = get_supabase_client()
            
            cats_resp = supabase.table('categories').select('name').execute()
            subcats_resp = supabase.table('subcategories').select('name').execute()
            
            categories = [c['name'] for c in cats_resp.data] if cats_resp.data else []
            subcats_raw = [sc['name'] for sc in subcats_resp.data] if subcats_resp.data else []
            
            # Explicitly force the sorting logic for the UI to understand B+ placement
            sort_order = {"AA": 1, "A": 2, "B+": 3, "B": 4, "C": 5, "D": 6, "Mini-Tenis": 7, "8-10 años": 8}
            # Custom sorting with a fallback for unknowns
            subcategories = sorted(subcats_raw, key=lambda x: sort_order.get(x, 99))
            
            return categories, subcategories
        except Exception as e:
            st.error(f"Error fetching config options: {e}")
            return [], []

    @staticmethod
    def get_all_club_players():
        """
        Fetches the complete directory of club players from the 'players' table.
        Only fetches identity fields as categories are now managed per-tournament.
        """
        try:
            supabase = get_supabase_client()
            response = supabase.table('players')\
                .select('id, first_name, last_name, phone')\
                .execute()
            
            return response.data if response.data else []
        except Exception as e:
            st.error(f"Error fetching club database: {e}")
            return []
