"""
Admin Ranking Page — Coach panel for managing the ladder ranking system.
4 tabs: Escalera, Subcategorías, Programar Semana, Resultados.
"""
import streamlit as st
from datetime import date, time, timedelta
from utils.auth import get_current_user
from utils.supabase_client import get_supabase_client
from services.ranking_service import RankingService

# ── Auth Guard ────────────────────────────────────────────────
user = get_current_user()
if not user:
    st.error("🔒 Acceso denegado. Inicia sesión para continuar.")
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
tab_ladder, tab_subcat, tab_schedule, tab_results = st.tabs([
    "🪜 ESCALERA", "🏷️ SUBCATEGORÍAS", "📅 PROGRAMAR SEMANA", "🏆 RESULTADOS"
])


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
                if st.button("🗑️", key=f"rm_{entry['player_id']}", help="Eliminar"):
                    RankingService.remove_player_from_ladder(cat_id, entry["player_id"])
                    st.rerun()

    # ── Add Player Section ────────────────────────────────────
    st.divider()
    st.markdown("#### ➕ Agregar Jugador a la Escalera")

    existing_ids = RankingService.get_ladder_player_ids(cat_id)
    supabase = get_supabase_client()
    all_players_resp = supabase.table("players").select("id, first_name, last_name").order("first_name").execute()
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
            if st.button("✅ AGREGAR", key="add_player_btn", use_container_width=True):
                RankingService.add_player_to_ladder(cat_id, player_options[selected_player_name], insert_pos)
                st.toast(f"✅ {selected_player_name} agregado en posición #{insert_pos}")
                st.rerun()
    else:
        st.caption("Todos los jugadores ya están en la escalera.")


# ═══════════════════════════════════════════════════════════════
# TAB 2: SUBCATEGORÍAS (Boundary Configuration)
# ═══════════════════════════════════════════════════════════════
with tab_subcat:
    st.markdown("#### 🏷️ Rangos de Subcategoría")
    st.caption("Define qué posiciones pertenecen a cada subcategoría.")

    subcategories = _fetch_subcategories()
    current_ranges = RankingService.get_subcategory_ranges(cat_id)
    range_map = {r.get("subcategory_id"): r for r in current_ranges}

    # Filter to relevant subcats (skip kids categories for ranking)
    ranking_subcats = [s for s in subcategories if s["name"] not in ("Mini-Tenis", "8-10 años")]

    with st.form("subcat_ranges_form"):
        new_ranges = []
        for sc in ranking_subcats:
            existing = range_map.get(sc["id"], {})
            cols = st.columns([2, 1, 1])
            with cols[0]:
                pill_class = _subcat_css_class(sc["name"])
                st.markdown(
                    f'<span class="subcat-pill {pill_class}" style="font-size:0.85rem; padding:4px 14px;">'
                    f'{sc["name"]}</span>',
                    unsafe_allow_html=True,
                )
            with cols[1]:
                ps = st.number_input(
                    f"Desde", min_value=0, value=existing.get("position_start", 0),
                    key=f"sc_start_{sc['id']}"
                )
            with cols[2]:
                pe = st.number_input(
                    f"Hasta", min_value=0, value=existing.get("position_end", 0),
                    key=f"sc_end_{sc['id']}"
                )
            if ps > 0 and pe > 0:
                new_ranges.append({
                    "subcategory_id": sc["id"],
                    "position_start": ps,
                    "position_end": pe,
                })

        if st.form_submit_button("💾 GUARDAR RANGOS", use_container_width=True):
            RankingService.save_subcategory_ranges(cat_id, new_ranges)
            st.toast("✅ Rangos de subcategoría actualizados")
            st.rerun()


# ═══════════════════════════════════════════════════════════════
# TAB 3: PROGRAMAR SEMANA (Weekly Scheduling)
# ═══════════════════════════════════════════════════════════════
with tab_schedule:
    next_week_num, next_phase = RankingService.determine_next_phase(cat_id)

    phase_label = "⚔️ CHALLENGE — ¡Hora de Subir!" if next_phase == "challenge" else "🛡️ DEFEND — Defiende tu Corona"
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

    # Date range: next available Tuesday → Sunday
    today = date.today()
    days_until_tuesday = (1 - today.weekday()) % 7
    if days_until_tuesday == 0 and today.weekday() != 1:
        days_until_tuesday = 7
    next_tuesday = today + timedelta(days=days_until_tuesday)
    next_sunday = next_tuesday + timedelta(days=5)

    with st.form("schedule_week_form"):
        st.markdown("##### ⚙️ Configuración del Horario")
        d_cols = st.columns(2)
        with d_cols[0]:
            start_date = st.date_input("Fecha inicio (Martes)", value=next_tuesday, key="sched_start")
        with d_cols[1]:
            end_date = st.date_input("Fecha fin (Domingo)", value=next_sunday, key="sched_end")

        st.markdown("**Horarios entre semana** (Martes–Viernes)")
        wd_cols = st.columns(2)
        with wd_cols[0]:
            wd_first = st.time_input("Primer juego", value=time(18, 0), key="wd_first")
        with wd_cols[1]:
            wd_last = st.time_input("Último juego", value=time(19, 30), key="wd_last")

        st.markdown("**Horarios fin de semana** (Sábado–Domingo)")
        we_cols = st.columns(2)
        with we_cols[0]:
            we_first = st.time_input("Primer juego", value=time(10, 0), key="we_first")
        with we_cols[1]:
            we_last = st.time_input("Último juego", value=time(19, 0), key="we_last")

        num_courts = st.number_input("Canchas disponibles", min_value=1, max_value=12, value=6, key="sched_courts")

        submitted = st.form_submit_button("🚀 GENERAR HORARIO", use_container_width=True)

    if submitted:
        ladder = RankingService.get_current_ladder(cat_id)
        if len(ladder) < 2:
            st.error("Se necesitan al menos 2 jugadores en la escalera.")
        else:
            pairings, resting = RankingService.generate_pairings(ladder, next_phase)

            config = {
                "weekday_first_game": wd_first.strftime("%H:%M"),
                "weekday_last_game": wd_last.strftime("%H:%M"),
                "weekend_first_game": we_first.strftime("%H:%M"),
                "weekend_last_game": we_last.strftime("%H:%M"),
                "num_courts": num_courts,
                "week_start_date": start_date,
                "week_end_date": end_date,
            }

            week = RankingService.create_week(cat_id, next_week_num, next_phase, config)
            if week:
                count = RankingService.schedule_ranking_week(week["id"], pairings, week)
                st.success(f"✅ Semana {next_week_num} creada — {count} partidos programados")

                # Show resting players
                if resting:
                    resting_names = []
                    for entry in ladder:
                        if entry["player_id"] in resting:
                            resting_names.append(f"{entry['first_name']} {entry['last_name']}")
                    st.info(f"😴 Descansan esta semana: {', '.join(resting_names)}")

                st.rerun()
            else:
                st.error("Error al crear la semana.")

    # ── Show existing weeks ───────────────────────────────────
    st.divider()
    st.markdown("##### 📋 Semanas Anteriores")
    weeks = RankingService.get_weeks(cat_id, limit=5)
    if weeks:
        for w in weeks:
            phase_icon = "⚔️" if w["phase"] == "challenge" else "🛡️"
            status = "✅ Completada" if w["is_completed"] else "🔄 En curso"
            st.markdown(
                f"**{phase_icon} Semana {w['week_number']}** — "
                f"{w['week_start_date']} → {w['week_end_date']} — {status}"
            )
    else:
        st.caption("No hay semanas registradas.")


# ═══════════════════════════════════════════════════════════════
# TAB 4: RESULTADOS (Match Results Entry)
# ═══════════════════════════════════════════════════════════════
with tab_results:
    weeks = RankingService.get_weeks(cat_id, limit=10)
    if not weeks:
        st.info("No hay semanas programadas. Crea una en la pestaña 'Programar Semana'.")
    else:
        week_options = {
            f"Semana {w['week_number']} ({'⚔️' if w['phase']=='challenge' else '🛡️'} "
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
            completed = sum(1 for m in matches if m["is_completed"])
            st.markdown(f"**{completed}/{len(matches)}** partidos completados")
            st.progress(completed / len(matches) if matches else 0)

            for m in matches:
                defender = m.get("defender", {}) or {}
                challenger = m.get("challenger", {}) or {}
                d_name = f"{defender.get('first_name','')} {defender.get('last_name','')}"
                c_name = f"{challenger.get('first_name','')} {challenger.get('last_name','')}"
                d_pos = m["defender_position"]
                c_pos = m["challenger_position"]

                status_icon = "✅" if m["is_completed"] else "⏳"
                sched = ""
                if m.get("scheduled_date") and m.get("scheduled_time"):
                    sched = f" · {m['scheduled_date']} {m['scheduled_time']} · Cancha {m.get('court_number','?')}"

                st.markdown(f"""
                <div class="ranking-card">
                    <span style="font-size:0.75rem; color:rgba(255,255,255,0.4);">{status_icon}{sched}</span>
                    <div style="display:flex; justify-content:center; align-items:center; gap:1rem; margin-top:0.5rem;">
                        <span style="font-family:'Montserrat',sans-serif; font-weight:700;">
                            #{d_pos} {d_name}
                        </span>
                        <span style="color:#CCFF00; font-weight:900; font-size:1.2rem;">VS</span>
                        <span style="font-family:'Montserrat',sans-serif; font-weight:700;">
                            #{c_pos} {c_name}
                        </span>
                    </div>
                </div>
                """, unsafe_allow_html=True)

                if not m["is_completed"]:
                    with st.expander(f"📝 Capturar resultado — #{d_pos} vs #{c_pos}"):
                        s_cols = st.columns(6)
                        with s_cols[0]:
                            s1d = st.number_input("S1 Def", min_value=0, max_value=7, value=0, key=f"s1d_{m['id']}")
                        with s_cols[1]:
                            s1c = st.number_input("S1 Ret", min_value=0, max_value=7, value=0, key=f"s1c_{m['id']}")
                        with s_cols[2]:
                            s2d = st.number_input("S2 Def", min_value=0, max_value=7, value=0, key=f"s2d_{m['id']}")
                        with s_cols[3]:
                            s2c = st.number_input("S2 Ret", min_value=0, max_value=7, value=0, key=f"s2c_{m['id']}")
                        with s_cols[4]:
                            s3d = st.number_input("S3 Def", min_value=0, max_value=10, value=0, key=f"s3d_{m['id']}")
                        with s_cols[5]:
                            s3c = st.number_input("S3 Ret", min_value=0, max_value=10, value=0, key=f"s3c_{m['id']}")

                        # Determine winner
                        sets_d = (1 if s1d > s1c else 0) + (1 if s2d > s2c else 0) + (1 if s3d > s3c else 0)
                        sets_c = (1 if s1c > s1d else 0) + (1 if s2c > s2d else 0) + (1 if s3c > s3d else 0)

                        winner_opts = [d_name, c_name]
                        winner_default = 0 if sets_d >= sets_c else 1
                        winner_label = st.radio("Ganador", winner_opts, index=winner_default, key=f"win_{m['id']}", horizontal=True)
                        winner_id = m["defender_id"] if winner_label == d_name else m["challenger_id"]

                        is_forfeit = st.checkbox("Walkover / Forfeit", key=f"forfeit_{m['id']}")

                        if st.button("💾 GUARDAR RESULTADO", key=f"save_{m['id']}", use_container_width=True):
                            scores = {
                                "set1_defender": s1d, "set1_challenger": s1c,
                                "set2_defender": s2d, "set2_challenger": s2c,
                                "set3_defender": s3d if s3d > 0 or s3c > 0 else None,
                                "set3_challenger": s3c if s3d > 0 or s3c > 0 else None,
                            }
                            result = RankingService.apply_match_result(
                                m["id"], winner_id, scores, is_forfeit,
                                entered_by=user.get("id")
                            )
                            if result.get("swapped"):
                                st.toast(f"🔄 ¡{c_name} sube a #{d_pos}!")
                            else:
                                st.toast(f"✅ {d_name} defiende la posición #{d_pos}")
                            st.rerun()

        # ── Close week button ─────────────────────────────────
        if not selected_week.get("is_completed"):
            st.divider()
            st.warning("⚠️ Al cerrar la semana, los partidos sin resultado se marcarán como forfeit (6-0 6-0) a favor del defensor.")
            if st.button("🔒 CERRAR SEMANA", key="close_week_btn", use_container_width=True):
                RankingService.complete_week(selected_week_id)
                st.toast("✅ Semana cerrada exitosamente")
                st.rerun()
