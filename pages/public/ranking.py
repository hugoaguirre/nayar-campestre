"""
Public Ranking Page — visible to everyone, no auth required.
Reads ranking data using the anon Supabase client (RLS: public SELECT).
"""
import streamlit as st
from utils.supabase_client import get_anon_client

# ── Page CSS ──────────────────────────────────────────────────
st.markdown("""
<style>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700;800;900&family=Inter:wght@400;500;600&display=swap');

.ladder-row {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 0.7rem 1.2rem;
    border-radius: 10px;
    margin-bottom: 4px;
    transition: background 0.2s;
}
.ladder-row:hover {
    background: rgba(255,255,255,0.06);
}
.ladder-pos {
    font-family: 'Montserrat', sans-serif;
    font-weight: 900;
    font-size: 1.3rem;
    width: 44px;
    height: 44px;
    line-height: 44px;
    text-align: center;
    border-radius: 50%;
    flex-shrink: 0;
}
.pos-top3 {
    background: linear-gradient(135deg, #CCFF00, #a3cc00);
    color: #003319;
}
.pos-normal {
    background: rgba(255,255,255,0.1);
    color: #ffffff;
}
.ladder-name {
    font-family: 'Montserrat', sans-serif;
    font-weight: 700;
    font-size: 1rem;
    color: #ffffff;
    flex-grow: 1;
}
.sc-pill {
    display: inline-block;
    padding: 3px 12px;
    border-radius: 20px;
    font-family: 'Montserrat', sans-serif;
    font-weight: 700;
    font-size: 0.65rem;
    letter-spacing: 1px;
    flex-shrink: 0;
}
.sc-A, .sc-AA  { background: #CCFF00; color: #003319; }
.sc-Bplus      { background: #a78bfa; color: #1e1b4b; }
.sc-B          { background: #60a5fa; color: #1e3a5f; }
.sc-C          { background: #34d399; color: #064e3b; }
.sc-D          { background: #fbbf24; color: #78350f; }

.match-card {
    background: rgba(255,255,255,0.06);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255,255,255,0.08);
    border-radius: 10px;
    padding: 0.8rem 1.2rem;
    margin-bottom: 0.5rem;
}
.score-badge {
    font-family: 'Montserrat', sans-serif;
    font-weight: 800;
    font-size: 1rem;
    color: #CCFF00;
}
.vs-label {
    color: rgba(255,255,255,0.3);
    font-weight: 900;
    font-size: 0.75rem;
    letter-spacing: 2px;
}
.section-divider {
    border-top: 1px solid rgba(255,255,255,0.08);
    margin: 0.3rem 0;
}
</style>
""", unsafe_allow_html=True)


# ── Data fetching (anon client — public read) ─────────────────
@st.cache_data(ttl=30)
def _fetch_categories():
    client = get_anon_client()
    resp = client.table("categories").select("id, name").execute()
    return resp.data or []

@st.cache_data(ttl=30)
def _fetch_ladder(category_id):
    client = get_anon_client()
    resp = (
        client.table("ranking_ladders")
        .select("position, player_id, players(first_name, last_name)")
        .eq("category_id", category_id)
        .eq("is_active", True)
        .order("position")
        .execute()
    )
    return resp.data or []

@st.cache_data(ttl=30)
def _fetch_subcat_ranges(category_id):
    client = get_anon_client()
    resp = (
        client.table("ranking_subcategory_ranges")
        .select("position_start, position_end, subcategories(name)")
        .eq("category_id", category_id)
        .order("position_start")
        .execute()
    )
    return resp.data or []

@st.cache_data(ttl=30)
def _fetch_current_week(category_id):
    client = get_anon_client()
    resp = (
        client.table("ranking_weeks")
        .select("*")
        .eq("category_id", category_id)
        .order("week_number", desc=True)
        .limit(1)
        .execute()
    )
    return resp.data[0] if resp.data else None

@st.cache_data(ttl=30)
def _fetch_week_matches(week_id):
    client = get_anon_client()
    resp = (
        client.table("ranking_matches")
        .select(
            "*, "
            "defender:players!defender_id(first_name, last_name), "
            "challenger:players!challenger_id(first_name, last_name)"
        )
        .eq("week_id", week_id)
        .order("scheduled_date")
        .order("scheduled_time")
        .execute()
    )
    return resp.data or []

def _get_subcat_label(position, ranges):
    for r in ranges:
        if r["position_start"] <= position <= r["position_end"]:
            return (r.get("subcategories") or {}).get("name", "")
    return ""

def _sc_css(name):
    if name in ("A", "AA"):
        return "sc-A"
    if name == "B+":
        return "sc-Bplus"
    return f"sc-{name}"


# ── Hero Header ───────────────────────────────────────────────
st.markdown("""
<div style="text-align:center; padding-top:2rem; padding-bottom:1rem;">
    <h1 style="font-family:'Montserrat',sans-serif; font-weight:900;
               font-size:3.5rem; margin:0; letter-spacing:3px; color:#fff;">
        🏆 RANKING
    </h1>
    <p style="color:#CCFF00; font-family:'Montserrat',sans-serif;
              letter-spacing:6px; font-size:0.85rem; font-weight:600;">
        NAYAR CLUB CAMPESTRE
    </p>
</div>
""", unsafe_allow_html=True)

# ── Category Toggle ───────────────────────────────────────────
categories = _fetch_categories()
if not categories:
    st.info("No hay categorías configuradas.")
    st.stop()

cat_names = [c["name"] for c in categories]
# Use segmented pills
cols = st.columns(len(cat_names))
if "pub_cat" not in st.session_state:
    st.session_state.pub_cat = cat_names[0]

for i, cname in enumerate(cat_names):
    with cols[i]:
        is_active = st.session_state.pub_cat == cname
        btn_style = "background:#CCFF00;color:#003319;font-weight:800;" if is_active else "background:rgba(255,255,255,0.08);color:rgba(255,255,255,0.6);"
        if st.button(
            cname.upper(),
            key=f"cat_btn_{cname}",
            use_container_width=True,
        ):
            st.session_state.pub_cat = cname
            st.rerun()

selected_cat = next(c for c in categories if c["name"] == st.session_state.pub_cat)
cat_id = selected_cat["id"]

# ── Fetch Data ────────────────────────────────────────────────
ladder = _fetch_ladder(cat_id)
ranges = _fetch_subcat_ranges(cat_id)
current_week = _fetch_current_week(cat_id)

# ── Current Week Banner ──────────────────────────────────────
if current_week:
    phase = current_week["phase"]
    wn = current_week["week_number"]
    if phase == "challenge":
        phase_text = "⚔️ ¡HORA DE SUBIR!"
        phase_color = "#ef4444"
    else:
        phase_text = "🛡️ DEFIENDE TU CORONA"
        phase_color = "#22c55e"

    st.markdown(f"""
    <div style="text-align:center; margin:1rem 0 1.5rem 0;
                background:rgba(255,255,255,0.06); backdrop-filter:blur(15px);
                border:1px solid rgba(255,255,255,0.1); border-radius:12px;
                padding:1rem;">
        <span style="font-family:'Montserrat',sans-serif; font-size:0.7rem;
                     color:rgba(255,255,255,0.4); letter-spacing:3px;">
            SEMANA {wn}
        </span>
        <h3 style="font-family:'Montserrat',sans-serif; font-weight:900;
                   color:{phase_color}; margin:0.3rem 0 0 0; letter-spacing:2px;">
            {phase_text}
        </h3>
    </div>
    """, unsafe_allow_html=True)

# ── Leaderboard Table ─────────────────────────────────────────
if not ladder:
    st.markdown("""
    <div style="text-align:center; padding:3rem; background:rgba(255,255,255,0.06);
                border-radius:12px; margin:2rem 0;">
        <p style="font-family:'Montserrat',sans-serif; color:rgba(255,255,255,0.5);
                  font-size:1rem;">🎾 Escalera en construcción</p>
    </div>
    """, unsafe_allow_html=True)
else:
    prev_subcat = None
    for entry in ladder:
        pos = entry["position"]
        player = entry.get("players", {}) or {}
        name = f"{player.get('first_name','')} {player.get('last_name','')}"
        subcat = _get_subcat_label(pos, ranges)

        # Sub-category section divider
        if subcat and subcat != prev_subcat:
            if prev_subcat is not None:
                st.markdown('<div class="section-divider"></div>', unsafe_allow_html=True)
            prev_subcat = subcat

        pos_class = "pos-top3" if pos <= 3 else "pos-normal"
        pill_html = f'<span class="sc-pill {_sc_css(subcat)}">{subcat}</span>' if subcat else ""

        st.markdown(f"""
        <div class="ladder-row">
            <div class="ladder-pos {pos_class}">{pos}</div>
            <div class="ladder-name">{name}</div>
            {pill_html}
        </div>
        """, unsafe_allow_html=True)

# ── Current Week Matches ──────────────────────────────────────
if current_week:
    week_matches = _fetch_week_matches(current_week["id"])
    if week_matches:
        st.markdown("""
        <div style="margin-top:2rem;">
            <h3 style="font-family:'Montserrat',sans-serif; font-weight:800;
                       font-size:1.1rem; letter-spacing:2px; color:rgba(255,255,255,0.7);">
                📋 PARTIDOS DE LA SEMANA
            </h3>
        </div>
        """, unsafe_allow_html=True)

        for m in week_matches:
            defender = m.get("defender", {}) or {}
            challenger = m.get("challenger", {}) or {}
            d_name = f"{defender.get('first_name','')} {defender.get('last_name','')}"
            c_name = f"{challenger.get('first_name','')} {challenger.get('last_name','')}"
            d_pos = m["defender_position"]
            c_pos = m["challenger_position"]

            sched = ""
            if m.get("scheduled_date") and m.get("scheduled_time"):
                sched_time = m["scheduled_time"][:5] if isinstance(m["scheduled_time"], str) else str(m["scheduled_time"])
                sched = f"{m['scheduled_date']} · {sched_time} · Cancha {m.get('court_number','?')}"

            if m["is_completed"]:
                # Show score
                s1 = f"{m.get('set1_defender',0)}-{m.get('set1_challenger',0)}"
                s2 = f"{m.get('set2_defender',0)}-{m.get('set2_challenger',0)}"
                s3 = ""
                if m.get("set3_defender") is not None:
                    s3 = f" {m['set3_defender']}-{m['set3_challenger']}"
                score_html = f'<span class="score-badge">{s1} {s2}{s3}</span>'
                winner_id = m.get("winner_id")
                d_style = "color:#CCFF00;font-weight:800;" if winner_id == m["defender_id"] else "color:rgba(255,255,255,0.5);"
                c_style = "color:#CCFF00;font-weight:800;" if winner_id == m["challenger_id"] else "color:rgba(255,255,255,0.5);"
            else:
                score_html = f'<span style="font-size:0.7rem; color:rgba(255,255,255,0.3);">{sched}</span>'
                d_style = c_style = ""

            st.markdown(f"""
            <div class="match-card">
                <div style="display:flex; align-items:center; justify-content:center; gap:0.8rem; flex-wrap:wrap;">
                    <span style="font-family:'Montserrat',sans-serif; font-size:0.9rem; {d_style}">
                        #{d_pos} {d_name}
                    </span>
                    <span class="vs-label">VS</span>
                    <span style="font-family:'Montserrat',sans-serif; font-size:0.9rem; {c_style}">
                        #{c_pos} {c_name}
                    </span>
                </div>
                <div style="text-align:center; margin-top:0.4rem;">{score_html}</div>
            </div>
            """, unsafe_allow_html=True)

# ── Footer ────────────────────────────────────────────────────
st.markdown("""
<div style="text-align:center; margin-top:3rem; padding-bottom:2rem; opacity:0.3;">
    <p style="font-family:'Montserrat',sans-serif; font-size:0.65rem;
              color:#ffffff; letter-spacing:3px;">
        ESTABLECIDO 1974 · CLUB NAYAR CAMPESTRE
    </p>
</div>
""", unsafe_allow_html=True)
