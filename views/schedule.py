import streamlit as st
import pandas as pd
from datetime import datetime
from services.scheduling_service import SchedulingService


def render_schedule_view():
    st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
    st.subheader("Programación de Partidos y Canchas")

    t_id = st.session_state.tournament_data.get("id")
    is_finalized = st.session_state.tournament_data.get("is_finalized", False)
    t_start = st.session_state.tournament_data.get("start_date")
    t_end = st.session_state.tournament_data.get("end_date")

    if not t_start or not t_end:
        st.warning(
            "El torneo no tiene fechas definidas válidas. Edita la configuración inicial."
        )
        return

    c1, c2 = st.columns([1.5, 1])

    with c1:
        html_duracion = f"""
        <div style="font-family: 'Montserrat', sans-serif; font-size: 1.15rem; font-weight: 500; margin-bottom: 15px; color: #ffffff;">
            Duración: 
            <span style="background-color: #450084; color: #CCFF00; padding: 4px 10px; border-radius: 6px; font-weight: 800; letter-spacing: 0.5px;">{t_start}</span> 
            al 
            <span style="background-color: #450084; color: #CCFF00; padding: 4px 10px; border-radius: 6px; font-weight: 800; letter-spacing: 0.5px;">{t_end}</span>
        </div>
        """
        st.markdown(html_duracion, unsafe_allow_html=True)
        st.info(
            "El Motor de Programación utilizará estas fechas, omitiendo los lunes y reservando las noches (19:00 - 20:30) para las categorías AA, A y B+"
        )
        
        # Read the strict global court constraint natively from the database config
        num_courts = st.session_state.tournament_data.get('num_courts', 6)
        st.markdown(f"**Canchas Habilitadas Configuración Global:** {num_courts}")

    with c2:
        if st.button(
            "CARGAR PARTIDOS",
            type="primary",
            use_container_width=True,
            disabled=is_finalized,
        ):
            with st.spinner("Transformando Draws..."):
                if SchedulingService.generate_round_robin_matches(t_id):
                    st.success("Listos para ser programados.")
                    st.rerun()
                else:
                    st.error("Error al generar partidos.")

        if st.button(
            "AUTO-PROGRAMAR",
            type="primary",
            use_container_width=True,
            disabled=is_finalized,
        ):
            with st.spinner("Asignando Horarios..."):
                res = SchedulingService.auto_schedule_matches(
                    t_id, t_start, t_end, num_courts
                )
                if isinstance(res, dict) and res.get("success"):
                    if res.get("failed", 0) > 0:
                        st.warning(f"¡Horarios asignados! Sin embargo, {res['failed']} partidos no pudieron ser programados porque las fechas/canchas resultaron insuficientes.")
                    else:
                        st.success("¡Horarios asignados automáticamente a todos los partidos!")
                    st.rerun()
                elif res is True:
                    st.success("¡Horarios asignados automáticamente!")
                    st.rerun()
                else:
                    st.error("No se pudo completar la programación.")

        if st.button(
            "LIMPIAR HORARIOS",
            type="primary",
            use_container_width=True,
            disabled=is_finalized,
        ):
            from components.dialogs import show_wipe_schedule_dialog

            show_wipe_schedule_dialog(t_id)

    st.markdown("---")

    matches = SchedulingService.get_all_matches(t_id)
    if not matches:
        st.caption("Aún no hay partidos generados para este torneo.")
        return

    # Build dataframe for display
    def build_row(m):
        c_name = m.get("categories", {}).get("name", "N/A")
        sc_name = m.get("subcategories", {}).get("name", "N/A")
        m_type = m.get("match_type", "Singles")

        # Player parsing (Singles and Doubles formats seamlessly handled)
        p1 = m.get("p1", {}) or {}
        p1_par = m.get("p1_par", {}) or {}

        p2 = m.get("p2", {}) or {}
        p2_par = m.get("p2_par", {}) or {}

        team_a = (
            f"{p1.get('first_name', '')} {p1.get('last_name', '')}".strip()
            or "Por definir"
        )
        if p1_par.get("first_name"):
            team_a += f" / {p1_par.get('first_name')} {p1_par.get('last_name')}".strip()

        team_b = (
            f"{p2.get('first_name', '')} {p2.get('last_name', '')}".strip()
            or "Por definir"
        )
        if p2_par.get("first_name"):
            team_b += f" / {p2_par.get('first_name')} {p2_par.get('last_name')}".strip()

        # Court parsing
        court_name = (
            m.get("courts", {}).get("name", "PENDIENTE")
            if m.get("courts")
            else "PENDIENTE"
        )

        # Time formatting
        time_str = "SIN HORARIO"
        date_str = ""
        hour_str = ""

        scheduled_raw = m.get("scheduled_time")
        if scheduled_raw:
            try:
                clean_raw = scheduled_raw.replace("Z", "+00:00")
                dt = datetime.fromisoformat(clean_raw)
                date_str = dt.strftime("%Y-%m-%d")
                hour_str = dt.strftime("%H:%M")
            except Exception:
                pass

        return {
            "Fecha": date_str if date_str else "Sin Especificar",
            "Hora": hour_str if hour_str else "...",
            "Categoría": f"{c_name} - {sc_name} ({m_type})",
            "Fase": m.get("stage", ""),
            "Equipo A": team_a,
            "vs": "vs",
            "Equipo B": team_b,
            "Cancha": court_name,
            "Estado": m.get("status", "Scheduled"),
        }

    df_matches = pd.DataFrame([build_row(m) for m in matches])

    # Simple metric top stats
    total = len(df_matches)
    pending_alloc = len(df_matches[df_matches["Cancha"] == "PENDIENTE"])
    scheduled = total - pending_alloc

    c_m1, c_m2, c_m3 = st.columns(3)
    c_m1.metric("Total de Partidos", total)
    c_m2.metric("Partidos Programados", scheduled)
    c_m3.metric("Por Asignar", pending_alloc)

    # Search and Filter
    col_f1, col_f2 = st.columns([1, 2])
    with col_f1:
        f_day = st.selectbox(
            "Filtrar por Fecha", ["Todas"] + list(df_matches["Fecha"].unique())
        )
    with col_f2:
        search_q = st.text_input(
            "Buscar jugador...", placeholder="Busca en el partido..."
        )

    if f_day != "Todas":
        df_matches = df_matches[df_matches["Fecha"] == f_day]

    if search_q:
        q = search_q.lower()
        mask = df_matches["Equipo A"].str.lower().str.contains(q) | df_matches[
            "Equipo B"
        ].str.lower().str.contains(q)
        df_matches = df_matches[mask]

    # Group rendering by Fecha
    st.markdown("---")

    if df_matches.empty:
        st.info("No se encontraron partidos con esos filtros.")
    else:
        # Sort master initially to guarantee chronological dates
        df_matches = df_matches.sort_values(by=["Fecha", "Hora", "Cancha"])

        for date_str, group_df in df_matches.groupby("Fecha", sort=False):
            if date_str == "Sin Especificar":
                human_date = "Partidos Sin Asignar"
            else:
                try:
                    dt_obj = datetime.strptime(date_str, "%Y-%m-%d")
                    meses = [
                        "Enero",
                        "Febrero",
                        "Marzo",
                        "Abril",
                        "Mayo",
                        "Junio",
                        "Julio",
                        "Agosto",
                        "Septiembre",
                        "Octubre",
                        "Noviembre",
                        "Diciembre",
                    ]
                    human_date = f"Partidos del {meses[dt_obj.month - 1]} {dt_obj.day} del {dt_obj.year}"
                except ValueError:
                    human_date = f"Partidos del {date_str}"

            st.markdown(f"#### {human_date}")

            # Drop the redundant columns for cleanly separated tables
            display_df = group_df.drop(columns=["Fecha"]).reset_index(drop=True)

            st.dataframe(display_df, use_container_width=True, hide_index=True)
            st.markdown("<br>", unsafe_allow_html=True)
