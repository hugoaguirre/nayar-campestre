import os
import streamlit as st
from supabase import create_client

SUPABASE_URL = "https://edduvmdtfmhwuknjekye.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVkZHV2bWR0Zm1od3Vrbmpla3llIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUwNzYyMDgsImV4cCI6MjA5MDY1MjIwOH0.boIy_KtSOYf17EPk-Kk_vAf3XNVHD-qPh6jArq_qfxE"

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

try:
    print("Testing 1: is_finalized")
    res = supabase.table('tournaments').select('is_finalized').limit(1).execute()
    print("Tournaments:", res.data)
except Exception as e:
    print("ERROR Tournaments:", e)

try:
    print("\nTesting 2: Reload PostgREST Cache via REST")
    # Actually can't reload easily via python client without rpc
except Exception as e:
    pass

try:
    print("\nTesting 3: matches relationships with column names")
    resp = supabase.table('matches').select(
        'id, '
        'p1:players!team_a_player1_id(first_name, last_name)'
    ).limit(1).execute()
    print("Matches 1:", resp.data)
except Exception as e:
    print("ERROR Matches column name:", e)

try:
    print("\nTesting 4: matches relationships without hints")
    # Will fail if multiple relationships exist
    resp = supabase.table('matches').select(
        'id, players(first_name)'
    ).limit(1).execute()
    print("Matches 2:", resp.data)
except Exception as e:
    print("ERROR Matches no hint:", e)
