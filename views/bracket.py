import streamlit as st
import math

def get_next_power_of_2(n):
    if n <= 2: return 2
    return 2 ** math.ceil(math.log2(n))

def generate_bracket_svg(players, tournament_name):
    N = len(players)
    if N == 0:
        return ""
        
    pow2 = get_next_power_of_2(N)
    if pow2 < 4: pow2 = 4
    
    padded_players = list(players)
    while len(padded_players) < pow2:
        padded_players.append("BYE")
        
    half_index = pow2 // 2
    left_players = padded_players[:half_index]
    right_players = padded_players[half_index:]
    
    slot_width = 200
    col_width = 240
    row_height = 80
    center_gap = 350
    
    side_rounds = int(math.log2(half_index))
    
    W = (side_rounds * col_width * 2) + center_gap + (slot_width * 2)
    H = max(600, half_index * row_height)
    
    svg = f'''<svg width="{W}px" height="{H}px" viewBox="0 0 {W} {H}" xmlns="http://www.w3.org/2000/svg" style="background-color:#003319; font-family:'Montserrat', sans-serif; border-radius: 8px;">'''
    
    svg += f'''<text x="{W/2}" y="80" fill="#ffffff" font-size="32" font-weight="900" text-anchor="middle" letter-spacing="2">{tournament_name}</text>'''
    
    def draw_wing(wing_players, is_left):
        current_y = []
        nonlocal svg
        
        for i in range(half_index):
            y = (H / half_index) * i + (H / half_index) / 2
            current_y.append(y)
            
            x_text = 30 if is_left else W - 30
            text_anchor = "start" if is_left else "end"
            
            x_line_start = 30 if is_left else W - 30 - slot_width
            x_line_end = x_line_start + slot_width
            
            p_name = str(wing_players[i])
            f_size = "13" if len(p_name) > 20 else "15"
            color = "#80b398" if p_name == "BYE" else "#ffffff"
            
            # Top slot of the match -> above line. Bottom slot -> below line.
            y_text = y - 8 if i % 2 == 0 else y + 18
            
            svg += f'''<text x="{x_text}" y="{y_text}" fill="{color}" font-size="{f_size}" font-weight="bold" text-anchor="{text_anchor}">{p_name}</text>'''
            svg += f'''<line x1="{x_line_start}" y1="{y}" x2="{x_line_end}" y2="{y}" stroke="{color}" stroke-width="2" />'''
            
        round_ys = current_y
        
        for r in range(side_rounds):
            next_ys = []
            
            if is_left:
                x_vert = 30 + slot_width + r * col_width
                x_next_line_end = x_vert + col_width 
            else:
                x_vert = W - 30 - slot_width - r * col_width
                x_next_line_end = x_vert - col_width
                
            for i in range(0, len(round_ys), 2):
                y1 = round_ys[i]
                y2 = round_ys[i+1]
                ymid = (y1 + y2) / 2
                next_ys.append(ymid)
                
                svg += f'''<line x1="{x_vert}" y1="{y1}" x2="{x_vert}" y2="{y2}" stroke="#ffffff" stroke-width="2" />'''
                
                if r < side_rounds - 1:
                    svg += f'''<line x1="{x_vert}" y1="{ymid}" x2="{x_next_line_end}" y2="{ymid}" stroke="#ffffff" stroke-width="2" />'''
                
            round_ys = next_ys
            
        return round_ys[0], x_vert

    left_final_y, x_left_vert = draw_wing(left_players, True)
    right_final_y, x_right_vert = draw_wing(right_players, False)
    
    center_y = H / 2
    
    # Left bridging to center final slot
    x_left_final = x_left_vert
    svg += f'''<path d="M {x_left_final} {left_final_y} L {x_left_final + 40} {left_final_y} L {x_left_final + 40} {center_y} L {W/2 - 90} {center_y}" fill="none" stroke="#ffffff" stroke-width="2" />'''
    
    # Right bridging to center final slot
    x_right_final = x_right_vert
    svg += f'''<path d="M {x_right_final} {right_final_y} L {x_right_final - 40} {right_final_y} L {x_right_final - 40} {center_y} L {W/2 + 90} {center_y}" fill="none" stroke="#ffffff" stroke-width="2" />'''
    
    # Champion Center Slot
    svg += f'''<line x1="{W/2 - 90}" y1="{center_y}" x2="{W/2 + 90}" y2="{center_y}" stroke="#CCFF00" stroke-width="4" />'''
    svg += f'''<text x="{W/2}" y="{center_y + 40}" fill="#CCFF00" font-size="22" font-weight="900" text-anchor="middle" letter-spacing="4">CHAMPION</text>'''
    
    svg += "</svg>"
    return svg

def render_bracket_view(t_name):
    st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
    st.subheader("Llaves del Torneo")
    st.markdown("---")
    
    if "current_draw" not in st.session_state:
        st.info("Aún no has generado ningún Draw. Ve a la sección **02 GENERAR DRAW** primero.")
        return
        
    draw_data = st.session_state.current_draw
    f_cat = draw_data["filters"]["cat"]
    f_scat = draw_data["filters"]["scat"]
    f_fmt = draw_data["filters"]["fmt"]
    
    st.success(f"**Visualizando llave oficial para:** {f_cat} - {f_scat} ({f_fmt})")
    st.markdown("<br>", unsafe_allow_html=True)
    
    # 1. Isolate Seeds and Unseeded
    seeds = []
    unseeded = []
    
    for g_name, pts in draw_data["groups"].items():
        for p in pts:
            p_name = f"{p['Nombre']} {p['Apellido']}".strip()
            if p.get("is_seed"):
                seeds.append(p_name)
            else:
                unseeded.append(p_name)
                
    total_players = len(seeds) + len(unseeded)
    pow2 = get_next_power_of_2(total_players)
    if pow2 < 4: pow2 = 4
    
    # Pad unseeded with BYEs
    while len(seeds) + len(unseeded) < pow2:
        unseeded.append("BYE")
        
    # Official ATP/WTA Binary Sort Algorithm
    def generate_seed_tree(depth):
        if depth == 1: return [0, 1]
        prev = generate_seed_tree(depth - 1)
        size = 2 ** depth
        res = []
        for val in prev:
            res.append(val)
            res.append(size - 1 - val)
        return res
        
    tree_positions = generate_seed_tree(int(math.log2(pow2)))
    
    bracket_slots = [None] * pow2
    
    # Map Seeds to highest priority endpoints
    for i, s_name in enumerate(seeds):
        pos = tree_positions[i]
        bracket_slots[pos] = "SEED " + s_name
        
    # Map Unseeded securely (prioritizing BYEs hitting the Top Seeds first)
    unseeded.sort(key=lambda x: x != "BYE")
    un_idx = 0
    for pos in tree_positions:
        if bracket_slots[pos] is None:
            bracket_slots[pos] = unseeded[un_idx]
            un_idx += 1
            
    if len(bracket_slots) == 0:
        st.warning("El draw actual está vacío.")
        return
        
    svg_html = generate_bracket_svg(bracket_slots, t_name)
    
    # Inject pure HTML
    st.markdown(
        f"""
        <div style="width: 100%; overflow-x: auto; border: 1px solid rgba(255,255,255,0.1); border-radius: 8px;">
            {svg_html}
        </div>
        <br><br>
        """,
        unsafe_allow_html=True
    )
