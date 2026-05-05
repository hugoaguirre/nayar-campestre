"""
Tournament Management Page — wraps the existing tournament dashboard flow.
This is the old main.py body (landing + tournament tabs), now living
as a st.navigation page. Protected behind auth via page visibility.
"""
import streamlit as st
import pandas as pd

from utils.auth import get_current_user
from utils.state import init_session_state
from components.sidebar import render_sidebar
from components.header import render_hero_header
from components.metrics import render_metrics
from views.registration import render_registration_view
from views.draw import render_draw_view
from views.bracket import render_bracket_view
from views.schedule import render_schedule_view
from views.export import render_export_view

# Defense-in-depth: block direct URL access without auth
user = get_current_user()
if not user:
    st.error("🔒 Acceso denegado. Inicia sesión para continuar.")
    st.stop()

# --- MAIN NAVIGATION TOGGLE ---
if not st.session_state.tournament_active:
    from views.landing import render_landing_view
    render_landing_view()
else:
    # --- DYNAMIC SIDEBAR (Admin Branding) ---
    t_name, l_logo, r_logo = render_sidebar()
    
    # Use the active tournament name if available in data
    display_name = st.session_state.tournament_data.get('name', t_name)

    # --- THE "COURTIX" HERO HEADER ---
    render_hero_header(display_name, l_logo, r_logo)
    
    # --- DASHBOARD METRICS ---
    # Centralized fetch to ensure metrics and all tabs use same persistent data
    from utils.supabase_data import fetch_tournament_players
    st.session_state.players_df = fetch_tournament_players()
        
    render_metrics()
    
    # --- MAIN NAVIGATION ---
    tab_reg, tab_draw, tab_sched, tab_bracket, tab_print, tab_fin = st.tabs(
        ["01 REGISTRO", "02 GENERAR DRAW", "03 HORARIOS", "04 PREVISUALIZAR", "05 IMPRIMIR", "06 FINALIZAR"]
    )
    
    with tab_reg:
        render_registration_view()
    
    with tab_draw:
        render_draw_view()
        
    with tab_sched:
        render_schedule_view()
    
    with tab_bracket:
        render_bracket_view(display_name)
    
    with tab_print:
        render_export_view()

    with tab_fin:
        from views.finalize import render_finalize_view
        render_finalize_view()

    # --- FOOTER ---
    st.caption("Donated to Nayar Club Campestre - @hugoaguirre")
