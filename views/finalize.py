import streamlit as st
import pandas as pd
from utils.supabase_data import update_tournament_finalization, fetch_tournament_players
from services.tournament_service import TournamentService

def render_finalize_view():
    st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
    
    t_data = st.session_state.get('tournament_data', {})
    t_id = t_data.get('id')
    t_name = t_data.get('name', 'Torneo')
    is_finalized = t_data.get('is_finalized', False)

    st.markdown(
        f"""
        <div style="text-align: center; margin-bottom: 2rem;">
            <h2 style="color: #CCFF00; font-family: 'Montserrat', sans-serif; letter-spacing: 2px;">RESUMEN DE FINALIZACIÓN</h2>
            <p style="opacity: 0.7;">Verifica los pasos antes de comenzar oficialmente el torneo.</p>
        </div>
        """, 
        unsafe_allow_html=True
    )

    # 1. Checklist / Status Summary
    col1, col2 = st.columns(2)
    
    with col1:
        st.markdown("### 📋 ESTADO ACTUAL")
        players_df = st.session_state.get('players_df', pd.DataFrame())
        if players_df.empty:
            players_df = fetch_tournament_players(t_name)
            st.session_state.players_df = players_df
            
        num_players = len(players_df)
        st.write(f"- **Jugadores Inscritos:** {num_players}")
        st.write(f"- **Categorías:** {t_data.get('categories', 'N/A')}")
        st.write(f"- **Subcategorías:** {t_data.get('subcategories', 'N/A')}")
        
    with col2:
        st.markdown("### 🔒 SEGURIDAD")
        if is_finalized:
            st.success("✅ EL TORNEO ESTÁ FINALIZADO Y BLOQUEADO")
            st.info("No se pueden realizar cambios en el registro ni en los grupos.")
        else:
            st.warning("⚠️ EL TORNEO AÚN ESTÁ EN FASE DE EDICIÓN")
            st.info("Puedes seguir inscribiendo socios y sorteando grupos.")

    st.markdown("---")

    # 2. Action Buttons
    c_btn1, c_btn2, c_btn3 = st.columns([1, 2, 1])
    
    with c_btn2:
        if not is_finalized:
            st.markdown(
                """
                <div style="background: rgba(255, 43, 43, 0.1); border: 1px solid rgba(255, 43, 43, 0.4); padding: 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; text-align: center;">
                    <p style="color: #ff2b2b; font-weight: bold;">¡ATENCIÓN!</p>
                    <p style="font-size: 0.9rem; opacity: 0.8;">Finalizar el torneo bloqueará la edición de grupos y registros para asegurar la integridad de la competencia.</p>
                </div>
                """, 
                unsafe_allow_html=True
            )
            if st.button("🚀 FINALIZAR Y COMENZAR TORNEO", type="primary", use_container_width=True):
                if update_tournament_finalization(t_id, True):
                    st.session_state.tournament_data['is_finalized'] = True
                    st.toast("¡Torneo Finalizado con éxito! 🎾")
                    st.rerun()
                else:
                    st.error("Error al finalizar el torneo en la base de datos.")
        else:
            st.markdown(
                """
                <div style="background: rgba(204, 255, 0, 0.05); border: 1px solid rgba(204, 255, 0, 0.2); padding: 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; text-align: center;">
                    <p style="color: #CCFF00; font-weight: bold;">MODO DE LECTURA ACTIVO</p>
                    <p style="font-size: 0.9rem; opacity: 0.8;">El torneo está en curso. Si necesitas realizar un ajuste de emergencia, desbloquea la edición.</p>
                </div>
                """, 
                unsafe_allow_html=True
            )
            if st.button("🔓 DESBLOQUEAR EDICIÓN", use_container_width=True):
                if update_tournament_finalization(t_id, False):
                    st.session_state.tournament_data['is_finalized'] = False
                    st.toast("Edición desbloqueada. 🔓")
                    st.rerun()
                else:
                    st.error("Error al desbloquear el torneo.")
