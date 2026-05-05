import streamlit as st

from utils.theme import apply_wimbledon_ui
from utils.state import init_session_state
from utils.auth import get_current_user

# --- 1. PAGE CONFIG & THEME INJECTION ---
st.set_page_config(
    page_title="Club Nayar Campestre - Tenis | Manejador de Torneos", 
    layout="wide",
    initial_sidebar_state="expanded"
)

apply_wimbledon_ui()

# --- 2. INITIALIZE STATE ---
init_session_state()

# --- 3. CHECK AUTH ---
user = get_current_user()

# --- 4. PAGE DEFINITIONS ---
# Public pages (always visible)
ranking_page = st.Page("pages/public/ranking.py", title="Ranking", icon="🏆", default=True)

# Auth pages
login_page = st.Page("pages/auth/login.py", title="Iniciar Sesión", icon="🔒")
logout_page = st.Page("pages/auth/logout.py", title="Cerrar Sesión", icon="🚪")

# Admin pages (only visible to logged-in coaches)
torneos_page = st.Page("pages/admin/torneos.py", title="Torneos", icon="🎾")
ranking_admin_page = st.Page("pages/admin/ranking_admin.py", title="Admin Ranking", icon="📊")

# --- 5. NAVIGATION ROUTING ---
if user:
    pg = st.navigation({
        "PÚBLICO": [ranking_page],
        "ADMINISTRACIÓN": [torneos_page, ranking_admin_page],
        "SESIÓN": [logout_page],
    })
else:
    pg = st.navigation({
        "PÚBLICO": [ranking_page],
        "ACCESO": [login_page],
    })

pg.run()
