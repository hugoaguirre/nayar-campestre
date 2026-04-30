import streamlit as st

from utils.theme import apply_wimbledon_ui
from utils.state import init_session_state
from components.sidebar import render_sidebar
from components.header import render_hero_header
from components.metrics import render_metrics
from views.registration import render_registration_view
from views.draw import render_draw_view
from views.bracket import render_bracket_view
from views.schedule import render_schedule_view
from views.export import render_export_view

# --- 1. PAGE CONFIG & THEME INJECTION ---
st.set_page_config(
    page_title="Club Nayar Campestre - Tenis | Manejador de Torneos", 
    layout="wide",
    initial_sidebar_state="expanded"
)

apply_wimbledon_ui()

# --- 2. AUTH GATE (must pass before any data is loaded) ---
from utils.auth import require_auth
user = require_auth()

# --- 3. INITIALIZE STATE ---
init_session_state()

# --- 4. MAIN NAVIGATION TOGGLE ---
if not st.session_state.tournament_active:
    from views.landing import render_landing_view
    render_landing_view()
else:
    # --- 4. DYNAMIC SIDEBAR (Admin Branding) ---
    t_name, l_logo, r_logo = render_sidebar()
    
    # Use the active tournament name if available in data
    display_name = st.session_state.tournament_data.get('name', t_name)

    # --- 5. THE "COURTIX" HERO HEADER ---
    render_hero_header(display_name, l_logo, r_logo)
    
    # --- 6. DASHBOARD METRICS ---
    # Centralized fetch to ensure metrics and all tabs use same persistent data
    from utils.supabase_data import fetch_tournament_players
    st.session_state.players_df = fetch_tournament_players()
        
    render_metrics()
    
    # --- 7. MAIN NAVIGATION ---
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

    # --- 8. FOOTER ---
    st.caption("Donated to Nayar Club Campestre - @hugoaguirre")
