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
        f_cat = st.selectbox("Categoría", ["Varonil", "Femenil"], index=["Varonil", "Femenil"].index(player_data.get("Categoría", "Varonil")) if player_data.get("Categoría") in ["Varonil", "Femenil"] else 0)
    
        # Determine valid subcategories based on category
        scat_options = ["AA", "A", "B", "C", "D", "Mini-Tenis", "8-10 años"]
        current_scat = str(player_data.get("Subcategoría", "A"))
        scat_index = scat_options.index(current_scat) if current_scat in scat_options else 0
        f_scat = st.selectbox("Subcategoría", scat_options, index=scat_index)
        
    with c2:
        f_last = st.text_input("Apellido(s)", value=str(player_data.get("Apellido", "")), placeholder="Ej. Federer")
        f_phone = st.text_input("Celular", value=str(player_data.get("Celular", "")), placeholder="Ej. 311...")
    
    current_pago = str(player_data.get("Pago", "Pendiente"))
    pago_index = ["Pagado", "Pendiente"].index(current_pago) if current_pago in ["Pagado", "Pendiente"] else 1
    f_pago = st.selectbox("Estado de Pago", ["Pagado", "Pendiente"], index=pago_index)
    
    st.markdown("---")
    c3, c4 = st.columns(2)
    with c3:
        current_singles = player_data.get("Singles", "Sí")
        # Handle backward compatibility if the CSV previously didn't have the column
        is_singles = False if pd.isna(current_singles) or str(current_singles).strip() == "No" else True
        f_singles = st.toggle("Juega Singles", value=is_singles)
    with c4:
        current_dobles = player_data.get("Dobles", "No")
        is_dobles = False if pd.isna(current_dobles) or str(current_dobles).strip() == "No" else True
        f_dobles = st.toggle("Juega Dobles", value=is_dobles)
        
    f_partner_label = "Ninguna"
    partner_map = {}
    current_partner = str(player_data.get("Pareja de dobles", "")).strip()
    
    if f_dobles:
        st.markdown("<br>", unsafe_allow_html=True)
        with st.container(border=True):
            st.markdown("<div style='color: #CCFF00; font-size: 16px; font-weight: bold; font-family: \"Montserrat\", sans-serif; margin-bottom: 12px;'>Asignar Pareja de Dobles</div>", unsafe_allow_html=True)
            st.markdown(f"<div style='font-size: 16px; font-weight: bold; font-family: \"Montserrat\", sans-serif; margin-bottom: 1rem; color: #ffffff;'>Jugador 1: {f_name} {f_last} &nbsp;&nbsp;|&nbsp;&nbsp; Cat: {f_scat}</div>", unsafe_allow_html=True)
            
            df = st.session_state.players_df
            eligible_partners_df = df[
                (df["Categoría"] == f_cat) & 
                (df["Subcategoría"] == f_scat) & 
                (df.index != idx)
            ]
            
            partner_options = ["Ninguna"]
            default_idx = 0
            
            for p_idx, row in eligible_partners_df.iterrows():
                p_fullname = f"{row['Nombre']} {row['Apellido']}"
                partner_options.append(p_fullname)
                partner_map[p_fullname] = p_idx
                
                if current_partner and p_fullname == current_partner:
                    default_idx = len(partner_options) - 1
            
            st.markdown("<div style='font-size: 16px; font-weight: bold; font-family: \"Montserrat\", sans-serif; margin-bottom: 0.5rem; color: #ffffff;'>Jugador 2 (Buscar pareja...)</div>", unsafe_allow_html=True)
            f_partner_label = st.selectbox("Jugador 2", partner_options, index=default_idx, label_visibility="collapsed")
            
            p1_fullname = f"{f_name} {f_last}".strip()
            
            # Conflict Detection Logic
            partner_conflict = False
            p2_existing_partner = ""
            if f_partner_label != "Ninguna":
                p2_idx = partner_map[f_partner_label]
                p2_record = st.session_state.players_df.loc[p2_idx]
                p2_existing_partner = str(p2_record.get("Pareja de dobles", "")).strip()
                
                if p2_existing_partner and p2_existing_partner != p1_fullname:
                    partner_conflict = True
                    
            if partner_conflict:
                st.markdown("<br>", unsafe_allow_html=True)
                st.warning(f"{f_partner_label} ya tiene una pareja de dobles: {p2_existing_partner}, si continuas, quitarás a {p2_existing_partner} de la pareja.")
    
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
    
    # Buttons Flow Intercept
    update_clicked = False
    if f_dobles and partner_conflict:
        c_btn1, c_btn2 = st.columns(2)
        with c_btn1:
            if st.button("Cancelar", use_container_width=True):
                st.rerun()
        with c_btn2:
            if st.button("Continuar", type="primary", use_container_width=True):
                update_clicked = True
    else:
        if st.button("ACTUALIZAR", type="primary", use_container_width=True):
            update_clicked = True
            
    if update_clicked:
        if f_name and f_last and f_phone:
            # Base variables Update
            st.session_state.players_df.loc[idx, "Categoría"] = f_cat
            st.session_state.players_df.loc[idx, "Subcategoría"] = f_scat
            st.session_state.players_df.loc[idx, "Nombre"] = f_name
            st.session_state.players_df.loc[idx, "Apellido"] = f_last
            st.session_state.players_df.loc[idx, "Celular"] = f_phone
            st.session_state.players_df.loc[idx, "Pago"] = f_pago
            st.session_state.players_df.loc[idx, "Singles"] = "Sí" if f_singles else "No"
            st.session_state.players_df.loc[idx, "Dobles"] = "Sí" if f_dobles else "No"
            
            # Bi-directional Pareja sync
            if f_dobles and f_partner_label != "Ninguna":
                p2_idx = partner_map[f_partner_label]
                p2_fullname = st.session_state.players_df.loc[p2_idx, "Nombre"] + " " + st.session_state.players_df.loc[p2_idx, "Apellido"]
                
                # Sweep 1: If P1 had an OLD partner that they are abandoning, clear P1's old partner's record
                if current_partner and current_partner != p2_fullname:
                    old_mask_p1 = (st.session_state.players_df["Pareja de dobles"] == p1_fullname)
                    st.session_state.players_df.loc[old_mask_p1, "Pareja de dobles"] = ""
                    st.session_state.players_df.loc[old_mask_p1, "Dobles"] = "No"
                    
                # Sweep 2: If P2 had an OLD partner (p2_existing_partner) that P2 is abandoning, clear P2's old partner's record
                p2_existing_par = str(st.session_state.players_df.loc[p2_idx, "Pareja de dobles"]).strip()
                if p2_existing_par and p2_existing_par != p1_fullname:
                    old_mask_p2 = (st.session_state.players_df["Pareja de dobles"] == p2_fullname)
                    st.session_state.players_df.loc[old_mask_p2, "Pareja de dobles"] = ""
                    st.session_state.players_df.loc[old_mask_p2, "Dobles"] = "No"
                
                # Assign mutually explicitly
                st.session_state.players_df.loc[idx, "Pareja de dobles"] = p2_fullname
                st.session_state.players_df.loc[p2_idx, "Pareja de dobles"] = p1_fullname
                st.session_state.players_df.loc[p2_idx, "Dobles"] = "Sí"
            else:
                # Coach effectively unpaired this player to "Ninguna" entirely
                if current_partner:
                    old_mask = (st.session_state.players_df["Pareja de dobles"] == p1_fullname)
                    st.session_state.players_df.loc[old_mask, "Pareja de dobles"] = ""
                    st.session_state.players_df.loc[old_mask, "Dobles"] = "No"
                st.session_state.players_df.loc[idx, "Pareja de dobles"] = ""
                
            st.rerun()
        else:
            st.error("Por favor llena todos los campos.")


@st.dialog("NUEVO JUGADOR")
def show_add_player_dialog():
    st.markdown("### Datos del Jugador")
    c1, c2 = st.columns(2)
    with c1:
        f_name = st.text_input("Nombre(s)", placeholder="Ej. Roger")
        f_cat = st.selectbox("Categoría", ["Varonil", "Femenil"])
        f_scat = st.selectbox("Subcategoría", ["AA", "A", "B", "C", "D", "Mini-Tenis", "8-10 años"])
    with c2:
        f_last = st.text_input("Apellido(s)", placeholder="Ej. Federer")
        f_phone = st.text_input("Celular", placeholder="Ej. 311...")
    
    f_pago = st.selectbox("Estado de Pago", ["Pagado", "Pendiente"])
    
    st.markdown("---")
    c3, c4 = st.columns(2)
    with c3:
        f_singles = st.toggle("Juega Singles", value=True)
    with c4:
        f_dobles = st.toggle("Juega Dobles", value=False)
    
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
                "Nombre": f_name,
                "Apellido": f_last,
                "Subcategoría": f_scat,
                "Categoría": f_cat,
                "Pago": f_pago,
                "Celular": f_phone,
                "Singles": "Sí" if f_singles else "No",
                "Dobles": "Sí" if f_dobles else "No",
                "Pareja de dobles": ""
            }])
            st.session_state.players_df = pd.concat([st.session_state.players_df, new_player], ignore_index=True)
            st.rerun()
        else:
            st.error("Por favor llena todos los campos.")
