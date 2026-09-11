"""
Admin Ranking Page — Coach panel for managing the ladder ranking system.
4 tabs: Escalera, Subcategorías, Programar Semana, Resultados.
"""
import streamlit as st
from datetime import date, time, timedelta
import locale
from itertools import groupby
from utils.auth import get_current_user
from utils.supabase_client import get_supabase_client
from services.ranking_service import RankingService

# ── Auth Guard ────────────────────────────────────────────────
user = get_current_user()
if not user:
    st.error("Acceso denegado. Inicia sesión para continuar.")
    st.stop()

# ── Page-specific CSS ─────────────────────────────────────────
st.markdown("""
<style>
/* ── Position Badges (metallic, matching public page) ───── */
.rank-badge {
    display: inline-block;
    font-family: 'Montserrat', sans-serif;
    font-weight: 900;
    font-size: 0.95rem;
    width: 36px; height: 36px;
    line-height: 36px;
    text-align: center;
    border-radius: 50%;
}
.rank-gold   { background: linear-gradient(145deg, #f5d442, #c9a227); color: #3d2e00; box-shadow: 0 2px 8px rgba(245,212,66,0.3); }
.rank-silver { background: linear-gradient(145deg, #d1d5db, #9ca3af); color: #374151; }
.rank-bronze { background: linear-gradient(145deg, #d4956a, #b07a50); color: #3e2a16; }
.rank-default { background: rgba(255,255,255,0.08); color: rgba(255,255,255,0.6); }

/* ── Sub-category Pills ────────────────────────────────── */
.subcat-pill {
    display: inline-block;
    padding: 2px 10px;
    border-radius: 20px;
    font-family: 'Montserrat', sans-serif;
    font-weight: 700;
    font-size: 0.7rem;
    letter-spacing: 1px;
}
.subcat-A   { background: #CCFF00; color: #003319; }
.subcat-AA  { background: #CCFF00; color: #003319; }
.subcat-Bplus { background: #a78bfa; color: #1e1b4b; }
.subcat-B   { background: #60a5fa; color: #1e3a5f; }
.subcat-C   { background: #34d399; color: #064e3b; }
.subcat-D   { background: #fbbf24; color: #78350f; }

/* ── Match Cards (st.metric style) ─────────────────────── */
.ranking-card {
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.15);
    border-top: 3px solid #450084;
    border-radius: 8px;
    padding: 0.8rem 1rem;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3);
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    margin-bottom: 0.6rem;
}
.ranking-card:hover {
    transform: translateY(-3px);
    background: rgba(255, 255, 255, 0.12);
    border-color: rgba(255, 255, 255, 0.3);
    border-top-color: #450084;
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3);
}

/* ── Phase Labels ──────────────────────────────────────── */
.phase-challenge { color: #ef4444; font-weight: 700; }
.phase-defend { color: #22c55e; font-weight: 700; }

/* ── Admin Scorebug (read-only completed results) ─────── */
.admin-scorebug {
    width: 100%;
    border-collapse: collapse;
    font-family: 'Montserrat', sans-serif;
    margin-top: 0.4rem;
}
.admin-scorebug thead th {
    font-size: 0.6rem;
    color: rgba(255,255,255,0.3);
    font-weight: 600;
    letter-spacing: 1px;
    text-align: center;
    padding: 0.2rem 0;
}
.admin-scorebug thead th:first-child { text-align: left; padding-left: 0.6rem; }
.admin-scorebug tr { border-top: 1px solid rgba(255,255,255,0.06); }
.admin-scorebug tr:first-child { border-top: none; }
.admin-scorebug .sb-name {
    padding: 0.45rem 0.6rem;
    font-weight: 600;
    font-size: 0.82rem;
    color: #ffffff;
    white-space: nowrap;
}
.admin-scorebug .sb-name .sb-pos {
    font-weight: 500;
    font-size: 0.65rem;
    color: rgba(255,255,255,0.45);
    margin-left: 0.3rem;
}
.admin-scorebug .sb-set {
    width: 36px;
    text-align: center;
    padding: 0.45rem 0;
    font-size: 0.85rem;
    font-weight: 500;
    color: rgba(255,255,255,0.5);
    background: rgba(255,255,255,0.04);
    border-left: 1px solid rgba(255,255,255,0.06);
}
.admin-scorebug .sb-set.set-won {
    font-weight: 800;
    color: #CCFF00;
}
.admin-scorebug tr.sb-winner .sb-name { color: #ffffff; font-weight: 700; }
.admin-scorebug tr.sb-loser .sb-name  { color: rgba(255,255,255,0.4); font-weight: 500; }
</style>
""", unsafe_allow_html=True)


# ── Helper: fetch categories ──────────────────────────────────
@st.cache_data(ttl=300)
def _fetch_categories():
    supabase = get_supabase_client()
    resp = supabase.table("categories").select("id, name").execute()
    return resp.data or []

@st.cache_data(ttl=300)
def _fetch_subcategories():
    supabase = get_supabase_client()
    resp = supabase.table("subcategories").select("id, name").order("name").execute()
    return resp.data or []

def _subcat_css_class(name):
    if name in ("A", "AA"):
        return "subcat-A"
    if name in ("B+",):
        return "subcat-Bplus"
    return f"subcat-{name}"

def _rank_badge_class(pos):
    if pos == 1: return "rank-gold"
    if pos == 2: return "rank-silver"
    if pos == 3: return "rank-bronze"
    return "rank-default"


# ── Header ────────────────────────────────────────────────────
st.markdown("""
<div style="text-align:center; margin-bottom:1.5rem;">
    <h1 style="font-family:'Montserrat',sans-serif; font-weight:900;
               font-size:2.8rem; margin:0; letter-spacing:2px;">
        📊 ADMIN RANKING
    </h1>
    <p style="color:#CCFF00; font-family:'Montserrat',sans-serif;
              letter-spacing:4px; font-size:0.85rem; margin-top:0.3rem;">
        PANEL DE ADMINISTRACIÓN
    </p>
</div>
""", unsafe_allow_html=True)

# ── Category Selector ─────────────────────────────────────────
categories = _fetch_categories()
if not categories:
    st.warning("No hay categorías configuradas en la base de datos.")
    st.stop()

cat_names = [c["name"] for c in categories]
selected_cat_name = st.selectbox(
    "CATEGORÍA", cat_names, key="ranking_cat_select",
    help="Selecciona Varonil o Femenil"
)
selected_cat = next(c for c in categories if c["name"] == selected_cat_name)
cat_id = selected_cat["id"]

# ── Tabs ──────────────────────────────────────────────────────
tab_ladder, tab_subcat, tab_schedule, tab_results, tab_modify_results = st.tabs([
    "ESCALERA", "SUBCATEGORÍAS", "PROGRAMAR SEMANA", "RESULTADOS", "MODIFICAR RESULTADOS"
])


# ═══════════════════════════════════════════════════════════════
# TERMINAR RANKING — End Season Dialog
# ═══════════════════════════════════════════════════════════════

@st.dialog("TERMINAR RANKING")
def show_end_ranking_dialog(cat_id, cat_name, user_id):
    """Dialog to archive and/or reset the ranking for a category."""

    st.markdown(f"### Terminar Ranking — {cat_name}")

    st.warning(
        f"Esta acción eliminará **toda la escalera, semanas y partidos** "
        f"de **{cat_name}**. Esta acción no se puede deshacer."
    )

    st.markdown("---")

    save_history = st.toggle("Guardar historial antes de terminar", value=True)

    season_name = ""
    if save_history:
        from datetime import datetime
        _meses = ['','Enero','Febrero','Marzo','Abril','Mayo','Junio',
                  'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']
        now = datetime.now()
        default_name = f"Temporada {_meses[now.month]} {now.year}"
        season_name = st.text_input(
            "Nombre de la temporada",
            value=default_name,
            placeholder="Ej. Temporada Mayo 2026",
        )

    st.markdown("---")
    st.markdown(
        f"Escribe **{cat_name}** para confirmar:",
    )
    confirm = st.text_input("Confirmación", placeholder=cat_name, label_visibility="collapsed")

    st.markdown("<br>", unsafe_allow_html=True)

    c1, c2 = st.columns(2)
    with c1:
        if st.button("CANCELAR", use_container_width=True):
            st.rerun()
    with c2:
        is_disabled = confirm != cat_name
        btn_label = "GUARDAR Y TERMINAR" if save_history else "TERMINAR SIN GUARDAR"
        if st.button(btn_label, type="primary", use_container_width=True, disabled=is_disabled):
            with st.spinner("Procesando..."):
                if save_history:
                    if not season_name.strip():
                        st.error("Escribe un nombre para la temporada.")
                        return
                    season = RankingService.archive_season(cat_id, season_name.strip(), ended_by=user_id)
                    if season:
                        st.toast(f"Temporada '{season_name}' archivada correctamente")
                    else:
                        st.error("Error al archivar la temporada.")
                        return

                success = RankingService.reset_ranking(cat_id)
                if success:
                    st.toast(f"Ranking de {cat_name} reiniciado")
                    st.rerun()
                else:
                    st.error("Error al reiniciar el ranking.")


# ═══════════════════════════════════════════════════════════════
# TAB 1: ESCALERA (Ladder Management)
# ═══════════════════════════════════════════════════════════════
with tab_ladder:
    ladder = RankingService.get_current_ladder(cat_id)

    if not ladder:
        st.info("La escalera está vacía. Agrega jugadores para comenzar.")
    else:
        st.markdown(f"**{len(ladder)} jugadores** en la escalera de {selected_cat_name}")

        for entry in ladder:
            pos = entry["position"]
            name = f"{entry['first_name']} {entry['last_name']}"
            subcat = entry.get("subcategory", "")
            pill_class = _subcat_css_class(subcat) if subcat else ""

            cols = st.columns([0.8, 4, 1.5, 0.8, 0.8, 0.8])

            with cols[0]:
                st.markdown(f'<div class="rank-badge {_rank_badge_class(pos)}">{pos}</div>', unsafe_allow_html=True)
            with cols[1]:
                st.markdown(
                    f"<p style='font-family:Montserrat,sans-serif; font-weight:600; "
                    f"margin:0.5rem 0; font-size:0.95rem;'>{name}</p>",
                    unsafe_allow_html=True,
                )
            with cols[2]:
                if subcat:
                    st.markdown(
                        f'<span class="subcat-pill {pill_class}">{subcat}</span>',
                        unsafe_allow_html=True,
                    )
            with cols[3]:
                if pos > 1:
                    if st.button("⬆", key=f"up_{entry['player_id']}", help="Subir"):
                        RankingService.reorder_player(cat_id, entry["player_id"], pos - 1)
                        st.rerun()
            with cols[4]:
                if pos < len(ladder):
                    if st.button("⬇", key=f"down_{entry['player_id']}", help="Bajar"):
                        RankingService.reorder_player(cat_id, entry["player_id"], pos + 1)
                        st.rerun()
            with cols[5]:
                if st.button("✕", key=f"rm_{entry['player_id']}", help="Eliminar"):
                    RankingService.remove_player_from_ladder(cat_id, entry["player_id"])
                    st.rerun()

    # ── Add Player Section ────────────────────────────────────
    st.divider()
    st.markdown("#### Agregar Jugador a la Escalera")

    existing_ids = RankingService.get_ladder_player_ids(cat_id)
    supabase = get_supabase_client()
    # Filter players by gender column (independent of tournament registrations)
    gender_code = "M" if selected_cat_name == "Varonil" else "F"
    all_players_resp = (
        supabase.table("players")
        .select("id, first_name, last_name")
        .eq("gender", gender_code)
        .order("first_name")
        .execute()
    )
    available = [p for p in (all_players_resp.data or []) if p["id"] not in existing_ids]

    if available:
        player_options = {f"{p['first_name']} {p['last_name']}": p["id"] for p in available}
        add_cols = st.columns([3, 1, 1])
        with add_cols[0]:
            selected_player_name = st.selectbox(
                "Jugador", list(player_options.keys()), key="add_player_select"
            )
        with add_cols[1]:
            max_pos = len(ladder) + 1
            insert_pos = st.number_input("Posición", min_value=1, max_value=max_pos, value=max_pos, key="add_pos")
        with add_cols[2]:
            st.markdown("<br>", unsafe_allow_html=True)
            if st.button("AGREGAR", key="add_player_btn", use_container_width=True):
                RankingService.add_player_to_ladder(cat_id, player_options[selected_player_name], insert_pos)
                st.toast(f"{selected_player_name} agregado en posición #{insert_pos}")
                st.rerun()
    else:
        st.caption("Todos los jugadores ya están en la escalera.")

    # ── Zona de Peligro (Terminar Ranking) ────────────────────
    st.divider()
    st.markdown("""
        <style>
        .danger-zone-card {
            background-color: rgba(255, 60, 60, 0.08);
            border: 1px solid rgba(255, 60, 60, 0.3);
            border-radius: 10px;
            padding: 1.5rem;
            margin-top: 1.5rem;
            margin-bottom: 1rem;
        }
        .danger-zone-card h4 {
            color: #ff4d4d;
            margin-top: 0;
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }
        .danger-zone-card p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            margin-bottom: 0;
        }
        
        /* Target the button immediately following the marker using :has() */
        div.element-container:has(#danger-zone-marker) + div.element-container button {
            background-color: rgba(255, 60, 60, 0.1) !important;
            border: 1px solid rgba(255, 60, 60, 0.5) !important;
            color: #ff4d4d !important;
        }
        div.element-container:has(#danger-zone-marker) + div.element-container button:hover {
            background-color: rgba(255, 60, 60, 0.3) !important;
            border: 1px solid #ff4d4d !important;
            color: white !important;
        }
        </style>
        <div class="danger-zone-card">
            <h4>⚠️ Zona de Peligro</h4>
            <p>
                Al terminar el ranking, se archivará la temporada actual y se <b>eliminarán permanentemente</b>
                todos los partidos, semanas y la escalera actual. Esta acción no se puede deshacer.
            </p>
        </div>
        <div id="danger-zone-marker"></div>
    """, unsafe_allow_html=True)
    
    if st.button("TERMINAR RANKING", key="end_ranking_btn", use_container_width=True):
        show_end_ranking_dialog(cat_id, selected_cat_name, user.get("id"))


# ═══════════════════════════════════════════════════════════════
# TAB 2: SUBCATEGORÍAS (Boundary Configuration)
# ═══════════════════════════════════════════════════════════════
with tab_subcat:
    st.markdown("#### Rangos de Subcategoría")
    st.caption("Define qué posiciones pertenecen a cada subcategoría.")

    subcategories = _fetch_subcategories()
    current_ranges = RankingService.get_subcategory_ranges(cat_id)
    range_map = {r.get("subcategory_id"): r for r in current_ranges}

    # Filter to relevant subcats (skip kids categories for ranking)
    ranking_subcats = [s for s in subcategories if s["name"] not in ("Mini-Tenis", "8-10 años")]
    
    # Sort them according to hierarchy: AA, A, B+, B, C, D
    _order = {"AA": 0, "A": 1, "B+": 2, "B": 3, "C": 4, "D": 5}
    ranking_subcats.sort(key=lambda s: _order.get(s["name"], 99))

    with st.form("subcat_ranges_form", border=True):
        # Encabezados
        h_cols = st.columns([1.5, 1.5, 1.5], vertical_alignment="bottom")
        with h_cols[0]:
            st.markdown("<p style='font-family:Montserrat,sans-serif; font-size:0.8rem; color:rgba(255,255,255,0.6); letter-spacing:1px; margin-bottom:0;'>SUBCATEGORÍA</p>", unsafe_allow_html=True)
        with h_cols[1]:
            st.markdown("<p style='font-family:Montserrat,sans-serif; font-size:0.8rem; color:rgba(255,255,255,0.6); letter-spacing:1px; margin-bottom:0;'>DESDE (Posición)</p>", unsafe_allow_html=True)
        with h_cols[2]:
            st.markdown("<p style='font-family:Montserrat,sans-serif; font-size:0.8rem; color:rgba(255,255,255,0.6); letter-spacing:1px; margin-bottom:0;'>HASTA (Posición)</p>", unsafe_allow_html=True)
            
        st.markdown("<hr style='margin-top:0.5rem; margin-bottom:1rem; border-color:rgba(255,255,255,0.1);'>", unsafe_allow_html=True)

        new_ranges = []
        for sc in ranking_subcats:
            existing = range_map.get(sc["id"], {})
            cols = st.columns([1.5, 1.5, 1.5], vertical_alignment="center")
            with cols[0]:
                pill_class = _subcat_css_class(sc["name"])
                st.markdown(
                    f'<div style="display:flex; align-items:center; height:100%; padding-bottom:1rem;">'
                    f'<span class="subcat-pill {pill_class}" style="font-size:0.9rem; padding:6px 18px;">'
                    f'{sc["name"]}</span></div>',
                    unsafe_allow_html=True,
                )
            with cols[1]:
                ps = st.number_input(
                    f"Desde {sc['name']}", min_value=0, value=existing.get("position_start", 0),
                    key=f"sc_start_{cat_id}_{sc['id']}", label_visibility="collapsed"
                )
            with cols[2]:
                pe = st.number_input(
                    f"Hasta {sc['name']}", min_value=0, value=existing.get("position_end", 0),
                    key=f"sc_end_{cat_id}_{sc['id']}", label_visibility="collapsed"
                )
            if ps > 0 and pe > 0:
                new_ranges.append({
                    "subcategory_id": sc["id"],
                    "position_start": ps,
                    "position_end": pe,
                })

        st.markdown("<br>", unsafe_allow_html=True)
        if st.form_submit_button("GUARDAR RANGOS", use_container_width=True):
            RankingService.save_subcategory_ranges(cat_id, new_ranges)
            st.toast("Rangos de subcategoría actualizados")
            st.rerun()


# ═══════════════════════════════════════════════════════════════
# TAB 3: PROGRAMAR SEMANA (Weekly Scheduling)
# ═══════════════════════════════════════════════════════════════

@st.dialog("Confirmar Generación de Horario")
def confirm_generate_dialog(cat_id, week_num, phase, config):
    """Confirmation dialog before committing a new week to the database."""
    phase_label = "CHALLENGE" if phase == "challenge" else "DEFEND"
    st.markdown(
        f"Estás a punto de crear **Semana {week_num}** ({phase_label})."
    )
    st.warning(
        "Si continúas darás inicio a la semana y esta operación no es reversible "
        "una vez que se registren resultados."
    )

    c1, c2 = st.columns(2)
    with c1:
        if st.button("CANCELAR", use_container_width=True):
            st.rerun()
    with c2:
        if st.button("CONFIRMAR", type="primary", use_container_width=True):
            ladder = RankingService.get_current_ladder(cat_id)
            pairings, resting = RankingService.generate_pairings(ladder, phase, category_id=cat_id)

            week = RankingService.create_week(cat_id, week_num, phase, config)
            if week:
                preview_data = st.session_state.get(f"ranking_preview_{cat_id}")
                preview_matches = None
                if (
                    preview_data
                    and preview_data.get("week_num") == week_num
                    and preview_data.get("phase") == phase
                ):
                    preview_matches = preview_data.get("preview_matches")

                count = RankingService.schedule_ranking_week(
                    week["id"], pairings, week, preview_matches=preview_matches
                )

                if f"ranking_preview_{cat_id}" in st.session_state:
                    del st.session_state[f"ranking_preview_{cat_id}"]

                st.toast(f"Semana {week_num} creada — {count} partidos programados")

                if resting:
                    resting_names = []
                    for entry in ladder:
                        if entry["player_id"] in resting:
                            resting_names.append(f"{entry['first_name']} {entry['last_name']}")
                    st.toast(f"Descansan: {', '.join(resting_names)}")

                st.rerun()
            else:
                st.error("Error al crear la semana.")


with tab_schedule:
    next_week_num, next_phase = RankingService.determine_next_phase(cat_id)

    phase_label = "CHALLENGE — ¡Hora de Subir!" if next_phase == "challenge" else "DEFEND — Defiende tu Corona"
    phase_class = "phase-challenge" if next_phase == "challenge" else "phase-defend"

    st.markdown(f"""
    <div class="ranking-card" style="text-align:center;">
        <p style="font-family:'Montserrat',sans-serif; font-size:0.8rem;
                  color:rgba(255,255,255,0.5); letter-spacing:3px; margin-bottom:0.3rem;">
            PRÓXIMA SEMANA
        </p>
        <h2 style="font-family:'Montserrat',sans-serif; font-weight:900;
                   margin:0;">SEMANA {next_week_num}</h2>
        <p class="{phase_class}" style="font-size:1.1rem; margin-top:0.3rem;">
            {phase_label}
        </p>
    </div>
    """, unsafe_allow_html=True)

    # Date range: next available Saturday → Thursday
    today = date.today()
    days_until_saturday = (5 - today.weekday()) % 7
    if days_until_saturday == 0 and today.weekday() != 5:
        days_until_saturday = 7
    next_saturday = today + timedelta(days=days_until_saturday)
    next_thursday = next_saturday + timedelta(days=5)

    # ── Schedule configuration (non-form for dual button support) ─
    st.markdown("##### Configuración del Horario")
    d_cols = st.columns(2)
    with d_cols[0]:
        start_date = st.date_input("Fecha inicio (Sábado)", value=next_saturday, key="sched_start")
    with d_cols[1]:
        end_date = st.date_input("Fecha fin (Jueves)", value=next_thursday, key="sched_end")

    st.markdown("**Horarios entre semana** (Martes–Jueves)")
    wd_cols = st.columns(2)
    with wd_cols[0]:
        wd_first = st.time_input("Primer juego", value=time(18, 0), key="wd_first")
    with wd_cols[1]:
        wd_last = st.time_input("Último juego", value=time(19, 30), key="wd_last")

    st.markdown("**Horario Sábado**")
    sat_cols = st.columns(2)
    with sat_cols[0]:
        sat_first = st.time_input("Primer juego", value=time(10, 0), key="sat_first")
    with sat_cols[1]:
        sat_last = st.time_input("Último juego", value=time(19, 0), key="sat_last")

    st.markdown("**Horario Domingo**")
    sun_cols = st.columns(2)
    with sun_cols[0]:
        sun_first = st.time_input("Primer juego", value=time(10, 0), key="sun_first")
    with sun_cols[1]:
        sun_last = st.time_input("Último juego", value=time(19, 0), key="sun_last")

    num_courts = st.number_input("Canchas disponibles", min_value=1, max_value=12, value=6, key="sched_courts")

    # ── Build config dict (reused by both preview and generate) ─
    _sched_config = {
        "weekday_first_game": wd_first.strftime("%H:%M"),
        "weekday_last_game": wd_last.strftime("%H:%M"),
        "saturday_first_game": sat_first.strftime("%H:%M"),
        "saturday_last_game": sat_last.strftime("%H:%M"),
        "sunday_first_game": sun_first.strftime("%H:%M"),
        "sunday_last_game": sun_last.strftime("%H:%M"),
        "num_courts": num_courts,
        "week_start_date": start_date,
        "week_end_date": end_date,
    }

    # ── Action buttons ────────────────────────────────────────
    ladder = RankingService.get_current_ladder(cat_id)
    _has_enough_players = len(ladder) >= 2

    preview_key = f"ranking_preview_{cat_id}"

    if _has_enough_players:
        ladder_ids = tuple(e["player_id"] for e in ladder)
        current_params = (next_week_num, next_phase, str(_sched_config), ladder_ids)

        preview_state = st.session_state.get(preview_key)
        if not preview_state or preview_state.get("params") != current_params:
            preview_matches, resting = RankingService.preview_schedule(
                ladder, next_phase, _sched_config, category_id=cat_id
            )
            preview_state = {
                "params": current_params,
                "preview_matches": preview_matches,
                "resting": resting,
                "week_num": next_week_num,
                "phase": next_phase,
            }
            st.session_state[preview_key] = preview_state

        preview_matches = preview_state["preview_matches"]
        resting = preview_state["resting"]

    btn_cols = st.columns([1.2, 1.2, 1.6])

    with btn_cols[0]:
        if _has_enough_players and preview_matches:
            from utils.pdf_export import generate_ranking_week_pdf

            draft_week = {"week_number": next_week_num, "phase": next_phase}
            pdf_bytes = generate_ranking_week_pdf(
                preview_matches, draft_week, selected_cat_name, is_draft=True
            )
            phase_tag = "C" if next_phase == "challenge" else "D"
            preview_file = f"borrador_sem{next_week_num}_{phase_tag}_{selected_cat_name.lower()}.pdf"
            st.download_button(
                "Previsualizar Horario",
                data=pdf_bytes,
                file_name=preview_file,
                mime="application/pdf",
                key="preview_pdf_dl",
                use_container_width=True,
            )
        else:
            st.button("Previsualizar Horario", use_container_width=True, disabled=True)

    with btn_cols[1]:
        if _has_enough_players:
            if st.button("🎲 Mezclar Previsualización", use_container_width=True, key="shuffle_preview_btn"):
                preview_matches, resting = RankingService.preview_schedule(
                    ladder, next_phase, _sched_config, category_id=cat_id
                )
                ladder_ids = tuple(e["player_id"] for e in ladder)
                current_params = (next_week_num, next_phase, str(_sched_config), ladder_ids)
                st.session_state[preview_key] = {
                    "params": current_params,
                    "preview_matches": preview_matches,
                    "resting": resting,
                    "week_num": next_week_num,
                    "phase": next_phase,
                }
                st.toast("🎲 Previsualización reordenada")
                st.rerun()
        else:
            st.button("🎲 Mezclar Previsualización", use_container_width=True, disabled=True)

    with btn_cols[2]:
        generate_clicked = st.button("🚀 GENERAR HORARIO", type="primary", use_container_width=True)

    if _has_enough_players and resting:
        resting_names = [
            f"{e['first_name']} {e['last_name']}"
            for e in ladder if e["player_id"] in resting
        ]
        if resting_names:
            st.info(f"😴 Descansan esta semana: {', '.join(resting_names)}")

    # ── Generate logic (opens confirmation dialog) ────────────
    if generate_clicked:
        if not _has_enough_players:
            st.error("Se necesitan al menos 2 jugadores en la escalera.")
        else:
            confirm_generate_dialog(cat_id, next_week_num, next_phase, _sched_config)

    # ── Show existing weeks ───────────────────────────────────
    st.divider()
    st.markdown("##### 📋 Semanas Anteriores")
    weeks = RankingService.get_weeks(cat_id, limit=5)
    if weeks:
        # Determine which is the latest (most recent) week
        latest_week_id = weeks[0]["id"] if weeks else None

        for w in weeks:
            phase_icon = "C" if w["phase"] == "challenge" else "D"
            status = "Completada" if w["is_completed"] else "En curso"
            is_latest = w["id"] == latest_week_id
            has_completed_matches = False

            week_matches = RankingService.get_week_matches(w["id"])
            if week_matches:
                has_completed_matches = any(m["is_completed"] for m in week_matches)

            # Deletable = latest week + no completed matches
            can_delete = is_latest and not has_completed_matches

            # Layout: info | print | delete (if allowed)
            if can_delete:
                w_cols = st.columns([4, 1.2, 1.2])
            else:
                w_cols = st.columns([4, 1.5])

            with w_cols[0]:
                st.markdown(
                    f"<p style='font-family:Montserrat,sans-serif; font-size:0.9rem; margin:0.4rem 0;'>"
                    f"<b>{phase_icon} Semana {w['week_number']}</b> — "
                    f"{w['week_start_date']} → {w['week_end_date']} — {status}</p>",
                    unsafe_allow_html=True,
                )
            with w_cols[1]:
                if week_matches:
                    from utils.pdf_export import generate_ranking_week_pdf
                    pdf_bytes = generate_ranking_week_pdf(
                        week_matches, w, selected_cat_name
                    )
                    phase_tag = "C" if w["phase"] == "challenge" else "D"
                    file_name = f"ranking_sem{w['week_number']}_{phase_tag}_{selected_cat_name.lower()}.pdf"
                    st.download_button(
                        "Imprimir",
                        data=pdf_bytes,
                        file_name=file_name,
                        mime="application/pdf",
                        key=f"pdf_dl_{w['id']}",
                        use_container_width=True,
                    )
            if can_delete:
                with w_cols[2]:
                    if st.button("Eliminar", key=f"del_wk_{w['id']}", use_container_width=True):
                        RankingService.delete_week(w["id"])
                        st.toast(f"Semana {w['week_number']} eliminada")
                        st.rerun()
    else:
        st.caption("No hay semanas registradas.")


# ═══════════════════════════════════════════════════════════════
# TAB 4: RESULTADOS (Match Results Entry — Draft Workflow)
# ═══════════════════════════════════════════════════════════════
with tab_results:
    weeks = RankingService.get_weeks(cat_id, limit=10)
    if not weeks:
        st.info("No hay semanas programadas. Crea una en la pestaña 'Programar Semana'.")
    else:
        week_options = {
            f"Semana {w['week_number']} ({'C' if w['phase']=='challenge' else 'D'} "
            f"{w['week_start_date']})": w["id"]
            for w in weeks
        }
        selected_week_label = st.selectbox("Seleccionar semana", list(week_options.keys()), key="result_week")
        selected_week_id = week_options[selected_week_label]
        selected_week = next(w for w in weeks if w["id"] == selected_week_id)

        matches = RankingService.get_week_matches(selected_week_id)

        if not matches:
            st.info("No hay partidos en esta semana.")
        else:
            # ── Fetch all drafts for this week (single query) ─
            drafts_map = RankingService.get_week_drafts(selected_week_id)

            completed = sum(1 for m in matches if m["is_completed"])
            draft_count = len(drafts_map)
            st.markdown(f"**{completed}/{len(matches)}** partidos completados")
            if draft_count > 0:
                st.markdown(
                    f'<p style="font-family:\'Montserrat\',sans-serif; font-size:0.8rem; '
                    f'color:#CCFF00; margin-top:-0.5rem;">✎ {draft_count} resultado(s) '
                    f'pendiente(s) por guardar</p>',
                    unsafe_allow_html=True,
                )
            st.progress(completed / len(matches) if matches else 0)

            # ── Track which drafts are being edited via session state ─
            if "editing_drafts" not in st.session_state:
                st.session_state.editing_drafts = set()

            # ── Group matches by day ──────────────────────────
            _DIAS_ES = ['Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo']
            _MESES_ES = ['','Enero','Febrero','Marzo','Abril','Mayo','Junio',
                         'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre']

            def _fmt_date_es(d):
                """Format date as 'Martes 5 de Mayo del 2026'."""
                if isinstance(d, str):
                    parts = d.split('-')
                    from datetime import date as _d
                    d = _d(int(parts[0]), int(parts[1]), int(parts[2]))
                dia_nombre = _DIAS_ES[d.weekday()]
                mes_nombre = _MESES_ES[d.month]
                return f"{dia_nombre} {d.day} de {mes_nombre} del {d.year}"

            def _match_date_key(m):
                return m.get('scheduled_date') or '9999-99-99'

            sorted_matches = sorted(matches, key=_match_date_key)

            for day_key, day_matches_iter in groupby(sorted_matches, key=_match_date_key):
                day_matches = list(day_matches_iter)

                # Day header
                if day_key != '9999-99-99':
                    day_label = _fmt_date_es(day_key)
                else:
                    day_label = "Sin fecha asignada"

                st.markdown(
                    f'<p style="font-family:\'Montserrat\',sans-serif; font-weight:800; '
                    f'font-size:0.85rem; letter-spacing:2px; color:rgba(255,255,255,0.55); '
                    f'margin-top:1.5rem; margin-bottom:0.5rem; text-transform:uppercase;">'
                    f'{day_label}</p>',
                    unsafe_allow_html=True,
                )

                for m in day_matches:
                    match_id = m["id"]
                    defender = m.get("defender", {}) or {}
                    challenger = m.get("challenger", {}) or {}
                    d_first = defender.get('first_name', '')
                    d_last = (defender.get('last_name', '') or '').split()[0] if defender.get('last_name') else ''
                    c_first = challenger.get('first_name', '')
                    c_last = (challenger.get('last_name', '') or '').split()[0] if challenger.get('last_name') else ''
                    d_name = f"{d_first} {d_last}".strip()
                    c_name = f"{c_first} {c_last}".strip()
                    d_pos = m["defender_position"]
                    c_pos = m["challenger_position"]

                    # Time + Court line
                    time_court = ""
                    if m.get("scheduled_time"):
                        t_val = m["scheduled_time"]
                        if isinstance(t_val, str):
                            t_val = t_val[:5]
                        court = f"Cancha {m.get('court_number', '?')}"
                        time_court = f"{t_val} — {court}"

                    # Determine match state
                    is_completed = m["is_completed"]
                    draft = drafts_map.get(match_id)
                    has_draft = draft is not None
                    is_editing = match_id in st.session_state.editing_drafts

                    # Status icon
                    if is_completed:
                        status_icon = "●"
                    elif has_draft:
                        status_icon = "✓"
                    else:
                        status_icon = "○"

                    # Draft badge styling
                    card_border_top = "#450084"
                    if has_draft and not is_completed:
                        card_border_top = "#CCFF00"

                    # ── Frosted glass match card ──────────────
                    draft_badge = '  <span style="color:#CCFF00; font-weight:600;">BORRADOR</span>' if has_draft and not is_completed else ""
                    st.markdown(
                        f'<div class="ranking-card" style="border-top-color:{card_border_top};">'
                        f'<div style="font-size:0.7rem; color:rgba(255,255,255,0.4); margin-bottom:0.4rem;">'
                        f'{status_icon} {time_court}{draft_badge}'
                        f'</div>'
                        f'<div style="display:flex; justify-content:center; align-items:center; gap:0.8rem;">'
                        f"<span style=\"font-family:'Montserrat',sans-serif; font-weight:700; font-size:0.95rem;\">"
                        f'#{d_pos} {d_name}</span>'
                        f'<span style="color:#CCFF00; font-weight:900; font-size:0.75rem; letter-spacing:2px;">VS</span>'
                        f"<span style=\"font-family:'Montserrat',sans-serif; font-weight:700; font-size:0.95rem;\">"
                        f'#{c_pos} {c_name}</span>'
                        f'</div></div>',
                        unsafe_allow_html=True,
                    )

                    if is_completed:
                        # ── COMMITTED: read-only scorebug ─────────
                        winner_id = m.get("winner_id")
                        d_won = winner_id == m["defender_id"]
                        c_won = winner_id == m["challenger_id"]
                        d_row_cls = "sb-winner" if d_won else "sb-loser"
                        c_row_cls = "sb-winner" if c_won else "sb-loser"

                        sets = [
                            (m.get('set1_defender'), m.get('set1_challenger')),
                            (m.get('set2_defender'), m.get('set2_challenger')),
                        ]
                        if m.get('set3_defender') is not None:
                            sets.append((m.get('set3_defender'), m.get('set3_challenger')))

                        d_sets_html = ""
                        c_sets_html = ""
                        for ds, cs in sets:
                            dw = "set-won" if ds is not None and cs is not None and ds > cs else ""
                            cw = "set-won" if ds is not None and cs is not None and cs > ds else ""
                            d_sets_html += f'<td class="sb-set {dw}">{ds}</td>'
                            c_sets_html += f'<td class="sb-set {cw}">{cs}</td>'
                        for _ in range(3 - len(sets)):
                            d_sets_html += '<td class="sb-set"></td>'
                            c_sets_html += '<td class="sb-set"></td>'

                        scorebug_html = (
                            f'<table class="admin-scorebug">'
                            f'<thead><tr><th></th><th>S1</th><th>S2</th><th>S3</th></tr></thead>'
                            f'<tr class="{d_row_cls}"><td class="sb-name">{d_name} <span class="sb-pos">{d_pos}</span></td>{d_sets_html}</tr>'
                            f'<tr class="{c_row_cls}"><td class="sb-name">{c_name} <span class="sb-pos">{c_pos}</span></td>{c_sets_html}</tr>'
                            f'</table>'
                        )
                        st.markdown(scorebug_html, unsafe_allow_html=True)

                    elif has_draft and not is_editing:
                        # ── DRAFTED: show draft scorebug + edit button ─
                        draft_winner_id = draft.get("winner_id")
                        d_won = draft_winner_id == m["defender_id"]
                        c_won = draft_winner_id == m["challenger_id"]
                        d_row_cls = "sb-winner" if d_won else "sb-loser"
                        c_row_cls = "sb-winner" if c_won else "sb-loser"

                        sets = [
                            (draft.get('set1_defender'), draft.get('set1_challenger')),
                            (draft.get('set2_defender'), draft.get('set2_challenger')),
                        ]
                        if draft.get('set3_defender') is not None:
                            sets.append((draft.get('set3_defender'), draft.get('set3_challenger')))

                        d_sets_html = ""
                        c_sets_html = ""
                        for ds, cs in sets:
                            dw = "set-won" if ds is not None and cs is not None and ds > cs else ""
                            cw = "set-won" if ds is not None and cs is not None and cs > ds else ""
                            d_sets_html += f'<td class="sb-set {dw}">{ds}</td>'
                            c_sets_html += f'<td class="sb-set {cw}">{cs}</td>'
                        for _ in range(3 - len(sets)):
                            d_sets_html += '<td class="sb-set"></td>'
                            c_sets_html += '<td class="sb-set"></td>'

                        forfeit_tag = ""
                        if draft.get("is_forfeit"):
                            forfeit_tag = ' <span style="color:#ef4444; font-size:0.65rem; font-weight:700;">WALKOVER</span>'

                        scorebug_html = (
                            f'<table class="admin-scorebug">'
                            f'<thead><tr><th>{forfeit_tag}</th><th>S1</th><th>S2</th><th>S3</th></tr></thead>'
                            f'<tr class="{d_row_cls}"><td class="sb-name">{d_name} <span class="sb-pos">{d_pos}</span></td>{d_sets_html}</tr>'
                            f'<tr class="{c_row_cls}"><td class="sb-name">{c_name} <span class="sb-pos">{c_pos}</span></td>{c_sets_html}</tr>'
                            f'</table>'
                        )
                        st.markdown(scorebug_html, unsafe_allow_html=True)

                        # Edit / Remove draft buttons
                        edit_cols = st.columns([1, 1])
                        with edit_cols[0]:
                            if st.button("✏️ Editar", key=f"edit_draft_{match_id}", use_container_width=True):
                                st.session_state.editing_drafts.add(match_id)
                                st.rerun()
                        with edit_cols[1]:
                            if st.button("🗑️ Quitar", key=f"del_draft_{match_id}", use_container_width=True):
                                RankingService.delete_draft(match_id)
                                st.session_state.editing_drafts.discard(match_id)
                                st.toast("Borrador eliminado")
                                st.rerun()

                    else:
                        # ── PENDING / EDITING: score input expander ────
                        expander_label = (
                            f"Editar borrador — #{d_pos} vs #{c_pos}"
                            if has_draft
                            else f"Capturar resultado — #{d_pos} vs #{c_pos}"
                        )

                        # Pre-populate from draft if editing
                        default_s1d = (draft.get("set1_defender") or 0) if draft else 0
                        default_s2d = (draft.get("set2_defender") or 0) if draft else 0
                        default_s3d = (draft.get("set3_defender") or 0) if draft else 0
                        default_s1c = (draft.get("set1_challenger") or 0) if draft else 0
                        default_s2c = (draft.get("set2_challenger") or 0) if draft else 0
                        default_s3c = (draft.get("set3_challenger") or 0) if draft else 0
                        default_forfeit = draft.get("is_forfeit", False) if draft else False

                        with st.expander(expander_label, expanded=is_editing):
                            # Scorebug row: Name | S1 | S2 | S3
                            header_cols = st.columns([3, 1, 1, 1])
                            with header_cols[0]:
                                st.markdown(f"**{d_name}** `#{d_pos}`")
                            with header_cols[1]:
                                s1d = st.number_input("S1", min_value=0, max_value=7, value=default_s1d, key=f"s1d_{match_id}", label_visibility="collapsed")
                            with header_cols[2]:
                                s2d = st.number_input("S2", min_value=0, max_value=7, value=default_s2d, key=f"s2d_{match_id}", label_visibility="collapsed")
                            with header_cols[3]:
                                s3d = st.number_input("S3", min_value=0, max_value=10, value=default_s3d, key=f"s3d_{match_id}", label_visibility="collapsed")

                            row2_cols = st.columns([3, 1, 1, 1])
                            with row2_cols[0]:
                                st.markdown(f"**{c_name}** `#{c_pos}`")
                            with row2_cols[1]:
                                s1c = st.number_input("S1", min_value=0, max_value=7, value=default_s1c, key=f"s1c_{match_id}", label_visibility="collapsed")
                            with row2_cols[2]:
                                s2c = st.number_input("S2", min_value=0, max_value=7, value=default_s2c, key=f"s2c_{match_id}", label_visibility="collapsed")
                            with row2_cols[3]:
                                s3c = st.number_input("S3", min_value=0, max_value=10, value=default_s3c, key=f"s3c_{match_id}", label_visibility="collapsed")

                            # Auto-detect winner
                            sets_d = (1 if s1d > s1c else 0) + (1 if s2d > s2c else 0) + (1 if s3d > s3c else 0)
                            sets_c = (1 if s1c > s1d else 0) + (1 if s2c > s2d else 0) + (1 if s3c > s3d else 0)

                            is_forfeit = st.checkbox("Walkover / Forfeit", value=default_forfeit, key=f"forfeit_{match_id}")

                            winner_id = m["defender_id"] if sets_d >= sets_c else m["challenger_id"]

                            btn_cols = st.columns([1, 1] if is_editing else [1])
                            with btn_cols[0]:
                                save_label = "✓ ACTUALIZAR BORRADOR" if has_draft else "✓ GUARDAR BORRADOR"
                                if st.button(save_label, key=f"save_draft_{match_id}", use_container_width=True):
                                    scores = {
                                        "set1_defender": s1d, "set1_challenger": s1c,
                                        "set2_defender": s2d, "set2_challenger": s2c,
                                        "set3_defender": s3d if s3d > 0 or s3c > 0 else None,
                                        "set3_challenger": s3c if s3d > 0 or s3c > 0 else None,
                                    }
                                    result = RankingService.save_draft_result(
                                        match_id, winner_id, scores, is_forfeit,
                                        entered_by=user.get("id")
                                    )
                                    if result:
                                        st.session_state.editing_drafts.discard(match_id)
                                        st.toast(f"✓ Borrador guardado — #{d_pos} vs #{c_pos}")
                                        st.rerun()
                                    else:
                                        st.error("Error al guardar el borrador.")

                            if is_editing and len(btn_cols) > 1:
                                with btn_cols[1]:
                                    if st.button("CANCELAR", key=f"cancel_edit_{match_id}", use_container_width=True):
                                        st.session_state.editing_drafts.discard(match_id)
                                        st.rerun()

            # ── Bulk commit button ────────────────────────────
            if not selected_week.get("is_completed"):
                st.divider()

                if draft_count > 0:
                    st.markdown(
                        f'<div style="background:rgba(204,255,0,0.08); border:1px solid rgba(204,255,0,0.3); '
                        f'border-radius:10px; padding:1rem; margin-bottom:1rem; text-align:center;">'
                        f'<p style="font-family:\'Montserrat\',sans-serif; font-weight:700; '
                        f'color:#CCFF00; margin:0; font-size:0.9rem;">'
                        f'✎ {draft_count} resultado(s) listos para guardar</p>'
                        f'<p style="color:rgba(255,255,255,0.5); font-size:0.75rem; margin:0.3rem 0 0 0;">'
                        f'Al guardar, se aplicarán los cambios de posición en la escalera.</p>'
                        f'</div>',
                        unsafe_allow_html=True,
                    )

                    if st.button(
                        f"💾 GUARDAR {draft_count} RESULTADO{'S' if draft_count > 1 else ''}",
                        key="commit_drafts_btn",
                        type="primary",
                        use_container_width=True,
                    ):
                        with st.spinner("Guardando resultados y actualizando escalera..."):
                            commit_result = RankingService.commit_week_drafts(
                                selected_week_id, entered_by=user.get("id")
                            )
                        if commit_result["errors"]:
                            for err in commit_result["errors"]:
                                st.error(err)
                        if commit_result["committed"] > 0:
                            st.toast(f"✓ {commit_result['committed']} resultado(s) guardados")
                            st.rerun()

                # ── Close week button ─────────────────────────
                st.divider()
                st.warning("Al cerrar la semana, los partidos sin resultado se marcarán como forfeit (6-0 6-0) a favor del defensor.")
                if st.button("CERRAR SEMANA", key="close_week_btn", use_container_width=True):
                    # Commit any remaining drafts first
                    if draft_count > 0:
                        with st.spinner("Guardando borradores pendientes..."):
                            RankingService.commit_week_drafts(
                                selected_week_id, entered_by=user.get("id")
                            )
                    RankingService.complete_week(selected_week_id)
                    st.toast("Semana cerrada exitosamente")
                    st.rerun()


# ═══════════════════════════════════════════════════════════════
# TAB 5: MODIFICAR RESULTADOS (Active & Past Weeks)
# ═══════════════════════════════════════════════════════════════
with tab_modify_results:
    st.markdown("""
    <div style="background: rgba(255, 255, 255, 0.06); border: 1px solid rgba(255, 255, 255, 0.12);
                border-left: 4px solid #CCFF00; border-radius: 8px; padding: 1rem 1.2rem; margin-bottom: 1.5rem;">
        <h3 style="font-family: 'Montserrat', sans-serif; font-weight: 800; color: #fff; margin: 0; font-size: 1.2rem; letter-spacing: 1px;">
            ✏️ MODIFICAR RESULTADOS GUARDADOS
        </h3>
        <p style="color: rgba(255, 255, 255, 0.7); font-family: 'Inter', sans-serif; font-size: 0.85rem; margin: 0.4rem 0 0 0;">
            Busca un jugador para ver y corregir marcadores de partidos guardados en semanas activas o pasadas.
            Al guardar la corrección, el récord histórico de victorias/derrotas se actualizará automáticamente.
        </p>
    </div>
    """, unsafe_allow_html=True)

    # ── Search Input ──────────────────────────────────────────
    search_col1, search_col2 = st.columns([3, 1])
    with search_col1:
        search_query = st.text_input(
            "Buscar jugador",
            placeholder="Escribe el nombre o apellido del jugador...",
            key="mod_results_search_input",
            help="Filtra por nombre o apellido para encontrar a cualquier jugador de la categoría."
        )
    with search_col2:
        st.markdown("<br>", unsafe_allow_html=True)
        if st.button("Limpiar Búsqueda", key="mod_clear_search_btn", use_container_width=True):
            st.session_state.mod_results_search_input = ""
            st.rerun()

    candidates = RankingService.get_players_with_history(cat_id, search_query=search_query)

    if not candidates:
        st.info("No se encontraron jugadores que coincidan con la búsqueda en esta categoría.")
    else:
        # Build selectbox options
        player_options = {}
        for p in candidates:
            pos_label = f" (#{p['position']})" if p['position'] is not None else ""
            matches_label = f"{p['completed_matches_count']} partido(s) guardado(s)"
            label = f"{p['full_name']}{pos_label} — {matches_label}"
            player_options[label] = p["id"]

        selected_label = st.selectbox(
            "Selecciona un jugador para ver su historial de partidos:",
            list(player_options.keys()),
            key="mod_player_select",
        )
        selected_player_id = player_options[selected_label]
        selected_player = next(p for p in candidates if p["id"] == selected_player_id)

        # ── Fetch Historical Completed Matches ────────────────
        player_matches = RankingService.get_completed_matches_by_player(selected_player_id, category_id=cat_id)

        # ── Player Historical Stats Summary Card ──────────────
        wins = sum(1 for m in player_matches if m["won"])
        losses = len(player_matches) - wins
        win_rate = int((wins / len(player_matches)) * 100) if player_matches else 0
        current_pos_display = f"#{selected_player['position']}" if selected_player['position'] is not None else "—"

        st.markdown(f"""
        <div style="display: flex; justify-content: space-around; align-items: center;
                    background: rgba(255, 255, 255, 0.08); backdrop-filter: blur(15px);
                    border: 1px solid rgba(255, 255, 255, 0.15); border-radius: 10px;
                    padding: 0.9rem 0.6rem; margin-top: 1rem; margin-bottom: 1.5rem;
                    box-shadow: 0 4px 12px rgba(0,0,0,0.2);">
            <div style="text-align: center;">
                <div style="font-family: 'Montserrat', sans-serif; font-size: 0.62rem; color: rgba(255,255,255,0.5); text-transform: uppercase; letter-spacing: 1px;">Posición Escalera</div>
                <div style="font-family: 'Montserrat', sans-serif; font-weight: 800; font-size: 1.15rem; color: #fff; margin-top: 0.2rem;">{current_pos_display}</div>
            </div>
            <div style="height: 28px; width: 1px; background: rgba(255, 255, 255, 0.12);"></div>
            <div style="text-align: center;">
                <div style="font-family: 'Montserrat', sans-serif; font-size: 0.62rem; color: rgba(255,255,255,0.5); text-transform: uppercase; letter-spacing: 1px;">Récord Histórico</div>
                <div style="font-family: 'Montserrat', sans-serif; font-weight: 800; font-size: 1.15rem; margin-top: 0.2rem;">
                    <span style="color: #CCFF00;">{wins}V</span> - <span style="color: #ef4444;">{losses}D</span>
                </div>
            </div>
            <div style="height: 28px; width: 1px; background: rgba(255, 255, 255, 0.12);"></div>
            <div style="text-align: center;">
                <div style="font-family: 'Montserrat', sans-serif; font-size: 0.62rem; color: rgba(255,255,255,0.5); text-transform: uppercase; letter-spacing: 1px;">Efectividad</div>
                <div style="font-family: 'Montserrat', sans-serif; font-weight: 800; font-size: 1.15rem; color: #CCFF00; margin-top: 0.2rem;">{win_rate}%</div>
            </div>
            <div style="height: 28px; width: 1px; background: rgba(255, 255, 255, 0.12);"></div>
            <div style="text-align: center;">
                <div style="font-family: 'Montserrat', sans-serif; font-size: 0.62rem; color: rgba(255,255,255,0.5); text-transform: uppercase; letter-spacing: 1px;">Partidos Guardados</div>
                <div style="font-family: 'Montserrat', sans-serif; font-weight: 800; font-size: 1.15rem; color: #fff; margin-top: 0.2rem;">{len(player_matches)}</div>
            </div>
        </div>
        """, unsafe_allow_html=True)

        if not player_matches:
            st.info(f"{selected_player['full_name']} no tiene partidos completados guardados en la categoría {selected_cat_name}.")
        else:
            st.markdown(f"#### Partidos Guardados ({len(player_matches)})")
            st.caption("Selecciona 'Editar Marcador' en cualquiera de los partidos para corregir resultados pasados o activos.")

            for m in player_matches:
                match_id = m["id"]
                week_num = m["week_number"]
                phase_label = "Fase Desafío" if m["phase"] == "challenge" else "Fase Defensa"
                is_active_week = not m["week_is_completed"]

                week_badge_color = "#CCFF00" if is_active_week else "rgba(255,255,255,0.4)"
                week_badge_text = "SEMANA ACTIVA" if is_active_week else "SEMANA PASADA"

                outcome_color = "#CCFF00" if m["won"] else "#ef4444"
                outcome_text = "VICTORIA" if m["won"] else "DERROTA"
                if m["is_forfeit"]:
                    outcome_text += " (W.O.)"

                # Format current set scores
                sets_str = ", ".join([f"{sp}-{so}" for sp, so in m["sets_player_view"]]) if m["sets_player_view"] else "Sin marcador detallado"

                # Time and court
                time_court = ""
                if m.get("scheduled_date"):
                    time_court += f"📅 {m['scheduled_date']} "
                if m.get("scheduled_time"):
                    t_val = str(m["scheduled_time"])[:5]
                    time_court += f"| ⏰ {t_val} "
                if m.get("court_number"):
                    time_court += f"| 🎾 Cancha {m['court_number']}"

                # Match card header
                st.markdown(f"""
                <div class="ranking-card" style="border-top-color: {outcome_color}; margin-top: 0.8rem; margin-bottom: 0.3rem;">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.4rem;">
                        <span style="font-family: 'Montserrat', sans-serif; font-weight: 700; font-size: 0.75rem; color: {week_badge_color}; letter-spacing: 1px;">
                            SEMANA {week_num} — {phase_label.upper()} ({week_badge_text})
                        </span>
                        <span style="font-family: 'Montserrat', sans-serif; font-weight: 800; font-size: 0.75rem; color: {outcome_color}; letter-spacing: 1px;">
                            {outcome_text}
                        </span>
                    </div>
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <div>
                            <span style="font-family: 'Montserrat', sans-serif; font-weight: 700; font-size: 0.95rem; color: #fff;">
                                #{m['player_pos']} {selected_player['full_name']}
                            </span>
                            <span style="color: #CCFF00; font-weight: 900; font-size: 0.75rem; margin: 0 0.5rem;">VS</span>
                            <span style="font-family: 'Montserrat', sans-serif; font-weight: 700; font-size: 0.95rem; color: rgba(255,255,255,0.85);">
                                #{m['opponent_pos']} {m['opponent_name']}
                            </span>
                        </div>
                        <div style="font-family: 'Montserrat', sans-serif; font-weight: 700; font-size: 0.9rem; color: #CCFF00;">
                            {sets_str}
                        </div>
                    </div>
                    <div style="font-size: 0.7rem; color: rgba(255,255,255,0.4); margin-top: 0.4rem;">
                        {time_court}
                    </div>
                </div>
                """, unsafe_allow_html=True)

                # Edit Expander
                with st.expander(f"✏️ Editar Marcador — Semana {week_num} vs {m['opponent_name']}", expanded=False):
                    d_name = m["defender_name"]
                    c_name = m["challenger_name"]
                    d_pos = m["defender_position"]
                    c_pos = m["challenger_position"]

                    # Prepopulate scores
                    cur_s1d = m["set1_defender"] if m["set1_defender"] is not None else 0
                    cur_s2d = m["set2_defender"] if m["set2_defender"] is not None else 0
                    cur_s3d = m["set3_defender"] if m["set3_defender"] is not None else 0
                    cur_s1c = m["set1_challenger"] if m["set1_challenger"] is not None else 0
                    cur_s2c = m["set2_challenger"] if m["set2_challenger"] is not None else 0
                    cur_s3c = m["set3_challenger"] if m["set3_challenger"] is not None else 0

                    st.markdown("""
                    <div style="font-family: 'Montserrat', sans-serif; font-size: 0.72rem; color: rgba(255,255,255,0.5);
                                text-transform: uppercase; letter-spacing: 1px; margin-bottom: 0.4rem;">
                        Marcador por Sets (Defensor vs Retador)
                    </div>
                    """, unsafe_allow_html=True)

                    # Score matrix
                    # Row 1: Defender
                    cols_d = st.columns([3, 1, 1, 1])
                    with cols_d[0]:
                        st.markdown(f"**{d_name}** `#{d_pos}` *(Defensor)*")
                    with cols_d[1]:
                        s1d = st.number_input("S1 Def", min_value=0, max_value=7, value=int(cur_s1d), key=f"mod_s1d_{match_id}", label_visibility="collapsed")
                    with cols_d[2]:
                        s2d = st.number_input("S2 Def", min_value=0, max_value=7, value=int(cur_s2d), key=f"mod_s2d_{match_id}", label_visibility="collapsed")
                    with cols_d[3]:
                        s3d = st.number_input("S3 Def", min_value=0, max_value=30, value=int(cur_s3d), key=f"mod_s3d_{match_id}", label_visibility="collapsed")

                    # Row 2: Challenger
                    cols_c = st.columns([3, 1, 1, 1])
                    with cols_c[0]:
                        st.markdown(f"**{c_name}** `#{c_pos}` *(Retador)*")
                    with cols_c[1]:
                        s1c = st.number_input("S1 Chal", min_value=0, max_value=7, value=int(cur_s1c), key=f"mod_s1c_{match_id}", label_visibility="collapsed")
                    with cols_c[2]:
                        s2c = st.number_input("S2 Chal", min_value=0, max_value=7, value=int(cur_s2c), key=f"mod_s2c_{match_id}", label_visibility="collapsed")
                    with cols_c[3]:
                        s3c = st.number_input("S3 Chal", min_value=0, max_value=30, value=int(cur_s3c), key=f"mod_s3c_{match_id}", label_visibility="collapsed")

                    st.caption("S1 y S2: Sets normales (0-7). S3: Super Tiebreak (0-30). Si no hubo tercer set, déjalo en 0.")

                    # Auto winner calculation
                    sets_d = (1 if s1d > s1c else 0) + (1 if s2d > s2c else 0) + (1 if s3d > s3c else 0)
                    sets_c = (1 if s1c > s1d else 0) + (1 if s2c > s2d else 0) + (1 if s3c > s3d else 0)

                    auto_winner_id = m["defender_id"] if sets_d >= sets_c else m["challenger_id"]

                    # Options for official winner
                    winner_choices = [m["defender_id"], m["challenger_id"]]
                    winner_names = {
                        m["defender_id"]: f"{d_name} (#{d_pos} - Defensor)",
                        m["challenger_id"]: f"{c_name} (#{c_pos} - Retador)",
                    }
                    default_winner_idx = 0 if auto_winner_id == m["defender_id"] else 1

                    opt_cols = st.columns([2, 1])
                    with opt_cols[0]:
                        chosen_winner_id = st.radio(
                            "Ganador oficial:",
                            winner_choices,
                            index=default_winner_idx,
                            format_func=lambda x: winner_names[x],
                            key=f"mod_win_radio_{match_id}",
                            horizontal=True,
                        )
                    with opt_cols[1]:
                        is_forfeit_val = st.checkbox(
                            "Walkover / Forfeit",
                            value=m["is_forfeit"],
                            key=f"mod_forfeit_{match_id}",
                            help="Marca si el partido terminó por default, retiro o no-show.",
                        )

                    # Info callout about ladder position swap rule
                    if is_active_week:
                        st.info("⚡ **Semana activa:** Si el ganador cambia, se actualizarán e intercambiarán las posiciones correspondientes en la escalera actual.")
                    else:
                        st.caption("ℹ️ **Semana pasada:** La actualización corregirá el marcador y el récord histórico de victorias/derrotas de ambos jugadores sin alterar las posiciones de la escalera.")

                    # Save button
                    if st.button("💾 GUARDAR CORRECCIÓN", type="primary", key=f"mod_save_btn_{match_id}", use_container_width=True):
                        corrected_scores = {
                            "set1_defender": s1d,
                            "set1_challenger": s1c,
                            "set2_defender": s2d,
                            "set2_challenger": s2c,
                            "set3_defender": s3d if (s3d > 0 or s3c > 0) else None,
                            "set3_challenger": s3c if (s3d > 0 or s3c > 0) else None,
                        }

                        with st.spinner("Guardando corrección y actualizando récord histórico..."):
                            res = RankingService.update_saved_match_result(
                                match_id=match_id,
                                winner_id=chosen_winner_id,
                                scores=corrected_scores,
                                is_forfeit=is_forfeit_val,
                                entered_by=user.get("id"),
                            )

                        if res.get("success"):
                            st.toast(f"✓ Resultado corregido — Semana {week_num}")
                            if res.get("swapped") and res.get("swap_msg"):
                                st.toast(f"✓ {res['swap_msg']}")
                            st.rerun()
                        else:
                            st.error(res.get("error", "Error desconocido al actualizar."))

