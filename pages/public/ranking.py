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

/* ── Leaderboard Table ─────────────────────────────────── */
.ladder-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0 3px;
}
.ladder-table tr {
    transition: background 0.2s;
}
.ladder-table tr:hover {
    background: rgba(255,255,255,0.04);
}
.ladder-table td {
    padding: 0.55rem 0.6rem;
    vertical-align: middle;
}

/* ── Position Badges ───────────────────────────────────── */
.pos-badge {
    font-family: 'Montserrat', sans-serif;
    font-weight: 900;
    font-size: 0.95rem;
    width: 36px;
    height: 36px;
    line-height: 36px;
    text-align: center;
    border-radius: 50%;
    display: inline-block;
}
.pos-gold {
    background: linear-gradient(145deg, #f5d442, #c9a227);
    color: #3d2e00;
    box-shadow: 0 2px 8px rgba(245,212,66,0.3);
}
.pos-silver {
    background: linear-gradient(145deg, #d1d5db, #9ca3af);
    color: #374151;
    box-shadow: 0 2px 8px rgba(209,213,219,0.2);
}
.pos-bronze {
    background: linear-gradient(145deg, #d4956a, #b07a50);
    color: #3e2a16;
    box-shadow: 0 2px 8px rgba(212,149,106,0.2);
}
.pos-default {
    background: rgba(255,255,255,0.08);
    color: rgba(255,255,255,0.6);
}

/* ── Player Name ───────────────────────────────────────── */
.player-name {
    font-family: 'Montserrat', sans-serif;
    font-weight: 700;
    font-size: 0.9rem;
    color: #ffffff;
}

/* ── Sub-category Pills ────────────────────────────────── */
.sc-pill {
    display: inline-block;
    padding: 2px 10px;
    border-radius: 20px;
    font-family: 'Montserrat', sans-serif;
    font-weight: 700;
    font-size: 0.6rem;
    letter-spacing: 1px;
    text-transform: uppercase;
}
.sc-A, .sc-AA  { background: #CCFF00; color: #003319; }
.sc-Bplus      { background: #a78bfa; color: #1e1b4b; }
.sc-B          { background: #60a5fa; color: #1e3a5f; }
.sc-C          { background: #34d399; color: #064e3b; }
.sc-D          { background: #fbbf24; color: #78350f; }

/* ── Sub-category Section Headers ──────────────────────── */
.subcat-header {
    display: flex;
    align-items: center;
    gap: 0.8rem;
    margin: 0.8rem 0 0.3rem 0;
}
.subcat-header .label {
    font-family: 'Montserrat', sans-serif;
    font-weight: 800;
    font-size: 0.65rem;
    letter-spacing: 2px;
    color: rgba(255,255,255,0.35);
    text-transform: uppercase;
    white-space: nowrap;
}
.subcat-header .line {
    flex-grow: 1;
    height: 1px;
    background: rgba(255,255,255,0.08);
}

/* ── Wimbledon Scorebug Cards ─────────────────────────── */
.match-stat-card {
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.15);
    border-top: 3px solid #450084;
    border-radius: 8px;
    padding: 0;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3);
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    min-width: 340px;
    flex-shrink: 0;
    scroll-snap-align: start;
    overflow: hidden;
}
.match-stat-card:hover {
    transform: translateY(-3px);
    background: rgba(255, 255, 255, 0.12);
    border-color: rgba(255, 255, 255, 0.3);
    border-top-color: #450084;
    box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3);
}
.match-stat-card .meta {
    font-family: 'Inter', sans-serif;
    font-size: 0.6rem;
    color: rgba(255,255,255,0.35);
    text-transform: uppercase;
    letter-spacing: 1px;
    padding: 0.5rem 0.8rem 0.3rem;
}

/* Scorebug table */
.scorebug {
    width: 100%;
    border-collapse: collapse;
    font-family: 'Montserrat', sans-serif;
}
.scorebug tr {
    border-top: 1px solid rgba(255,255,255,0.06);
}
.scorebug tr:first-child {
    border-top: none;
}
/* Player name cell */
.scorebug .sb-name {
    padding: 0.5rem 0.6rem;
    font-weight: 600;
    font-size: 0.82rem;
    color: #ffffff;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 160px;
}
.scorebug .sb-name .sb-pos {
    font-weight: 500;
    font-size: 0.65rem;
    color: rgba(255,255,255,0.45);
    margin-left: 0.3rem;
}
/* Set score cells */
.scorebug .sb-set {
    width: 32px;
    text-align: center;
    padding: 0.5rem 0;
    font-size: 0.85rem;
    font-weight: 500;
    color: rgba(255,255,255,0.5);
    background: rgba(255,255,255,0.04);
    border-left: 1px solid rgba(255,255,255,0.06);
}
.scorebug .sb-set.set-won {
    font-weight: 800;
    color: #CCFF00;
}
/* Winner row gets a subtle left accent */
.scorebug tr.sb-winner .sb-name {
    color: #ffffff;
    font-weight: 700;
}
.scorebug tr.sb-loser .sb-name {
    color: rgba(255,255,255,0.4);
    font-weight: 500;
}

/* Pending match (no scores yet) */
.sb-pending {
    text-align: center;
    padding: 0.6rem;
    font-family: 'Montserrat', sans-serif;
    font-weight: 700;
    font-size: 0.75rem;
    letter-spacing: 1px;
    color: rgba(255,255,255,0.25);
}

/* ── Match Carousel ────────────────────────────────────── */
.match-carousel {
    display: flex;
    gap: 0.8rem;
    overflow-x: auto;
    scroll-snap-type: x mandatory;
    padding: 0.5rem 0 1rem 0;
    -webkit-overflow-scrolling: touch;
}
.match-carousel::-webkit-scrollbar {
    height: 4px;
}
.match-carousel::-webkit-scrollbar-track {
    background: rgba(255,255,255,0.05);
    border-radius: 4px;
}
.match-carousel::-webkit-scrollbar-thumb {
    background: #450084;
    border-radius: 4px;
}

/* ── Phase Banner ──────────────────────────────────────── */
.phase-banner {
    text-align: center;
    margin: 1.2rem 0;
    padding: 0.8rem 1rem;
    background: rgba(255,255,255,0.06);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 8px;
}
.phase-banner .week-label {
    font-family: 'Montserrat', sans-serif;
    font-size: 0.65rem;
    color: rgba(255,255,255,0.35);
    letter-spacing: 3px;
    text-transform: uppercase;
}
.phase-banner .phase-text {
    font-family: 'Montserrat', sans-serif;
    font-weight: 900;
    font-size: 1.2rem;
    letter-spacing: 2px;
    margin-top: 0.2rem;
}



/* ── Section Title ─────────────────────────────────────── */
.section-title {
    font-family: 'Montserrat', sans-serif;
    font-weight: 800;
    font-size: 0.75rem;
    letter-spacing: 3px;
    color: rgba(255,255,255,0.4);
    text-transform: uppercase;
    margin: 2rem 0 0.8rem 0;
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

def _short_name(first: str, last: str) -> str:
    """Truncate name to 'First Lastname' (2 words max) for scorebug."""
    first = (first or "").strip()
    last = (last or "").strip()
    if not first:
        return last
    if not last:
        return first
    # Keep only the first word of the last name
    last_word = last.split()[0] if last else ""
    return f"{first} {last_word}"

def _sc_css(name):
    if name in ("A", "AA"):
        return "sc-A"
    if name == "B+":
        return "sc-Bplus"
    return f"sc-{name}"

def _pos_class(pos):
    if pos == 1:
        return "pos-gold"
    if pos == 2:
        return "pos-silver"
    if pos == 3:
        return "pos-bronze"
    return "pos-default"


# ── Hero Header ───────────────────────────────────────────────
st.markdown("""
<div style="text-align:center; padding-top:1.5rem; padding-bottom:0.5rem;">
    <h1 style="font-family:'Montserrat',sans-serif; font-weight:900;
               font-size:3.2rem; margin:0; letter-spacing:3px; color:#fff;">
        🏆 RANKING
    </h1>
    <p style="color:#CCFF00; font-family:'Montserrat',sans-serif;
              letter-spacing:6px; font-size:0.75rem; font-weight:600; margin-top:0.3rem;">
        NAYAR CLUB CAMPESTRE
    </p>
</div>
""", unsafe_allow_html=True)


# ── Category Tabs ─────────────────────────────────────────────
categories = _fetch_categories()
if not categories:
    st.info("No hay categorías configuradas.")
    st.stop()

cat_names = [c["name"] for c in categories]

# ── Phase Banner (rendered once above tabs) ───────────────────
_first_week = _fetch_current_week(categories[0]["id"])
if _first_week:
    _phase = _first_week["phase"]
    _wn = _first_week["week_number"]
    _phase_text = "⚔️ CHALLENGE" if _phase == "challenge" else "🛡️ DEFEND"
    st.markdown(f"""
    <div class="phase-banner">
        <div class="week-label">SEMANA {_wn}</div>
        <div class="phase-text" style="color:#ffffff;">{_phase_text}</div>
    </div>
    """, unsafe_allow_html=True)

cat_tabs = st.tabs([n.upper() for n in cat_names])

for cat_idx, cat_tab in enumerate(cat_tabs):
    selected_cat = categories[cat_idx]
    cat_id = selected_cat["id"]

    with cat_tab:
        # ── Fetch Data ────────────────────────────────────────
        ladder = _fetch_ladder(cat_id)
        ranges = _fetch_subcat_ranges(cat_id)
        current_week = _fetch_current_week(cat_id)


        # ── Leaderboard Table ──────────────────────────────────
        if not ladder:
            st.markdown("""
            <div style="text-align:center; padding:3rem 1rem;">
                <p style="font-family:'Montserrat',sans-serif; color:rgba(255,255,255,0.35);
                          font-size:0.9rem; letter-spacing:2px;">
                    🎾 ESCALERA EN CONSTRUCCIÓN
                </p>
            </div>
            """, unsafe_allow_html=True)
        else:
            prev_subcat = None
            subcat_rank = 0
            table_html = '<table class="ladder-table">'

            for entry in ladder:
                pos = entry["position"]
                player = entry.get("players", {}) or {}
                name = f"{player.get('first_name','')} {player.get('last_name','')}"
                subcat = _get_subcat_label(pos, ranges)

                if subcat and subcat != prev_subcat:
                    table_html += (
                        f'<tr><td colspan="2" style="padding:0;">'
                        f'<div class="subcat-header">'
                        f'<span class="line"></span>'
                        f'<span class="label">{subcat}</span>'
                        f'<span class="line"></span>'
                        f'</div></td></tr>'
                    )
                    prev_subcat = subcat
                    subcat_rank = 1
                else:
                    subcat_rank += 1

                badge_cls = _pos_class(subcat_rank)
                table_html += (
                    f'<tr>'
                    f'<td style="width:50px;"><span class="pos-badge {badge_cls}">{pos}</span></td>'
                    f'<td><span class="player-name">{name}</span></td>'
                    f'</tr>'
                )

            table_html += '</table>'
            st.markdown(table_html, unsafe_allow_html=True)

        # ── Weekly Matches Carousel ───────────────────────────
        if current_week:
            week_matches = _fetch_week_matches(current_week["id"])
            if week_matches:
                st.markdown('<p class="section-title">📋 Partidos de la Semana</p>', unsafe_allow_html=True)

                carousel_cards = ""
                for m in week_matches:
                    defender = m.get("defender", {}) or {}
                    challenger = m.get("challenger", {}) or {}
                    d_name = _short_name(defender.get('first_name',''), defender.get('last_name',''))
                    c_name = _short_name(challenger.get('first_name',''), challenger.get('last_name',''))
                    d_pos = m["defender_position"]
                    c_pos = m["challenger_position"]

                    meta = ""
                    if m.get("scheduled_date") and m.get("scheduled_time"):
                        t = m["scheduled_time"][:5] if isinstance(m["scheduled_time"], str) else str(m["scheduled_time"])
                        meta = f"{m['scheduled_date']} · {t} · Cancha {m.get('court_number', '?')}"

                    if m["is_completed"]:
                        winner_id = m.get("winner_id")
                        d_won = winner_id == m["defender_id"]
                        c_won = winner_id == m["challenger_id"]

                        # Build set cells for each player
                        sets = [
                            (m.get('set1_defender'), m.get('set1_challenger')),
                            (m.get('set2_defender'), m.get('set2_challenger')),
                        ]
                        if m.get('set3_defender') is not None:
                            sets.append((m.get('set3_defender'), m.get('set3_challenger')))

                        d_sets = ""
                        c_sets = ""
                        for ds, cs in sets:
                            d_set_won = "set-won" if ds is not None and cs is not None and ds > cs else ""
                            c_set_won = "set-won" if ds is not None and cs is not None and cs > ds else ""
                            d_sets += f'<td class="sb-set {d_set_won}">{ds if ds is not None else ""}</td>'
                            c_sets += f'<td class="sb-set {c_set_won}">{cs if cs is not None else ""}</td>'

                        # Pad to 3 set columns
                        for _ in range(3 - len(sets)):
                            d_sets += '<td class="sb-set"></td>'
                            c_sets += '<td class="sb-set"></td>'

                        d_row_cls = 'sb-winner' if d_won else 'sb-loser'
                        c_row_cls = 'sb-winner' if c_won else 'sb-loser'

                        scorebug = (
                            f'<table class="scorebug">'
                            f'<tr class="{d_row_cls}">'
                            f'<td class="sb-name">{d_name} <span class="sb-pos">{d_pos}</span></td>'
                            f'{d_sets}'
                            f'</tr>'
                            f'<tr class="{c_row_cls}">'
                            f'<td class="sb-name">{c_name} <span class="sb-pos">{c_pos}</span></td>'
                            f'{c_sets}'
                            f'</tr>'
                            f'</table>'
                        )
                    else:
                        scorebug = (
                            f'<table class="scorebug">'
                            f'<tr>'
                            f'<td class="sb-name">{d_name} <span class="sb-pos">{d_pos}</span></td>'
                            f'<td class="sb-set"></td><td class="sb-set"></td><td class="sb-set"></td></tr>'
                            f'<tr>'
                            f'<td class="sb-name">{c_name} <span class="sb-pos">{c_pos}</span></td>'
                            f'<td class="sb-set"></td><td class="sb-set"></td><td class="sb-set"></td></tr>'
                            f'</table>'
                        )

                    carousel_cards += (
                        f'<div class="match-stat-card">'
                        f'<div class="meta">{meta if meta else "Horario por definir"}</div>'
                        f'{scorebug}'
                        f'</div>'
                    )

                st.markdown(f'<div class="match-carousel">{carousel_cards}</div>', unsafe_allow_html=True)

# ── Footer ────────────────────────────────────────────────────
st.markdown("""
<div style="text-align:center; margin-top:3rem; padding-bottom:2rem;">
    <p style="font-family:'Montserrat',sans-serif; font-size:0.6rem;
              color:rgba(255,255,255,0.2); letter-spacing:3px;">
        ESTABLECIDO 1974 · CLUB NAYAR CAMPESTRE
    </p>
</div>
""", unsafe_allow_html=True)
