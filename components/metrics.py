import streamlit as st

def render_metrics():
    _df = st.session_state.players_df
    total_players = len(_df)
    count_f = len(_df[_df['Categoría'].str.upper() == 'FEMENIL'])
    count_i = len(_df[_df['Categoría'].str.upper() == 'INFANTIL'])
    count_v = len(_df[~_df['Categoría'].str.upper().isin(['FEMENIL', 'INFANTIL'])])

    count_pago_confirmado = len(_df[_df['Pago'].str.upper() == 'CONFIRMADO'])
    count_pago_pendiente = len(_df[_df['Pago'].str.upper() == 'PENDIENTE'])

    m1, m2, m3, m4 = st.columns(4)
    m1.metric(label="Jugadores Registrados", value=str(total_players), delta=f"Varonil: {count_v} Femenil: {count_f} Infantil: {count_i}", delta_color="normal")
    m2.metric(label="Pagos Confirmados", value=str(count_pago_confirmado), delta=None)
    m3.metric(label="Pagos Pendientes", value=str(count_pago_pendiente), delta=None, delta_color="inverse")
    m4.metric(label="Partidos Próximos", value="16", delta=None)
