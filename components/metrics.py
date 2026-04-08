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
    t_start = st.session_state.tournament_data.get("start_date")
    t_end = st.session_state.tournament_data.get("end_date")
    t_courts = st.session_state.tournament_data.get("num_courts", 6)
    
    if t_start and t_end and total_players > 0:
        import sys
        import os
        sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
        from core.capacity_planner import calculate_max_capacity
        
        max_matches = calculate_max_capacity(t_start, t_end, t_courts)
        
        # 4 Players = 6 RR matches + 1 Knockout match = 7 Matches total
        # Ratio: 1.75 matches per registered participation
        projected_matches = int(total_players * 1.75)
        
        if max_matches > 0:
            percentage = min(100, int((projected_matches / max_matches) * 100))
            if projected_matches > max_matches:
                m4.metric(
                    label="🚨 Carga de Canchas", 
                    value=f"{projected_matches} / {max_matches}", 
                    delta="¡SOBRECUPO!", 
                    delta_color="inverse"
                )
            else:
                slots_left = max_matches - projected_matches
                est_players_left = int(slots_left / 1.75)
                m4.metric(
                    label="📊 Capacidad de Canchas", 
                    value=f"{percentage}% Lleno", 
                    delta=f"~{est_players_left} registros libres", 
                    delta_color="normal"
                )
        else:
            m4.metric(label="📊 Capacidad (6 Canchas)", value="Fechas Erróneas", delta=None)
    else:
        m4.metric(label="📊 Capacidad (6 Canchas)", value="Configura Torneo", delta=None)
