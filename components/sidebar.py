import streamlit as st

def render_sidebar():
    with st.sidebar:
        # Navigation back to landing
        if st.button("⬅ SALIR AL INICIO", use_container_width=True):
            st.session_state.tournament_active = False
            st.session_state.tournament_data = None
            st.rerun()

        st.markdown("### CONFIGURACIÓN")
        current_name = st.session_state.tournament_data.get('name', "KIA OPEN 2026")
        current_courts = st.session_state.tournament_data.get('num_courts', 6)
        is_finalized = st.session_state.tournament_data.get('is_finalized', False)
        
        def on_name_change():
            new_val = st.session_state.sidebar_tournament_name
            if new_val and new_val != current_name:
                from utils.supabase_client import get_supabase_client
                supabase = get_supabase_client()
                t_id = st.session_state.tournament_data.get('id')
                if t_id:
                    try:
                        supabase.table('tournaments').update({'name': new_val}).eq('id', t_id).execute()
                        st.session_state.tournament_data['name'] = new_val
                        st.toast("Nombre actualizado exitosamente 💾")
                    except Exception as e:
                        pass
        
        def on_courts_change():
            new_val = st.session_state.sidebar_tournament_courts
            if new_val and new_val != current_courts:
                from utils.supabase_client import get_supabase_client
                supabase = get_supabase_client()
                t_id = st.session_state.tournament_data.get('id')
                if t_id:
                    try:
                        supabase.table('tournaments').update({'num_courts': new_val}).eq('id', t_id).execute()
                        st.session_state.tournament_data['num_courts'] = new_val
                        st.toast("Canchas actualizadas exitosamente 💾")
                    except Exception as e:
                        pass
                        
        t_name = st.text_input("Nombre en Pantalla", current_name, disabled=is_finalized, key="sidebar_tournament_name", on_change=on_name_change)
        t_courts = st.number_input("Canchas Físicas", min_value=1, max_value=20, value=current_courts, disabled=is_finalized, key="sidebar_tournament_courts", on_change=on_courts_change)
        
        st.markdown("<br>", unsafe_allow_html=True)
        if st.button("🗓️ MODIFICAR FECHAS", use_container_width=True, disabled=is_finalized):
            from components.dialogs import show_edit_dates_dialog
            show_edit_dates_dialog()
            
        st.divider()
        l_logo = st.file_uploader("Patrocinador Izquierdo (Nayar)", type=["png", "jpg"], disabled=is_finalized)
        r_logo = st.file_uploader("Patrocinador Derecho (Kia)", type=["png", "jpg"], disabled=is_finalized)
        st.divider()

        # --- COACH SESSION INFO ---
        current_user = st.session_state.get('user')
        if current_user:
            coach_name = current_user.get('display_name', 'Coach')
            coach_email = current_user.get('email', '')
            st.markdown(
                f"""
                <div style="
                    background: rgba(255,255,255,0.08);
                    backdrop-filter: blur(15px);
                    border: 1px solid rgba(255,255,255,0.15);
                    border-radius: 50px;
                    padding: 0.6rem 1rem;
                    margin-bottom: 0.75rem;
                    text-align: center;
                ">
                    <span style="font-family: 'Montserrat', sans-serif; font-weight: 700; font-size: 0.8rem; color: #CCFF00;">
                        🎾 {coach_name}
                    </span><br/>
                    <span style="font-family: 'Inter', sans-serif; font-size: 0.65rem; color: rgba(255,255,255,0.5);">
                        {coach_email}
                    </span>
                </div>
                """,
                unsafe_allow_html=True,
            )
            if st.button("🚪 CERRAR SESIÓN", use_container_width=True, key="sidebar_logout"):
                from utils.auth import logout_user
                logout_user()
        
        st.caption("Donación por Hugo Aguirre | Version 1.0")
        
    return t_name, l_logo, r_logo
