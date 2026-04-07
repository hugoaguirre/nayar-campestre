import streamlit as st
import pandas as pd

def render_metrics():
    _df = st.session_state.get('players_df', pd.DataFrame())
    
    # Ensure dataframe has expected columns to avoid KeyError
    if _df.empty or 'Pago' not in _df.columns:
        total_players = 0
        count_pago_confirmado = 0
        count_pago_pendiente = 0
    else:
        total_players = len(_df)
        # Handle cases where 'Pago' might contain NaNs or non-string values
        count_pago_confirmado = len(_df[_df['Pago'].astype(str).str.upper() == 'PAGADO'])
        count_pago_pendiente = len(_df[_df['Pago'].astype(str).str.upper() == 'PENDIENTE'])

    m1, m2, m3, m4 = st.columns(4)
    m1.metric(label="Jugadores Registrados", value=str(total_players), delta=None)
    m2.metric(label="Pagos Confirmados", value=str(count_pago_confirmado), delta=None)
    m3.metric(label="Pagos Pendientes", value=str(count_pago_pendiente), delta=None, delta_color="inverse")
    m4.metric(label="Partidos Próximos", value="16", delta=None)
