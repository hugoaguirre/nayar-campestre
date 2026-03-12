import streamlit as st

def render_export_view():
    st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
    st.subheader("Exportar PDF")
    st.write("Genera los documentos para la mesa de control del club.")

    c1, c2 = st.columns(2)
    with c1:
        st.button("DESCARGAR FORMATO ROUND ROBIN", use_container_width=True)
    with c2:
        st.button("DESCARGAR FORMATO 16-JUGADORES", use_container_width=True)
