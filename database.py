import st_supabase_connection as st_supabase
import streamlit as st


def get_supabase():
    """Initializes the Supabase connection using Streamlit secrets."""
    return st.connection("supabase", type=st_supabase.SupabaseConnection)


def fetch_players(category, modality):
    """Retrieves registered players filtered by category."""
    client = get_supabase()
    query = (
        client.table("players")
        .select("*")
        .eq("category", category)
        .eq("modality", modality)
    )
    return query.execute()


def save_tournament_meta(name, left_logo_url, right_logo_url):
    """Saves branding settings so they persist across sessions."""
    client = get_supabase()
    client.table("config").upsert(
        {"id": 1, "name": name, "l_logo": left_logo_url, "r_logo": right_logo_url}
    ).execute()
