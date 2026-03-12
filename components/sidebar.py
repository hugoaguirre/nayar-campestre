import streamlit as st

def render_sidebar():
    with st.sidebar:
        st.markdown("### CONFIGURACION")
        t_name = st.text_input("Nombre del Torneo", "KIA OPEN 2026")
        st.divider()
        l_logo = st.file_uploader("Patrocinador Izquierdo (Nayar)", type=["png", "jpg"])
        r_logo = st.file_uploader("Patrocinador Derecho (Kia)", type=["png", "jpg"])
        st.divider()
        st.caption("Donación por Hugo Aguirre | Version 1.0")
        
    return t_name, l_logo, r_logo
