import streamlit as st
import pandas as pd
from services.tournament_service import TournamentService

def init_session_state():
    # 0. Auth State (set by utils/auth.py during login)
    if "user" not in st.session_state:
        st.session_state.user = None
    if "access_token" not in st.session_state:
        st.session_state.access_token = None
    if "refresh_token" not in st.session_state:
        st.session_state.refresh_token = None

    # 1. Initialize Players DataFrame
    if "players_df" not in st.session_state:
        st.session_state.players_df = pd.DataFrame(
            columns=["Nombre", "Apellido", "Subcategoría", "Categoría", "Pago", "Celular", "Singles", "Dobles"]
        )
    
    # 2. Initialize Tournament State (Always show landing page first)
    if "tournament_active" not in st.session_state:
        st.session_state.tournament_active = False
        st.session_state.tournament_data = None

    # Track if user clicked sync
    if "last_sync" not in st.session_state:
        st.session_state.last_sync = None
