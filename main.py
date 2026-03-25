import streamlit as st

from utils.theme import apply_wimbledon_ui
from utils.state import init_session_state
from components.sidebar import render_sidebar
from components.header import render_hero_header
from components.metrics import render_metrics
from views.registration import render_registration_view
from views.draw import render_draw_view
from views.export import render_export_view

# --- 1. PAGE CONFIG & THEME INJECTION ---
st.set_page_config(
    page_title="Club Nayar Campestre - Tenis | Manejador de Torneos", 
    layout="wide",
    initial_sidebar_state="expanded"
)

apply_wimbledon_ui()

# --- 2. INITIALIZE STATE ---
init_session_state()

# --- 3. DYNAMIC SIDEBAR (Admin Branding) ---
t_name, l_logo, r_logo = render_sidebar()

# --- 4. THE "COURTIX" HERO HEADER ---
render_hero_header(t_name, l_logo, r_logo)

# --- 5. DASHBOARD METRICS ---
render_metrics()

# --- 6. MAIN NAVIGATION ---
tab_reg, tab_draw, tab_print = st.tabs(
    ["01 REGISTRO", "02 GENERAR DRAW", "03 EXPORTAR & IMPRIMIR"]
)

with tab_reg:
    render_registration_view()

with tab_draw:
    render_draw_view()

with tab_print:
    render_export_view()

# --- 7. FOOTER ---
st.caption("Donated to Nayar Club Campestre - @hugoaguirre")
