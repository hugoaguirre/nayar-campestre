import streamlit as st
import pandas as pd

def init_session_state():
    if "players_df" not in st.session_state:
        st.session_state.players_df = pd.DataFrame(
            columns=["Categoría", "Subcategoría", "Nombre", "Apellido", "Celular", "Pago", "Singles", "Dobles"]
        )
