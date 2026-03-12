import streamlit as st

def render_draw_view():
    col_l, col_r = st.columns(2)
    with col_l:
        st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
        st.subheader("Lógica de Grupos")
        cat_select = st.selectbox("Categoría", ["AA", "A", "B", "C", "D", "Infantil"])
        if st.button("SORTEAR Y CREAR GRUPOS"):
            st.success(f"Grupos generados para {cat_select}")

    with col_r:
        st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
        st.subheader("Vista Previa: Infantil")
        # Visualizing the 4x4 grid we discussed earlier
        st.markdown("""
        <div class="player-card">
            <span><strong>Seed 1</strong> Sara Alexandra</span>
            <span><em>vs</em></span>
            <span><strong>Seed 2</strong> Diego Manzano</span>
        </div>
        <div class="player-card">
            <span><strong>Seed 3</strong> Mariel Lozano</span>
            <span><em>vs</em></span>
            <span><strong>Seed 4</strong> Amelí Chatelet</span>
        </div>
        """, unsafe_allow_html=True)
        
        st.markdown("<br>", unsafe_allow_html=True)
        st.success("El Grupo 1 está equilibrado y listo.")
