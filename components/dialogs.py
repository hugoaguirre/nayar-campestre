import streamlit as st
import pandas as pd
import streamlit.components.v1 as components
from services.tournament_service import TournamentService


def render_partner_selection_ui(
    f_name, f_last, f_cat, f_scat, current_partner="", idx=None
):
    f_partner_label = "Ninguna"
    partner_map = {}
    partner_conflict = False

    st.markdown("<br>", unsafe_allow_html=True)
    with st.container(border=True):
        st.markdown(
            "<div style='color: #CCFF00; font-size: 16px; font-weight: bold; font-family: \"Montserrat\", sans-serif; margin-bottom: 12px;'>Asignar Pareja de Dobles</div>",
            unsafe_allow_html=True,
        )
        st.markdown(
            f"<div style='font-size: 16px; font-weight: bold; font-family: \"Montserrat\", sans-serif; margin-bottom: 1rem; color: #ffffff;'>Jugador 1: {f_name} {f_last} &nbsp;&nbsp;|&nbsp;&nbsp; Cat: {f_scat}</div>",
            unsafe_allow_html=True,
        )

        df = st.session_state.players_df
        if idx is not None:
            mask = (
                (df["Categoría"] == f_cat)
                & (df["Subcategoría"] == f_scat)
                & (df.index != idx)
            )
        else:
            mask = (df["Categoría"] == f_cat) & (df["Subcategoría"] == f_scat)

        eligible_partners_df = df[mask]

        partner_options = ["Ninguna"]
        default_idx = 0

        for p_idx, row in eligible_partners_df.iterrows():
            p_fullname = f"{row['Nombre']} {row['Apellido']}".strip()
            partner_options.append(p_fullname)
            partner_map[p_fullname] = p_idx

            if current_partner and p_fullname == current_partner:
                default_idx = len(partner_options) - 1

        st.markdown(
            "<div style='font-size: 16px; font-weight: bold; font-family: \"Montserrat\", sans-serif; margin-bottom: 0.5rem; color: #ffffff;'>Jugador 2 (Buscar pareja...)</div>",
            unsafe_allow_html=True,
        )
        f_partner_label = st.selectbox(
            "Jugador 2",
            partner_options,
            index=default_idx,
            label_visibility="collapsed",
        )

        p1_fullname = f"{f_name} {f_last}".strip()
        p2_existing_partner = ""

        if f_partner_label != "Ninguna":
            p2_idx = partner_map[f_partner_label]
            p2_record = st.session_state.players_df.loc[p2_idx]
            p2_existing_partner = str(p2_record.get("Pareja de dobles", "")).strip()

            if p2_existing_partner and p2_existing_partner != p1_fullname:
                partner_conflict = True

        if partner_conflict:
            st.markdown("<br>", unsafe_allow_html=True)
            st.warning(
                f"{f_partner_label} ya tiene una pareja de dobles: {p2_existing_partner}, si continuas, quitarás a {p2_existing_partner} de la pareja."
            )

    return f_partner_label, partner_map, partner_conflict


def apply_bidirectional_doubles_sync(
    p1_idx, f_dobles, f_partner_label, partner_map, p1_fullname, current_partner=""
):
    affected_indices = {p1_idx}

    # Sweep 1: If P1 had an OLD partner that they are abandoning, clear P1's old partner's record
    if (
        current_partner
        and str(current_partner).strip() != ""
        and (
            not f_dobles
            or f_partner_label == "Ninguna"
            or f_partner_label != current_partner
        )
    ):
        old_mask_p1 = st.session_state.players_df["Pareja de dobles"] == p1_fullname
        st.session_state.players_df.loc[old_mask_p1, "Pareja de dobles"] = ""
        st.session_state.players_df.loc[old_mask_p1, "Dobles"] = "No"
        affected_indices.update(st.session_state.players_df[old_mask_p1].index.tolist())

    if f_dobles and f_partner_label != "Ninguna":
        p2_idx = partner_map[f_partner_label]
        p2_fullname = (
            st.session_state.players_df.loc[p2_idx, "Nombre"]
            + " "
            + st.session_state.players_df.loc[p2_idx, "Apellido"]
        )
        p2_fullname = p2_fullname.strip()

        # Sweep 2: If P2 had an OLD partner that P2 is abandoning, clear P2's old partner's record
        p2_existing_par = str(
            st.session_state.players_df.loc[p2_idx, "Pareja de dobles"]
        ).strip()
        if p2_existing_par and p2_existing_par != p1_fullname:
            old_mask_p2 = st.session_state.players_df["Pareja de dobles"] == p2_fullname
            st.session_state.players_df.loc[old_mask_p2, "Pareja de dobles"] = ""
            st.session_state.players_df.loc[old_mask_p2, "Dobles"] = "No"
            affected_indices.update(
                st.session_state.players_df[old_mask_p2].index.tolist()
            )
        # Assign mutually explicitly
        st.session_state.players_df.loc[p1_idx, "Pareja de dobles"] = p2_fullname
        st.session_state.players_df.loc[p2_idx, "Pareja de dobles"] = p1_fullname
        st.session_state.players_df.loc[p2_idx, "Dobles"] = "Sí"
        affected_indices.add(p2_idx)
    else:
        st.session_state.players_df.loc[p1_idx, "Pareja de dobles"] = ""
        if not f_dobles:
            st.session_state.players_df.loc[p1_idx, "Dobles"] = "No"

    return list(affected_indices)


@st.dialog("EDITAR INSCRIPCIÓN")
def show_edit_player_dialog(idx):
    st.markdown("### Datos del Jugador")
    player_data = st.session_state.players_df.loc[idx]

    c1, c2 = st.columns(2)
    
    f_name = str(player_data.get("Nombre", ""))
    f_last = str(player_data.get("Apellido", ""))
    
    with c1:
        # Identity fields are now read-only in the tournament context
        st.text_input("Nombre(s)", value=f_name, disabled=True)
        # Category is now editable per-tournament
        all_cats, _ = TournamentService.fetch_config_options()
        current_cat = player_data.get("Categoría", "Varonil")
        cat_index = all_cats.index(current_cat) if current_cat in all_cats else 0
        f_cat = st.selectbox("Categoría", all_cats, index=cat_index)

        all_cats, all_subcats = TournamentService.fetch_config_options()
        current_scat = str(player_data.get("Subcategoría", "A"))
        scat_index = (
            all_subcats.index(current_scat) if current_scat in all_subcats else 0
        )
        f_scat = st.selectbox("Subcategoría", all_subcats, index=scat_index)

    with c2:
        st.text_input("Apellido(s)", value=f_last, disabled=True)
        st.text_input("Celular", value=str(player_data.get("Celular", "")), disabled=True)

    current_pago = str(player_data.get("Pago", "Pendiente"))
    pago_index = (
        ["Pagado", "Pendiente"].index(current_pago)
        if current_pago in ["Pagado", "Pendiente"]
        else 1
    )
    f_pago = st.selectbox("Estado de Pago", ["Pagado", "Pendiente"], index=pago_index)

    st.markdown("---")
    c3, c4 = st.columns(2)
    with c3:
        current_singles = player_data.get("Singles", "Sí")
        is_singles = (
            False
            if pd.isna(current_singles) or str(current_singles).strip() == "No"
            else True
        )
        f_singles = st.toggle("Juega Singles", value=is_singles)
    with c4:
        current_dobles = player_data.get("Dobles", "No")
        is_dobles = (
            False
            if pd.isna(current_dobles) or str(current_dobles).strip() == "No"
            else True
        )
        f_dobles = st.toggle("Juega Dobles", value=is_dobles)

    f_partner_label = "Ninguna"
    partner_map = {}
    partner_conflict = False
    current_partner = str(player_data.get("Pareja de dobles", "")).strip()

    if f_dobles:
        f_partner_label, partner_map, partner_conflict = render_partner_selection_ui(
            f_name, f_last, f_cat, f_scat, current_partner, idx
        )

    components.html(
        """<script>
            const doc = window.parent.document;
            setTimeout(() => { if (doc.activeElement) { doc.activeElement.blur(); } }, 50);
            setTimeout(() => { if (doc.activeElement) { doc.activeElement.blur(); } }, 150);
        </script>""",
        height=0,
    )

    st.markdown("<br>", unsafe_allow_html=True)
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
        # Identity fields are not updated from here anymore
        st.session_state.players_df.loc[idx, "Categoría"] = f_cat
        st.session_state.players_df.loc[idx, "Subcategoría"] = f_scat
        st.session_state.players_df.loc[idx, "Pago"] = f_pago
        st.session_state.players_df.loc[idx, "Singles"] = "Sí" if f_singles else "No"
        st.session_state.players_df.loc[idx, "Dobles"] = "Sí" if f_dobles else "No"

        p1_fullname = f"{player_data['Nombre']} {player_data['Apellido']}".strip()
        affected = apply_bidirectional_doubles_sync(
            idx, f_dobles, f_partner_label, partner_map, p1_fullname, current_partner
        )

        from utils.supabase_data import (
            upsert_player_to_supabase,
            fetch_tournament_players,
        )

        with st.spinner("Guardando en la nube..."):
            for a_idx in affected:
                # This will only update the Registration in Supabase mapping
                upsert_player_to_supabase(
                    st.session_state.players_df.loc[a_idx].to_dict()
                )
            st.session_state.players_df = fetch_tournament_players()

        st.rerun()


@st.dialog("AÑADIR NUEVO SOCIO")
def show_add_new_socio_dialog():
    """
    Creates a new player in the club database (identity only).
    """
    st.markdown("### Datos Personales del Socio")
    c1, c2 = st.columns(2)
    with c1:
        f_name = st.text_input("Nombre(s)", placeholder="Ej. Roger")
    with c2:
        f_last = st.text_input("Apellido(s)", placeholder="Ej. Federer")

    f_phone = st.text_input("Celular", placeholder="Ej. 311...")

    st.markdown("<br>", unsafe_allow_html=True)
    if st.button("CREAR SOCIO", type="primary", use_container_width=True):
        if f_name and f_last and f_phone:
            from utils.supabase_data import upsert_player_to_supabase

            # Create a registration-free payload for identity only
            payload = {
                "Nombre": f_name,
                "Apellido": f_last,
                "Celular": f_phone,
                "Categoría": "Varonil",  # Placeholders for the logic, but it only creates player record
                "Subcategoría": "A",
                "Singles": "No",
                "Dobles": "No",
                "Pago": "Pendiente",
            }
            with st.spinner("Guardando socio..."):
                if upsert_player_to_supabase(payload):
                    st.success(f"Socio {f_name} {f_last} creado exitosamente.")
                    st.rerun()
                else:
                    st.error("Error al crear el socio.")
        else:
            st.error("Por favor llena todos los campos.")


@st.dialog("NUEVO REGISTRO (MIGRACIÓN)")
def show_add_player_dialog():
    st.markdown("### Datos del Jugador")
    c1, c2 = st.columns(2)
    with c1:
        f_name = st.text_input("Nombre(s)", placeholder="Ej. Roger")
        f_cat = st.selectbox("Categoría", ["Varonil", "Femenil"])
        f_scat = st.selectbox(
            "Subcategoría", ["AA", "A", "B", "C", "D", "Mini-Tenis", "8-10 años"]
        )
    with c2:
        f_last = st.text_input("Apellido(s)", placeholder="Ej. Federer")
        f_phone = st.text_input("Celular", placeholder="Ej. 311...")

    f_pago = st.selectbox("Estado de Pago", ["Pagado", "Pendiente"], index=1)

    st.markdown("---")
    c3, c4 = st.columns(2)
    with c3:
        f_singles = st.toggle("Juega Singles", value=False)
    with c4:
        f_dobles = st.toggle("Juega Dobles", value=False)

    f_partner_label = "Ninguna"
    partner_map = {}
    partner_conflict = False

    if f_dobles:
        f_partner_label, partner_map, partner_conflict = render_partner_selection_ui(
            f_name, f_last, f_cat, f_scat, "", None
        )

    components.html(
        """<script>
            const doc = window.parent.document;
            setTimeout(() => { if (doc.activeElement) { doc.activeElement.blur(); } }, 50);
            setTimeout(() => { if (doc.activeElement) { doc.activeElement.blur(); } }, 150);
        </script>""",
        height=0,
    )

    st.markdown("<br>", unsafe_allow_html=True)
    save_clicked = False

    if f_dobles and partner_conflict:
        c_btn1, c_btn2 = st.columns(2)
        with c_btn1:
            if st.button("Cancelar", use_container_width=True):
                st.rerun()
        with c_btn2:
            if st.button("Continuar", type="primary", use_container_width=True):
                save_clicked = True
    else:
        if st.button("GUARDAR", type="primary", use_container_width=True):
            save_clicked = True

    if save_clicked:
        if f_name and f_last and f_phone:
            new_player = pd.DataFrame(
                [
                    {
                        "Nombre": f_name,
                        "Apellido": f_last,
                        "Subcategoría": f_scat,
                        "Categoría": f_cat,
                        "Pago": f_pago,
                        "Celular": f_phone,
                        "Singles": "Sí" if f_singles else "No",
                        "Dobles": "Sí" if f_dobles else "No",
                        "Pareja de dobles": "",
                    }
                ]
            )

            # Immediately append to the global dataframe to claim a distinct row Index!
            st.session_state.players_df = pd.concat(
                [st.session_state.players_df, new_player], ignore_index=True
            )

            # Capture the newly minted index mathematically
            new_idx = len(st.session_state.players_df) - 1
            p1_fullname = f"{f_name} {f_last}".strip()

            # Invoke the unified sync engine to link partners
            affected = apply_bidirectional_doubles_sync(
                new_idx, f_dobles, f_partner_label, partner_map, p1_fullname, ""
            )

            from utils.supabase_data import (
                upsert_player_to_supabase,
                fetch_tournament_players,
            )

            with st.spinner("Guardando en la nube..."):
                for a_idx in affected:
                    upsert_player_to_supabase(
                        st.session_state.players_df.loc[a_idx].to_dict()
                    )
                st.session_state.players_df = fetch_tournament_players()

            st.rerun()
        else:
            st.error("Por favor llena todos los campos.")


@st.dialog("INSCRIBIR SOCIO AL TORNEO")
def show_register_existing_player_dialog(player_id):
    """
    Dialog to register an existing club member into the active tournament.
    """
    from services.tournament_service import TournamentService
    from utils.supabase_client import get_supabase_client

    supabase = get_supabase_client()
    resp = supabase.table("players").select("*").eq("id", player_id).execute()

    if not resp.data:
        st.error("Socio no encontrado.")
        return

    p_data = resp.data[0]
    st.markdown(f"### Inscribir a: **{p_data['first_name']} {p_data['last_name']}**")

    # Tournament Configuration
    st.markdown("---")
    st.markdown("#### Configuración de Categoría")
    all_cats, all_subcats = TournamentService.fetch_config_options()

    c1, c2 = st.columns(2)
    with c1:
        f_cat = st.selectbox("Categoría", all_cats)
    with c2:
        f_scat = st.selectbox("Subcategoría", all_subcats)

    st.markdown("#### Detalles de Participación")
    f_pago = st.selectbox("Estado de Pago", ["Pagado", "Pendiente"], index=1)

    c3, c4 = st.columns(2)
    with c3:
        f_singles = st.toggle("Juega Singles", value=False)
    with c4:
        f_dobles = st.toggle("Juega Dobles", value=False)

    st.markdown("<br>", unsafe_allow_html=True)
    if st.button("ENROLAR EN TORNEO", type="primary", use_container_width=True):
        if not f_singles and not f_dobles:
            st.warning("Debes seleccionar al menos una modalidad (Singles o Dobles).")
        else:
            from utils.supabase_data import (
                upsert_player_to_supabase,
                fetch_tournament_players,
            )

            reg_payload = {
                "ID_Jugador": p_data["id"],
                "Nombre": p_data["first_name"],
                "Apellido": p_data["last_name"],
                "Categoría": f_cat,
                "Subcategoría": f_scat,
                "Celular": p_data.get("phone", ""),
                "Pago": f_pago,
                "Singles": "Sí" if f_singles else "No",
                "Dobles": "Sí" if f_dobles else "No",
                "Pareja de dobles": "Ninguna",
            }

            with st.spinner("Enrolando..."):
                if upsert_player_to_supabase(reg_payload):
                    st.session_state.players_df = fetch_tournament_players()
                    st.rerun()
                else:
                    st.error("Error al enrolar socio.")

@st.dialog("⚠️ Limpiar Horarios del Torneo")
def show_wipe_schedule_dialog(tournament_id):
    st.warning("Estás a punto de **desprogramar todos los partidos** de este torneo. Perderán su cancha y su hora asignada.")
    st.markdown("Los partidos seguirán existiendo, pero regresarán al listado de 'Por Asignar'.")
    if st.button("Confirmar Limpieza", type="primary", use_container_width=True):
        from services.scheduling_service import SchedulingService
        with st.spinner("Limpiando calendario..."):
            if SchedulingService.wipe_schedules(tournament_id):
                st.success("Calendario en blanco.")
                st.rerun()
            else:
                st.error("Error limpiando horarios.")

@st.dialog("🗓️ Modificar Fechas del Torneo")
def show_edit_dates_dialog():
    st.warning("⚠️ Cambiar las fechas **desprogramará todos los partidos** actuales si ya habías generado un horario o corrido el auto-programador, pues el motor de constraints necesitará recalcular los espacios físicos del club en la nueva temporalidad.")
    
    t_data = st.session_state.tournament_data
    
    from datetime import datetime
    current_start = datetime.strptime(t_data.get('start_date'), '%Y-%m-%d').date() if t_data.get('start_date') else datetime.today().date()
    current_end = datetime.strptime(t_data.get('end_date'), '%Y-%m-%d').date() if t_data.get('end_date') else datetime.today().date()
    
    c1, c2 = st.columns(2)
    with c1:
        new_start = st.date_input("Nueva Fecha de Inicio", value=current_start)
    with c2:
        new_end = st.date_input("Nueva Fecha de Fin", value=current_end)
        
    st.markdown("<br>", unsafe_allow_html=True)
    if st.button("CONFIRMAR Y ACTUALIZAR", type="primary", use_container_width=True):
        if new_start > new_end:
            st.error("La fecha de inicio debe ser antes que la fecha de fin y conclusión.")
        else:
            from utils.supabase_client import get_supabase_client
            from services.scheduling_service import SchedulingService
            
            supabase = get_supabase_client()
            t_id = t_data.get('id')
            
            new_s_str = new_start.strftime('%Y-%m-%d')
            new_e_str = new_end.strftime('%Y-%m-%d')
            
            with st.spinner("Actualizando sistema..."):
                # 1. Update dates in DB
                resp = supabase.table('tournaments').update({
                    'start_date': new_s_str,
                    'end_date': new_e_str
                }).eq('id', t_id).execute()
                
                # 2. Safely wipe schedules so the timeline isn't broken
                SchedulingService.wipe_schedules(t_id)
                
                # 3. Update local session state
                st.session_state.tournament_data['start_date'] = new_s_str
                st.session_state.tournament_data['end_date'] = new_e_str
                
                st.success("Fechas actualizadas exitosamente.")
                st.rerun()
