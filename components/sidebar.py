import streamlit as st

def render_sidebar():
    with st.sidebar:
        # Navigation back to landing
        if st.button("⬅ SALIR AL INICIO", use_container_width=True):
            st.session_state.tournament_active = False
            st.session_state.tournament_data = None
            st.rerun()

        st.markdown("### CONFIGURACIÓN")
        # Default to the active tournament name
        current_name = st.session_state.tournament_data.get('name', "KIA OPEN 2026")
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
                        
        t_name = st.text_input("Nombre en Pantalla", current_name, disabled=is_finalized, key="sidebar_tournament_name", on_change=on_name_change)
        
        st.markdown("<br>", unsafe_allow_html=True)
        if st.button("🗓️ MODIFICAR FECHAS", use_container_width=True, disabled=is_finalized):
            from components.dialogs import show_edit_dates_dialog
            show_edit_dates_dialog()
            
        st.divider()
        l_logo = st.file_uploader("Patrocinador Izquierdo (Nayar)", type=["png", "jpg"], disabled=is_finalized)
        r_logo = st.file_uploader("Patrocinador Derecho (Kia)", type=["png", "jpg"], disabled=is_finalized)
        st.divider()
        st.caption("Donación por Hugo Aguirre | Version 1.0")
        
    return t_name, l_logo, r_logo
