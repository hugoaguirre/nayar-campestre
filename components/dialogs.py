import streamlit as st
import pandas as pd
import streamlit.components.v1 as components

@st.dialog("EDITAR JUGADOR")
def show_edit_player_dialog(idx):
    st.markdown("### Datos del Jugador")
    
    # Retrieve current data
    player_data = st.session_state.players_df.loc[idx]
    
    c1, c2 = st.columns(2)
    with c1:
        f_name = st.text_input("Nombre(s)", value=str(player_data.get("Nombre", "")), placeholder="Ej. Roger")
        f_cat = st.selectbox("Categoría", ["Varonil", "Femenil", "Infantil"], index=["Varonil", "Femenil", "Infantil"].index(player_data.get("Categoría", "Varonil")) if player_data.get("Categoría") in ["Varonil", "Femenil", "Infantil"] else 0)
        
        # Determine valid subcategories based on category
        scat_options = ["AA", "A", "B", "C", "D"]
        current_scat = str(player_data.get("SubCategoría", "A"))
        scat_index = scat_options.index(current_scat) if current_scat in scat_options else 0
        f_scat = st.selectbox("Subcategoría", scat_options, index=scat_index)
        
    with c2:
        f_last = st.text_input("Apellido(s)", value=str(player_data.get("Apellido", "")), placeholder="Ej. Federer")
        f_phone = st.text_input("Celular", value=str(player_data.get("Celular", "")), placeholder="Ej. 311...")
        f_infantil = st.toggle("Infantil", value=bool(player_data.get("Infantil", False)))
    
    current_pago = str(player_data.get("Pago", "Pendiente"))
    pago_index = ["Confirmado", "Pendiente"].index(current_pago) if current_pago in ["Confirmado", "Pendiente"] else 1
    f_pago = st.selectbox("Estado de Pago", ["Confirmado", "Pendiente"], index=pago_index)
    
    # Inject JavaScript to prevent default Streamlit auto-focusing on the first text input
    components.html(
        """
        <script>
            const doc = window.parent.document;
            setTimeout(() => {
                if (doc.activeElement) { doc.activeElement.blur(); }
            }, 50);
            setTimeout(() => {
                if (doc.activeElement) { doc.activeElement.blur(); }
            }, 150);
        </script>
        """,
        height=0,
    )
    
    st.markdown("<br>", unsafe_allow_html=True)
    if st.button("ACTUALIZAR", type="primary", use_container_width=True):
        if f_name and f_last and f_phone:
            # Update the dataframe directly
            st.session_state.players_df.loc[idx, "Categoría"] = f_cat
            st.session_state.players_df.loc[idx, "SubCategoría"] = f_scat
            st.session_state.players_df.loc[idx, "Nombre"] = f_name
            st.session_state.players_df.loc[idx, "Apellido"] = f_last
            st.session_state.players_df.loc[idx, "Celular"] = f_phone
            st.session_state.players_df.loc[idx, "Pago"] = f_pago
            st.session_state.players_df.loc[idx, "Infantil"] = f_infantil
            st.rerun()
        else:
            st.error("Por favor llena todos los campos.")


@st.dialog("NUEVO JUGADOR")
def show_add_player_dialog():
    st.markdown("### Datos del Jugador")
    c1, c2 = st.columns(2)
    with c1:
        f_name = st.text_input("Nombre(s)", placeholder="Ej. Roger")
        f_cat = st.selectbox("Categoría", ["Varonil", "Femenil", "Infantil"])
        f_scat = st.selectbox("Subcategoría", ["AA", "A", "B", "C", "D"])
    with c2:
        f_last = st.text_input("Apellido(s)", placeholder="Ej. Federer")
        f_phone = st.text_input("Celular", placeholder="Ej. 311...")
        f_infantil = st.toggle("Infantil", value=False)
    
    f_pago = st.selectbox("Estado de Pago", ["Confirmado", "Pendiente"])
    
    # Inject JavaScript to prevent default Streamlit auto-focusing on the first text input
    components.html(
        """
        <script>
            const doc = window.parent.document;
            // Blur the active element slightly after the modal renders to override Streamlit's focus
            setTimeout(() => {
                if (doc.activeElement) {
                    doc.activeElement.blur();
                }
            }, 50);
            setTimeout(() => {
                if (doc.activeElement) {
                    doc.activeElement.blur();
                }
            }, 150);
        </script>
        """,
        height=0,
    )
    
    st.markdown("<br>", unsafe_allow_html=True)
    if st.button("GUARDAR", type="primary", use_container_width=True):
        if f_name and f_last and f_phone:
            new_player = pd.DataFrame([{
                "Categoría": f_cat,
                "SubCategoría": f_scat,
                "Nombre": f_name,
                "Apellido": f_last,
                "Celular": f_phone,
                "Pago": f_pago,
                "Infantil": f_infantil
            }])
            st.session_state.players_df = pd.concat([st.session_state.players_df, new_player], ignore_index=True)
            st.rerun()
        else:
            st.error("Por favor llena todos los campos.")
