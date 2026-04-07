import streamlit as st
import pandas as pd
from services.tournament_service import TournamentService
from datetime import datetime, date

def render_landing_view():
    """
    Renders the premium Wimbledon-themed landing page with a list of tournaments
    and an option to create a new one.
    """
    # 1. Page Header
    st.markdown(
        """
        <div style="text-align: center; padding-top: 2rem; padding-bottom: 3rem;">
            <h1 class="hero-title" style="font-size: 80px; margin-bottom: 0;">NAVYAR CLUB</h1>
            <h3 style="color: #CCFF00; letter-spacing: 5px; font-weight: 400; font-family: 'Montserrat', sans-serif;">TENIS • GESTIÓN ESTRATÉGICA</h3>
            <div style="margin-top: 1.5rem;">
                <p style="color: #ffffff; opacity: 0.6; font-size: 0.9rem;">DIRECTORIO DE SOCIOS Y TORNEOS</p>
            </div>
        </div>
        """,
        unsafe_allow_html=True
    )

    # 1.1 Global Actions (Socio Creation)
    c_s1, c_s2, c_s3 = st.columns([2, 1, 2])
    with c_s2:
        if st.button("➕ AÑADIR NUEVO SOCIO", use_container_width=True):
            from components.dialogs import show_add_new_socio_dialog
            show_add_new_socio_dialog()

    # 2. Main Content Layout
    col_left, col_mid, col_right = st.columns([1, 4, 1])
    
    with col_mid:
        # WRAPPER FOR TABS (Single Glossy Container)
        st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
        
        # TABS: LISTADO vs CREACIÓN
        tab_list, tab_create = st.tabs(["🎾 TORNEOS ACTIVOS & HISTORIAL", "🏆 CREAR NUEVO TORNEO"])
        
        with tab_list:
            tournaments = TournamentService.get_all_tournaments()
            
            if not tournaments:
                st.warning("No hay torneos registrados. ¡Crea el primero!", icon="🎾")
            else:
                # SCROLLABLE CONTAINER FOR TOURNAMENTS
                with st.container(height=600, border=False):
                    for t in tournaments:
                        # Determine Status Styling
                        status = t.get('status', 'unknown').lower()
                        status_text = "EN CURSO" if status in ['open', 'active'] else "FINALIZADO"
                        status_color = "#CCFF00" if status in ['open', 'active'] else "#ffffff"
                        
                        with st.container():
                            c1, c2, c3 = st.columns([4, 2, 1])
                            with c1:
                                st.markdown(f"#### {t['name']}")
                                st.markdown(f"<small style='opacity:0.6;'>{t.get('start_date', 'S/F')} — {t.get('end_date', 'S/F')}</small>", unsafe_allow_html=True)
                            with c2:
                                st.markdown(f"<p style='color:{status_color}; font-weight:700; margin-top:10px;'>{status_text}</p>", unsafe_allow_html=True)
                            with c3:
                                if st.button("GESTIONAR", key=f"select_{t['id']}", use_container_width=True):
                                    st.session_state.tournament_active = True
                                    st.session_state.tournament_data = t
                                    # Reset player data to force a fresh fetch for the new tournament
                                    st.session_state.players_df = pd.DataFrame()
                                    st.rerun()
                            st.divider()

        with tab_create:
            # Fetch dynamic options from Supabase
            all_cats, all_subcats = TournamentService.fetch_config_options()
            
            with st.container():
                st.markdown("### CONFIGURACIÓN DEL TORNEO")
                
                # 1. Tournament Name
                t_name = st.text_input("Nombre del Torneo", placeholder="Ej: Copa Presidentes 2026", key="new_t_name")
                
                # 2. Dates
                d1, d2 = st.columns(2)
                with d1:
                    start_date = st.date_input("Fecha Inicio", value=date.today())
                with d2:
                    end_date = st.date_input("Fecha Fin", value=date.today())
                
                # 3. Categories Selection
                st.markdown("#### Categorías")
                selected_cats = st.pills("Categorías", all_cats, selection_mode="multi", default=all_cats, label_visibility="collapsed")
                
                # 4. Subcategories Selection
                st.markdown("#### Subcategorías")
                selected_subcats = st.pills("Subcategorías", all_subcats, selection_mode="multi", default=all_subcats, label_visibility="collapsed")

                st.markdown("<br>", unsafe_allow_html=True)
                
                # 5. Generate Button
                if st.button("GENERAR TORNEO", type="primary", use_container_width=True):
                    if not t_name:
                        st.error("Por favor, ingresa un nombre para el torneo.")
                    elif not selected_cats or not selected_subcats:
                        st.error("Debes seleccionar al menos una categoría y una subcategoría.")
                    else:
                        with st.spinner("Preparando sistema..."):
                            new_t = TournamentService.create_tournament(t_name, start_date, end_date, selected_cats, selected_subcats)
                            if new_t:
                                st.session_state.tournament_active = True
                                st.session_state.tournament_data = new_t
                                # Reset player data to force a fresh fetch for the new tournament
                                st.session_state.players_df = pd.DataFrame()
                                st.rerun()
                            else:
                                st.error("Error al crear el torneo.")

    # Branding Footer for Landing
    st.markdown(
        """
        <div style="position: fixed; bottom: 20px; left: 0; right: 0; text-align: center; opacity: 0.4; pointer-events: none;">
            <p style="font-family: 'Montserrat', sans-serif; font-size: 0.7rem; color: #ffffff; letter-spacing: 2px;">
                ESTABLECIDO 1974 • CLUB NAYAR CAMPESTRE • TOUR MANAGEMENT SYSTEM
            </p>
        </div>
        """,
        unsafe_allow_html=True
    )
