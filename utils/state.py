import streamlit as st
import pandas as pd

def init_session_state():
    if "players_df" not in st.session_state:
        st.session_state.players_df = pd.DataFrame(
            {
                "Categoría": ["Infantil", "Infantil", "Infantil", "Infantil"],
                "Nombre": ["Sara", "Diego", "Mariel", "Amelí"],
                "Apellido": ["Alexandra", "Manzano", "Lozano", "Chatelet"],
                "Celular": ["3111234567", "3117654321", "3119876543", "3114567890"],
                "Pago": ["Confirmado", "Confirmado", "Pendiente", "Confirmado"]
            }
        )
