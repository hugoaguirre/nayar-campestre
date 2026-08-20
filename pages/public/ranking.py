"""
Public Ranking Page — visible to everyone, no auth required.
Reads ranking data using the anon Supabase client (RLS: public SELECT).
"""

import streamlit as st
from utils.supabase_client import get_anon_client
from components.custom_table import _table_component

# ── Page CSS ──────────────────────────────────────────────────
st.markdown(
    """
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

/* ── Wimbledon Luxury Dialog Modal Styling ────────────────── */
/* 1. Backdrop Overlay (Dark & Blurred) */
div[data-testid="stDialog"] {
    background-color: rgba(0, 0, 0, 0.75) !important;
    backdrop-filter: blur(8px) !important;
    -webkit-backdrop-filter: blur(8px) !important;
}

/* 2. Inner Modal Card Only (Wimbledon Green #003319, Tennis Yellow Border, Rounded) */
div[data-testid="stDialog"] > div > div,
div[data-testid="stDialog"] [role="dialog"],
div[data-testid="stDialog"] [data-testid="stVerticalBlockBorderWrapper"] {
    background-color: #003319 !important;
    background: linear-gradient(165deg, #003e1f 0%, #002814 100%) !important;
    border: 2px solid #CCFF00 !important;
    border-radius: 18px !important;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.85), 0 0 25px rgba(204, 255, 0, 0.25) !important;
    color: #ffffff !important;
}

div[data-testid="stDialog"] header {
    background: transparent !important;
    color: #ffffff !important;
    min-height: 0 !important;
    padding-top: 0.5rem !important;
}

div[data-testid="stDialog"] header h1, 
div[data-testid="stDialog"] header h2,
div[data-testid="stDialog"] header [data-testid="stMarkdownContainer"],
div[data-testid="stDialog"] header span {
    display: none !important;
}

div[data-testid="stDialog"] button[aria-label="Close"],
div[data-testid="stDialog"] button[title="Close"] {
    color: #ffffff !important;
    background: rgba(255, 255, 255, 0.12) !important;
    border-radius: 50% !important;
    border: 1px solid rgba(255, 255, 255, 0.2) !important;
    transition: all 0.2s ease !important;
}
div[data-testid="stDialog"] button[aria-label="Close"]:hover,
div[data-testid="stDialog"] button[title="Close"]:hover {
    background: rgba(239, 68, 68, 0.4) !important;
    border-color: #ef4444 !important;
    color: #ffffff !important;
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
    color: #8a6d10;
    box-shadow: 0 2px 8px rgba(245,212,66,0.3);
}
.pos-silver {
    background: linear-gradient(145deg, #d1d5db, #9ca3af);
    color: #5a6270;
    box-shadow: 0 2px 8px rgba(209,213,219,0.2);
}
.pos-bronze {
    background: linear-gradient(145deg, #d4956a, #b07a50);
    color: #6b3f1f;
    box-shadow: 0 2px 8px rgba(212,149,106,0.2);
}
.pos-default {
    background: rgba(255,255,255,0.08);
    color: rgba(255,255,255,0.6);
}

/* ── Player Name & Streak Badges ───────────────────────── */
.player-name {
    font-family: 'Montserrat', sans-serif;
    font-weight: 700;
    font-size: 0.9rem;
    color: #ffffff;
}
.streak-badge {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    margin-left: 0.6rem;
    padding: 4px 12px;
    border-radius: 14px;
    font-family: 'Montserrat', sans-serif;
    font-weight: 800;
    font-size: 0.78rem;
    letter-spacing: 0.8px;
    white-space: nowrap;
    vertical-align: middle;
    animation: streakPulse 2.5s ease-in-out infinite;
}
.streak-hot {
    background: linear-gradient(135deg, rgba(255, 140, 0, 0.35), rgba(255, 80, 0, 0.2));
    border: 1px solid rgba(255, 170, 0, 0.85);
    color: #FFCC44;
    box-shadow: 0 0 8px rgba(255, 140, 0, 0.5), 0 0 20px rgba(255, 140, 0, 0.35), 0 0 40px rgba(255, 100, 0, 0.15);
    text-shadow: 0 0 8px rgba(255, 160, 0, 0.7);
}
.streak-super {
    background: linear-gradient(135deg, rgba(204, 255, 0, 0.35), rgba(150, 255, 0, 0.18));
    border: 1px solid rgba(204, 255, 0, 0.9);
    color: #CCFF00;
    box-shadow: 0 0 10px rgba(204, 255, 0, 0.6), 0 0 25px rgba(204, 255, 0, 0.4), 0 0 50px rgba(204, 255, 0, 0.15);
    text-shadow: 0 0 10px rgba(204, 255, 0, 0.8);
    animation: streakGlow 2s ease-in-out infinite;
}
@keyframes streakPulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.8; }
}
@keyframes streakGlow {
    0%, 100% { box-shadow: 0 0 10px rgba(204, 255, 0, 0.6), 0 0 25px rgba(204, 255, 0, 0.4), 0 0 50px rgba(204, 255, 0, 0.15); }
    50% { box-shadow: 0 0 14px rgba(204, 255, 0, 0.8), 0 0 35px rgba(204, 255, 0, 0.55), 0 0 60px rgba(204, 255, 0, 0.25); }
}

/* ── Sub-category Pills ────────────────────────────────── */
.sc-pill {
    display: inline-block;
    padding: 4px 14px;
    border-radius: 20px;
    font-family: 'Montserrat', sans-serif;
    font-weight: 800;
    font-size: 0.8rem;
    letter-spacing: 1.5px;
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
    gap: 1rem;
    margin: 1.4rem 0 0.5rem 0;
    padding: 0.3rem 0;
}
.subcat-header .label {
    font-family: 'Montserrat', sans-serif;
    font-weight: 800;
    font-size: 0.9rem;
    letter-spacing: 3px;
    color: #CCFF00;
    text-transform: uppercase;
    white-space: nowrap;
    text-shadow: 0 0 8px rgba(204, 255, 0, 0.25);
}
.subcat-header .line {
    flex-grow: 1;
    height: 1px;
    background: linear-gradient(90deg, rgba(204, 255, 0, 0.4), rgba(204, 255, 0, 0.05));
}
.subcat-header .line:first-child {
    background: linear-gradient(90deg, rgba(204, 255, 0, 0.05), rgba(204, 255, 0, 0.4));
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



/* ── Borderless Player Name Buttons in Ladder ───────────── */
div[data-testid="stColumn"] div.stButton > button {
    background: transparent !important;
    border: none !important;
    box-shadow: none !important;
    color: #ffffff !important;
    font-family: 'Montserrat', sans-serif !important;
    font-weight: 700 !important;
    font-size: 0.9rem !important;
    padding: 0.35rem 0 !important;
    margin: 0 !important;
    text-align: left !important;
    justify-content: flex-start !important;
    text-decoration: none !important;
    width: 100% !important;
}
div[data-testid="stColumn"] div.stButton > button:hover {
    color: #CCFF00 !important;
    background: transparent !important;
    border: none !important;
    box-shadow: none !important;
}
div[data-testid="stColumn"] div.stButton > button:focus {
    outline: none !important;
    box-shadow: none !important;
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

<script>
(function() {
    try {
        function getTargets() {
            const targets = [];
            const pDoc = window.parent.document;
            const m = pDoc.querySelector('[data-testid="stMain"]') ||
                      pDoc.querySelector('.stAppViewContainer') ||
                      pDoc.querySelector('section.main');
            if (m) targets.push(m);
            if (window.parent) targets.push(window.parent);
            if (pDoc.documentElement) targets.push(pDoc.documentElement);
            if (pDoc.body) targets.push(pDoc.body);
            return targets;
        }

        function restoreScroll() {
            const savedY = window.parent.sessionStorage.setItem ? window.parent.sessionStorage.getItem('st_ladder_scroll_pos') : null;
            if (!savedY || parseFloat(savedY) <= 0) return;
            window.parent.sessionStorage.removeItem('st_ladder_scroll_pos');
            const y = parseFloat(savedY);
            let ticks = 0;
            const timer = setInterval(() => {
                getTargets().forEach(t => {
                    try {
                        if (t.scrollTo) t.scrollTo({ top: y, behavior: 'instant' });
                        if (t.scrollTop !== undefined) t.scrollTop = y;
                    } catch(e) {}
                });
                ticks++;
                if (ticks >= 25) clearInterval(timer);
            }, 30);
        }

        function savePos() {
            for (const t of getTargets()) {
                const y = t.scrollTop || t.scrollY || t.pageYOffset;
                if (y && y > 0) {
                    window.parent.sessionStorage.setItem('st_ladder_scroll_pos', y);
                    break;
                }
            }
        }

        restoreScroll();
        getTargets().forEach(t => {
            if (t.addEventListener) t.addEventListener('scroll', savePos, { passive: true });
        });
    } catch(e) {}
})();
</script>
""",
    unsafe_allow_html=True,
)


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


def _parse_single_match(m, player_id, is_defender):
    opponent = m.get("challenger", {}) if is_defender else m.get("defender", {})
    opponent_pos = m.get("challenger_position") if is_defender else m.get("defender_position")
    player_pos = m.get("defender_position") if is_defender else m.get("challenger_position")
    won = m.get("winner_id") == player_id

    sets = []
    s1_p = m.get("set1_defender") if is_defender else m.get("set1_challenger")
    s1_o = m.get("set1_challenger") if is_defender else m.get("set1_defender")
    if s1_p is not None and s1_o is not None:
        sets.append((s1_p, s1_o))

    s2_p = m.get("set2_defender") if is_defender else m.get("set2_challenger")
    s2_o = m.get("set2_challenger") if is_defender else m.get("set2_defender")
    if s2_p is not None and s2_o is not None:
        sets.append((s2_p, s2_o))

    s3_p = m.get("set3_defender") if is_defender else m.get("set3_challenger")
    s3_o = m.get("set3_challenger") if is_defender else m.get("set3_defender")
    if s3_p is not None and s3_o is not None:
        sets.append((s3_p, s3_o))

    return {
        "won": won,
        "is_forfeit": m.get("is_forfeit", False),
        "opponent_name": f"{opponent.get('first_name', '')} {opponent.get('last_name', '')}".strip(),
        "opponent_pos": opponent_pos,
        "player_pos": player_pos,
        "week_number": (m.get("ranking_weeks") or {}).get("week_number"),
        "scheduled_date": m.get("scheduled_date"),
        "sets": sets,
    }


@st.cache_data(ttl=30)
def _fetch_category_player_matches(category_id):
    client = get_anon_client()
    resp = (
        client.table("ranking_matches")
        .select(
            "*, "
            "ranking_weeks!inner(category_id, week_number, phase), "
            "defender:players!defender_id(first_name, last_name), "
            "challenger:players!challenger_id(first_name, last_name)"
        )
        .eq("ranking_weeks.category_id", category_id)
        .eq("is_completed", True)
        .order("created_at", desc=True)
        .execute()
    )
    raw_matches = resp.data or []
    from collections import defaultdict
    player_matches = defaultdict(list)
    for m in raw_matches:
        def_id = m["defender_id"]
        chal_id = m["challenger_id"]

        player_matches[def_id].append(_parse_single_match(m, def_id, is_defender=True))
        player_matches[chal_id].append(_parse_single_match(m, chal_id, is_defender=False))

    streaks = {}
    for pid, p_m in player_matches.items():
        count = 0
        for m in p_m:
            if m.get("won"):
                count += 1
            else:
                break
        streaks[pid] = count

    return dict(player_matches), streaks


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


@st.cache_data(ttl=30)
def _fetch_player_recent_matches(player_id, limit=5):
    client = get_anon_client()
    resp = (
        client.table("ranking_matches")
        .select(
            "*, "
            "ranking_weeks(week_number, phase), "
            "defender:players!defender_id(first_name, last_name), "
            "challenger:players!challenger_id(first_name, last_name)"
        )
        .eq("is_completed", True)
        .or_(f"defender_id.eq.{player_id},challenger_id.eq.{player_id}")
        .order("created_at", desc=True)
        .limit(limit)
        .execute()
    )

    raw_matches = resp.data or []
    parsed = []
    for m in raw_matches:
        is_defender = m["defender_id"] == player_id
        opponent = m.get("challenger", {}) if is_defender else m.get("defender", {})
        opponent_pos = (
            m.get("challenger_position") if is_defender else m.get("defender_position")
        )
        player_pos = (
            m.get("defender_position") if is_defender else m.get("challenger_position")
        )
        won = m.get("winner_id") == player_id

        # Parse set scores relative to (player, opponent)
        sets = []
        s1_p = m.get("set1_defender") if is_defender else m.get("set1_challenger")
        s1_o = m.get("set1_challenger") if is_defender else m.get("set1_defender")
        if s1_p is not None and s1_o is not None:
            sets.append((s1_p, s1_o))

        s2_p = m.get("set2_defender") if is_defender else m.get("set2_challenger")
        s2_o = m.get("set2_challenger") if is_defender else m.get("set2_defender")
        if s2_p is not None and s2_o is not None:
            sets.append((s2_p, s2_o))

        s3_p = m.get("set3_defender") if is_defender else m.get("set3_challenger")
        s3_o = m.get("set3_challenger") if is_defender else m.get("set3_defender")
        if s3_p is not None and s3_o is not None:
            sets.append((s3_p, s3_o))

        parsed.append(
            {
                "match_id": m["id"],
                "won": won,
                "is_forfeit": m.get("is_forfeit", False),
                "opponent_name": f"{opponent.get('first_name', '')} {opponent.get('last_name', '')}".strip(),
                "opponent_pos": opponent_pos,
                "player_pos": player_pos,
                "week_number": (m.get("ranking_weeks") or {}).get("week_number"),
                "phase": (m.get("ranking_weeks") or {}).get("phase"),
                "scheduled_date": m.get("scheduled_date"),
                "sets": sets,
            }
        )

    return parsed


# ── Player Stats Pop-up Dialog ────────────────────────────────
@st.dialog(" ")
def show_player_stats_modal(player_id: str, name: str, position: int, subcategory: str):
    matches = _fetch_player_recent_matches(player_id, limit=5)

    all_recent = _fetch_player_recent_matches(player_id, limit=10)
    streak = 0
    for m in all_recent:
        if m.get("won"):
            streak += 1
        else:
            break

    sc_pill = (
        f'<span class="sc-pill {_sc_css(subcategory)}">{subcategory}</span>'
        if subcategory
        else ""
    )

    st.markdown(
        f"""
    <div style="text-align:center; padding: 0.2rem 0 0.8rem 0;">
        <div style="display:inline-block; margin-bottom:0.4rem;">
            <span class="pos-badge {_pos_class(position)}" style="width:46px; height:46px; line-height:46px; font-size:1.15rem;">
                #{position}
            </span>
        </div>
        <h2 style="font-family:'Montserrat',sans-serif; font-weight:800; font-size:1.4rem; color:#fff; margin:0.2rem 0;">
            {name}
        </h2>
        <div style="margin-top:0.3rem;">{sc_pill}</div>
    </div>
    """,
        unsafe_allow_html=True,
    )

    # Streak banner — rendered as its own st.markdown to avoid HTML escaping
    if streak >= 3:
        if streak >= 5:
            banner_bg = "linear-gradient(135deg, rgba(204,255,0,0.15), rgba(150,255,0,0.08))"
            banner_border = "#CCFF00"
            banner_color = "#CCFF00"
            banner_shadow = "0 0 18px rgba(204,255,0,0.3)"
        else:
            banner_bg = "linear-gradient(135deg, rgba(255,140,0,0.15), rgba(255,80,0,0.08))"
            banner_border = "#FFAA00"
            banner_color = "#FFBB33"
            banner_shadow = "0 0 14px rgba(255,140,0,0.25)"

        st.markdown(
            f"""
        <div style="
            background: {banner_bg};
            border: 1px solid {banner_border};
            border-radius: 12px;
            padding: 0.5rem 1rem;
            text-align: center;
            margin: 0 auto 0.8rem auto;
            max-width: 320px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 0.72rem;
            color: {banner_color};
            letter-spacing: 1.5px;
            box-shadow: {banner_shadow};
            text-shadow: 0 0 8px rgba(255,140,0,0.3);
        ">
            EN UNA RACHA 🔥
        </div>
        """,
            unsafe_allow_html=True,
        )

    if not matches:
        st.markdown(
            """
        <div style="background:rgba(255,255,255,0.05); border:1px dashed rgba(255,255,255,0.15); border-radius:10px; padding:2rem 1rem; text-align:center; margin:1rem 0;">
            <p style="font-family:'Montserrat',sans-serif; font-size:0.85rem; color:rgba(255,255,255,0.4); margin:0; letter-spacing:1px;">
                🎾 SIN PARTIDOS REGISTRADOS AÚN
            </p>
            <p style="font-family:'Inter',sans-serif; font-size:0.75rem; color:rgba(255,255,255,0.3); margin-top:0.4rem;">
                Este jugador aún no tiene resultados de partidos en la escalera actual.
            </p>
        </div>
        """,
            unsafe_allow_html=True,
        )
        return

    wins = sum(1 for m in matches if m["won"])
    losses = len(matches) - wins
    win_rate = int((wins / len(matches)) * 100) if matches else 0

    form_pills = ""
    for m in matches:
        if m["won"]:
            form_pills += '<span style="color:#CCFF00; font-size:0.85rem; margin-right:3px;" title="Victoria">●</span>'
        else:
            form_pills += '<span style="color:#ef4444; font-size:0.85rem; margin-right:3px;" title="Derrota">●</span>'

    st.markdown(
        f"""
    <div style="display:flex; justify-content:space-around; align-items:center; background:rgba(255,255,255,0.06); border:1px solid rgba(255,255,255,0.1); border-radius:10px; padding:0.8rem 0.5rem; margin-bottom:1.2rem;">
        <div style="text-align:center;">
            <div style="font-family:'Montserrat',sans-serif; font-size:0.58rem; color:rgba(255,255,255,0.4); text-transform:uppercase; letter-spacing:1px;">Forma Reciente</div>
            <div style="margin-top:0.3rem;">{form_pills}</div>
        </div>
        <div style="height:28px; width:1px; background:rgba(255,255,255,0.1);"></div>
        <div style="text-align:center;">
            <div style="font-family:'Montserrat',sans-serif; font-size:0.58rem; color:rgba(255,255,255,0.4); text-transform:uppercase; letter-spacing:1px;">Record</div>
            <div style="font-family:'Montserrat',sans-serif; font-weight:800; font-size:0.95rem; color:#fff; margin-top:0.1rem;">
                <span style="color:#CCFF00;">{wins}V</span> - <span style="color:#ef4444;">{losses}D</span>
            </div>
        </div>
        <div style="height:28px; width:1px; background:rgba(255,255,255,0.1);"></div>
        <div style="text-align:center;">
            <div style="font-family:'Montserrat',sans-serif; font-size:0.58rem; color:rgba(255,255,255,0.4); text-transform:uppercase; letter-spacing:1px;">Efectividad</div>
            <div style="font-family:'Montserrat',sans-serif; font-weight:800; font-size:0.95rem; color:#CCFF00; margin-top:0.1rem;">
                {win_rate}%
            </div>
        </div>
    </div>
    <div style="font-family:'Montserrat',sans-serif; font-weight:800; font-size:0.7rem; color:rgba(255,255,255,0.4); text-transform:uppercase; letter-spacing:2px; margin-bottom:0.6rem;">
        📋 ÚLTIMOS {len(matches)} PARTIDOS
    </div>
    """,
        unsafe_allow_html=True,
    )

    for m in matches:
        outcome_color = "#CCFF00" if m["won"] else "#ef4444"
        outcome_text = "VICTORIA" if m["won"] else "DERROTA"
        if m["is_forfeit"]:
            outcome_text += " (W.O.)"

        set_strs = [f"{sp}-{so}" for sp, so in m["sets"]]
        scores_formatted = ", ".join(set_strs) if set_strs else "Sin detalle"

        week_info = f"Semana {m['week_number']}" if m["week_number"] else ""
        date_info = f" · {m['scheduled_date']}" if m["scheduled_date"] else ""

        st.markdown(
            f"""
        <div style="background:rgba(255,255,255,0.06); border:1px solid rgba(255,255,255,0.1); border-left:4px solid {outcome_color}; border-radius:6px; padding:0.6rem 0.8rem; margin-bottom:0.5rem;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <div style="font-family:'Montserrat',sans-serif; font-weight:700; font-size:0.85rem; color:#fff;">
                    vs. {m["opponent_name"]} <span style="font-size:0.7rem; color:rgba(255,255,255,0.4);">#{m["opponent_pos"]}</span>
                </div>
                <div style="font-family:'Montserrat',sans-serif; font-weight:800; font-size:0.7rem; color:{outcome_color}; letter-spacing:1px;">
                    {outcome_text}
                </div>
            </div>
            <div style="display:flex; justify-content:space-between; align-items:center; margin-top:0.3rem;">
                <div style="font-family:'Montserrat',sans-serif; font-weight:600; font-size:0.8rem; color:#CCFF00;">
                    {scores_formatted}
                </div>
                <div style="font-family:'Inter',sans-serif; font-size:0.65rem; color:rgba(255,255,255,0.35);">
                    {week_info}{date_info}
                </div>
            </div>
        </div>
        """,
            unsafe_allow_html=True,
        )


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
st.markdown(
    """
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
""",
    unsafe_allow_html=True,
)


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
    st.markdown(
        f"""
    <div class="phase-banner">
        <div class="week-label">SEMANA {_wn}</div>
        <div class="phase-text" style="color:#ffffff;">{_phase_text}</div>
    </div>
    """,
        unsafe_allow_html=True,
    )

cat_tabs = st.tabs([n.upper() for n in cat_names])

for cat_idx, cat_tab in enumerate(cat_tabs):
    selected_cat = categories[cat_idx]
    cat_id = selected_cat["id"]

    with cat_tab:
        # ── Fetch Data ────────────────────────────────────────
        ladder = _fetch_ladder(cat_id)
        ranges = _fetch_subcat_ranges(cat_id)
        current_week = _fetch_current_week(cat_id)

        # ── Weekly Matches Carousel ───────────────────────────
        if current_week:
            week_matches = _fetch_week_matches(current_week["id"])
            if week_matches:
                st.markdown(
                    '<p class="section-title">📋 Partidos de la Semana</p>',
                    unsafe_allow_html=True,
                )

                carousel_cards = ""
                for m in week_matches:
                    defender = m.get("defender", {}) or {}
                    challenger = m.get("challenger", {}) or {}
                    d_name = _short_name(
                        defender.get("first_name", ""), defender.get("last_name", "")
                    )
                    c_name = _short_name(
                        challenger.get("first_name", ""),
                        challenger.get("last_name", ""),
                    )
                    d_pos = m["defender_position"]
                    c_pos = m["challenger_position"]

                    meta = ""
                    if m.get("scheduled_date") and m.get("scheduled_time"):
                        t = (
                            m["scheduled_time"][:5]
                            if isinstance(m["scheduled_time"], str)
                            else str(m["scheduled_time"])
                        )
                        meta = f"{m['scheduled_date']} · {t} · Cancha {m.get('court_number', '?')}"

                    if m["is_completed"]:
                        winner_id = m.get("winner_id")
                        d_won = winner_id == m["defender_id"]
                        c_won = winner_id == m["challenger_id"]

                        # Build set cells for each player
                        sets = [
                            (m.get("set1_defender"), m.get("set1_challenger")),
                            (m.get("set2_defender"), m.get("set2_challenger")),
                        ]
                        if m.get("set3_defender") is not None:
                            sets.append(
                                (m.get("set3_defender"), m.get("set3_challenger"))
                            )

                        d_sets = ""
                        c_sets = ""
                        for ds, cs in sets:
                            d_set_won = (
                                "set-won"
                                if ds is not None and cs is not None and ds > cs
                                else ""
                            )
                            c_set_won = (
                                "set-won"
                                if ds is not None and cs is not None and cs > ds
                                else ""
                            )
                            d_sets += f'<td class="sb-set {d_set_won}">{ds if ds is not None else ""}</td>'
                            c_sets += f'<td class="sb-set {c_set_won}">{cs if cs is not None else ""}</td>'

                        # Pad to 3 set columns
                        for _ in range(3 - len(sets)):
                            d_sets += '<td class="sb-set"></td>'
                            c_sets += '<td class="sb-set"></td>'

                        d_row_cls = "sb-winner" if d_won else "sb-loser"
                        c_row_cls = "sb-winner" if c_won else "sb-loser"

                        scorebug = (
                            f'<table class="scorebug">'
                            f'<tr class="{d_row_cls}">'
                            f'<td class="sb-name">{d_name} <span class="sb-pos">{d_pos}</span></td>'
                            f"{d_sets}"
                            f"</tr>"
                            f'<tr class="{c_row_cls}">'
                            f'<td class="sb-name">{c_name} <span class="sb-pos">{c_pos}</span></td>'
                            f"{c_sets}"
                            f"</tr>"
                            f"</table>"
                        )
                    else:
                        scorebug = (
                            f'<table class="scorebug">'
                            f"<tr>"
                            f'<td class="sb-name">{d_name} <span class="sb-pos">{d_pos}</span></td>'
                            f'<td class="sb-set"></td><td class="sb-set"></td><td class="sb-set"></td></tr>'
                            f"<tr>"
                            f'<td class="sb-name">{c_name} <span class="sb-pos">{c_pos}</span></td>'
                            f'<td class="sb-set"></td><td class="sb-set"></td><td class="sb-set"></td></tr>'
                            f"</table>"
                        )

                    carousel_cards += (
                        f'<div class="match-stat-card">'
                        f'<div class="meta">{meta if meta else "Horario por definir"}</div>'
                        f"{scorebug}"
                        f"</div>"
                    )

                st.markdown(
                    f'<div class="match-carousel">{carousel_cards}</div>',
                    unsafe_allow_html=True,
                )

        # ── Leaderboard Table ──────────────────────────────────
        if not ladder:
            st.markdown(
                """
            <div style="text-align:center; padding:3rem 1rem;">
                <p style="font-family:'Montserrat',sans-serif; color:rgba(255,255,255,0.35);
                          font-size:0.9rem; letter-spacing:2px;">
                    🎾 ESCALERA EN CONSTRUCCIÓN
                </p>
            </div>
            """,
                unsafe_allow_html=True,
            )
        else:
            prev_subcat = None
            subcat_rank = 0

            table_html = """
            <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700;800;900&family=Inter:wght@400;500;600&display=swap');
            body { margin: 0; padding: 0; background: transparent; }
            .ladder-table {
                width: 100%;
                border-collapse: collapse;
                border-spacing: 0;
                border: 1px solid rgba(255, 255, 255, 0.12);
                border-radius: 8px;
                overflow: hidden;
                background: rgba(255, 255, 255, 0.02);
                margin-top: 0.5rem;
            }
            .ladder-table tr {
                border-bottom: 1px solid rgba(255, 255, 255, 0.12);
                transition: background 0.2s;
            }
            .ladder-table tr:last-child {
                border-bottom: none;
            }
            .ladder-table tr.subcat-row {
                background: transparent;
            }
            .ladder-table tr:not(.subcat-row):hover {
                background: rgba(255, 255, 255, 0.08);
                cursor: pointer;
            }
            .ladder-table tr:not(.subcat-row):hover .player-name {
                color: #CCFF00;
            }
            .ladder-table td {
                padding: 0.65rem 0.8rem;
                vertical-align: middle;
            }
            .ladder-table td:first-child {
                width: 55px;
                text-align: center;
                border-right: 1px solid rgba(255, 255, 255, 0.12);
            }
            .ladder-table td:nth-child(2) {
                padding-left: 1.2rem;
            }
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
                color: #8a6d10;
                box-shadow: 0 2px 8px rgba(245,212,66,0.3);
            }
            .pos-silver {
                background: linear-gradient(145deg, #d1d5db, #9ca3af);
                color: #5a6270;
                box-shadow: 0 2px 8px rgba(209,213,219,0.2);
            }
            .pos-bronze {
                background: linear-gradient(145deg, #d4956a, #b07a50);
                color: #6b3f1f;
                box-shadow: 0 2px 8px rgba(212,149,106,0.2);
            }
            .pos-default {
                background: rgba(255,255,255,0.08);
                color: rgba(255,255,255,0.6);
            }
            .player-name {
                font-family: 'Montserrat', sans-serif;
                font-weight: 700;
                font-size: 0.95rem;
                color: #ffffff;
            }
            .subcat-header {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 0.6rem 0.8rem;
                background: rgba(255,255,255,0.02);
            }
            .subcat-header .label {
                font-family: 'Montserrat', sans-serif;
                font-weight: 800;
                font-size: 0.75rem;
                letter-spacing: 3px;
                color: #CCFF00;
                text-transform: uppercase;
                white-space: nowrap;
                text-shadow: 0 0 8px rgba(204, 255, 0, 0.25);
            }
            .subcat-header .line {
                flex-grow: 1;
                height: 1px;
                background: linear-gradient(90deg, rgba(204, 255, 0, 0.4), rgba(204, 255, 0, 0.05));
            }
            .subcat-header .line:first-child {
                background: linear-gradient(90deg, rgba(204, 255, 0, 0.05), rgba(204, 255, 0, 0.4));
            }
            /* ── Streak Badges (inside iframe) ──────────────────── */
            .streak-badge {
                display: inline-flex;
                align-items: center;
                gap: 4px;
                margin-left: 0.6rem;
                padding: 4px 12px;
                border-radius: 14px;
                font-family: 'Montserrat', sans-serif;
                font-weight: 800;
                font-size: 0.78rem;
                letter-spacing: 0.8px;
                white-space: nowrap;
                vertical-align: middle;
                animation: streakPulse 2.5s ease-in-out infinite;
            }
            .streak-hot {
                background: linear-gradient(135deg, rgba(255, 140, 0, 0.35), rgba(255, 80, 0, 0.2));
                border: 1px solid rgba(255, 170, 0, 0.85);
                color: #FFCC44;
                box-shadow: 0 0 8px rgba(255, 140, 0, 0.5), 0 0 20px rgba(255, 140, 0, 0.35), 0 0 40px rgba(255, 100, 0, 0.15);
                text-shadow: 0 0 8px rgba(255, 160, 0, 0.7);
            }
            .streak-super {
                background: linear-gradient(135deg, rgba(204, 255, 0, 0.35), rgba(150, 255, 0, 0.18));
                border: 1px solid rgba(204, 255, 0, 0.9);
                color: #CCFF00;
                box-shadow: 0 0 10px rgba(204, 255, 0, 0.6), 0 0 25px rgba(204, 255, 0, 0.4), 0 0 50px rgba(204, 255, 0, 0.15);
                text-shadow: 0 0 10px rgba(204, 255, 0, 0.8);
                animation: streakGlow 2s ease-in-out infinite;
            }
            @keyframes streakPulse {
                0%, 100% { opacity: 1; }
                50% { opacity: 0.8; }
            }
            @keyframes streakGlow {
                0%, 100% { box-shadow: 0 0 10px rgba(204, 255, 0, 0.6), 0 0 25px rgba(204, 255, 0, 0.4), 0 0 50px rgba(204, 255, 0, 0.15); }
                50% { box-shadow: 0 0 14px rgba(204, 255, 0, 0.8), 0 0 35px rgba(204, 255, 0, 0.55), 0 0 60px rgba(204, 255, 0, 0.25); }
            }
            </style>
            <table class="ladder-table"><tbody>
            """

            _, player_streaks = _fetch_category_player_matches(cat_id)

            for entry in ladder:
                pos = entry["position"]
                player_id = entry["player_id"]
                player = entry.get("players", {}) or {}
                name = f"{player.get('first_name', '')} {player.get('last_name', '')}"
                subcat = _get_subcat_label(pos, ranges)
                streak = player_streaks.get(player_id, 0)

                streak_html = ""
                if streak >= 3:
                    b_cls = "streak-super" if streak >= 5 else "streak-hot"
                    streak_html = f' <span class="streak-badge {b_cls}" title="🔥 Racha de {streak} victorias consecutivas">🔥 {streak}V</span>'

                if subcat and subcat != prev_subcat:
                    table_html += (
                        f'<tr class="subcat-row"><td colspan="2" style="padding:0;">'
                        f'<div class="subcat-header">'
                        f'<span class="line"></span>'
                        f'<span class="label">{subcat}</span>'
                        f'<span class="line"></span>'
                        f"</div></td></tr>"
                    )
                    prev_subcat = subcat
                    subcat_rank = 1
                else:
                    subcat_rank += 1

                badge_cls = _pos_class(subcat_rank)
                table_html += (
                    f'<tr data-player-id="{player_id}">'
                    f'<td><span class="pos-badge {badge_cls}">{pos}</span></td>'
                    f'<td><span class="player-name">{name}</span>{streak_html}</td>'
                    f"</tr>"
                )

            table_html += "</tbody></table>"

            component_val = _table_component(
                html_content=table_html, key=f"ladder_table_comp_{cat_id}"
            )
            if component_val:
                state_key = f"_last_ladder_click_{cat_id}"
                if st.session_state.get(state_key) != component_val:
                    st.session_state[state_key] = component_val
                    clicked_id = str(component_val).split("_")[0]
                    matched = next(
                        (e for e in ladder if e["player_id"] == clicked_id), None
                    )
                    if matched:
                        m_pos = matched["position"]
                        m_p = matched.get("players", {}) or {}
                        m_name = f"{m_p.get('first_name', '')} {m_p.get('last_name', '')}".strip()
                        m_subcat = _get_subcat_label(m_pos, ranges)
                        show_player_stats_modal(clicked_id, m_name, m_pos, m_subcat)

# ── Footer ────────────────────────────────────────────────────
st.markdown(
    """
<div style="text-align:center; margin-top:3rem; padding-bottom:2rem;">
    <p style="font-family:'Montserrat',sans-serif; font-size:0.6rem;
              color:rgba(255,255,255,0.2); letter-spacing:3px;">
        ESTABLECIDO 1974 · CLUB NAYAR CAMPESTRE
    </p>
</div>
""",
    unsafe_allow_html=True,
)
