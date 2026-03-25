import streamlit as st

def render_metrics():
    _df = st.session_state.players_df
    total_players = len(_df)
    count_pago_confirmado = len(_df[_df['Pago'].str.upper() == 'PAGADO'])
    count_pago_pendiente = len(_df[_df['Pago'].str.upper() == 'PENDIENTE'])

    m1, m2, m3, m4 = st.columns(4)
    m1.metric(label="Jugadores Registrados", value=str(total_players), delta=None)
    m2.metric(label="Pagos Confirmados", value=str(count_pago_confirmado), delta=None)
    m3.metric(label="Pagos Pendientes", value=str(count_pago_pendiente), delta=None, delta_color="inverse")
    m4.metric(label="Partidos Próximos", value="16", delta=None)
