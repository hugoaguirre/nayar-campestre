import streamlit as st
import pandas as pd
import random

def render_draw_view():
    st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
    st.subheader("Lógica de Grupos")
    
    # 1. Filters
    c1, c2, c3 = st.columns(3)
    with c1:
        cat_select = st.selectbox("Categoría", ["Varonil", "Femenil"])
    with c2:
        scat_select = st.selectbox("Subcategoría", ["AA", "A", "B", "C", "D", "Mini-Tenis", "8-10 años"])
    with c3:
        format_select = st.selectbox("Formato", ["Singles", "Dobles"])
        
    st.markdown("---")
    
    # 2. Filter Players
    if "players_df" not in st.session_state or st.session_state.players_df.empty:
        st.warning("No hay jugadores registrados aún. Ve al tab de REGISTRO.")
        return
        
    df = st.session_state.players_df.copy()
    
    mask = (df["Categoría"] == cat_select) & (df["Subcategoría"] == scat_select)
    if format_select == "Singles":
        mask = mask & (df["Singles"] == "Sí")
    else:
        mask = mask & (df["Dobles"] == "Sí")
        
    eligible_df = df[mask].copy()
    
    # 3. Doubles Deduplication
    if format_select == "Dobles":
        def get_full_name(r):
            return f"{r['Nombre']} {r['Apellido']}".strip()
            
        pago_dict = {get_full_name(r): str(r.get('Pago', 'Pendiente')).strip() for _, r in df.iterrows()}
        
        def combine_pair(row):
            p1 = get_full_name(row)
            p2 = str(row.get("Pareja de dobles", "")).strip()
            p1_pago = str(row.get("Pago", "Pendiente")).strip()
            
            if p2:
                 key = " | ".join(sorted([p1, p2]))
                 row["Nombre"] = f"{p1} / {p2}"
                 
                 p2_pago = pago_dict.get(p2, "Pendiente")
                 row["Pago"] = f"{p1_pago} / {p2_pago}"
                 
                 row["Apellido"] = "" 
                 row["pair_key"] = key
            else:
                 row["pair_key"] = p1
            return row
            
        eligible_df = eligible_df.apply(combine_pair, axis=1)
        eligible_df = eligible_df.drop_duplicates(subset=["pair_key"]).drop(columns=["pair_key"])
        
    total_players = len(eligible_df)
    
    if total_players == 0:
        st.info("No hay jugadores que cumplan con estos filtros.")
        return
        
    # 4. Setup Groups
    c4, c5 = st.columns([1, 1])
    with c4:
        st.markdown("<div style='margin-top: 1.95rem;'></div>", unsafe_allow_html=True)
        lbl_text = "**Total de Parejas Elegibles:**" if format_select == "Dobles" else "**Total de Jugadores Elegibles:**"
        st.info(f"{lbl_text} {total_players}")
    with c5:
        default_groups = max(1, total_players // 3)
        num_groups = st.number_input("Cantidad de Grupos (M)", min_value=1, max_value=total_players, value=default_groups)
    
    # 4. Manual Seeding Table
    st.markdown("### Selección de Cabezas de Serie (Seeds)")
    st.caption(f"Selecciona hasta {num_groups} jugadores manuales que liderarán cada grupo.")
    
    if format_select == "Dobles":
        editable_df = eligible_df[["Nombre", "Pago"]].copy()
        editable_df["Seleccionar Seed"] = False
        editable_df = editable_df[["Seleccionar Seed", "Nombre", "Pago"]]
        
        col_cfg = {
            "Seleccionar Seed": st.column_config.CheckboxColumn(
                "Cabeza de Serie", help="Selecciona los cabezas de serie", default=False, width="small"
            ),
            "Nombre": st.column_config.TextColumn("Pareja", width="large")
        }
        dis_cols = ["Nombre", "Pago"]
    else:
        editable_df = eligible_df[["Nombre", "Apellido", "Pago"]].copy()
        editable_df["Seleccionar Seed"] = False
        editable_df = editable_df[["Seleccionar Seed", "Nombre", "Apellido", "Pago"]]
        
        col_cfg = {
            "Seleccionar Seed": st.column_config.CheckboxColumn(
                "Cabeza de Serie", help="Selecciona los cabezas de serie", default=False, width="small"
            ),
            "Nombre": st.column_config.TextColumn(width="large"),
            "Apellido": st.column_config.TextColumn(width="large"),
        }
        dis_cols = ["Nombre", "Apellido", "Pago"]
    
    editor_key = f"seed_editor_{cat_select}_{scat_select}_{format_select}"
    
    edited_df = st.data_editor(
        editable_df,
        column_config=col_cfg,
        disabled=dis_cols,
        hide_index=True,
        use_container_width=True,
        key=editor_key
    )
    
    selected_indices = edited_df[edited_df["Seleccionar Seed"]].index
    num_seeds = len(selected_indices)
    
    if num_seeds > num_groups:
        st.error(f"¡Atención! Has seleccionado {num_seeds} seeds, pero solo hay {num_groups} grupos. Desmarca {num_seeds - num_groups}.")
        valid_seeds = False
    else:
        st.success(f"{num_seeds} de {num_groups} posibles seeds seleccionados.")
        valid_seeds = True
        
    st.markdown("<br>", unsafe_allow_html=True)
    # 5. GENERATE DRAW
    if st.button("SORTEAR Y CREAR GRUPOS", type="primary", use_container_width=True, disabled=not valid_seeds):
        seeds_df = eligible_df.loc[selected_indices]
        unseeded_df = eligible_df.drop(selected_indices)
        
        seeds_list = seeds_df.to_dict('records')
        unseeded_list = unseeded_df.to_dict('records')
        random.shuffle(unseeded_list)
        
        groups = {f"Grupo {i+1}": [] for i in range(num_groups)}
        
        # Place seeds first
        for i, seed in enumerate(seeds_list):
            groups[f"Grupo {i+1}"].append({**seed, "is_seed": True})
            
        # Distribute unseeded round-robin balancing sizes
        for p in unseeded_list:
            min_size = min(len(g) for g in groups.values())
            target_group = next(k for k, v in groups.items() if len(v) == min_size)
            groups[target_group].append({**p, "is_seed": False})
            
        st.session_state.current_draw = {
            "filters": {"cat": cat_select, "scat": scat_select, "fmt": format_select},
            "groups": groups
        }
        st.rerun()
        
    st.markdown("<br><br>", unsafe_allow_html=True)
    
    # 6. VISTA PREVIA (Accordion)
    has_draw = "current_draw" in st.session_state
    
    with st.expander("VISTA PREVIA DE GRUPOS", expanded=has_draw):
        if not has_draw:
            st.info("Configura la lógica y haz clic en 'Sortear' para visualizar los grupos.")
        else:
            draw_data = st.session_state.current_draw
            f_cat = draw_data["filters"]["cat"]
            f_scat = draw_data["filters"]["scat"]
            f_fmt = draw_data["filters"]["fmt"]
            
            st.markdown(f"#### Resultados: {f_cat} - {f_scat} ({f_fmt})")
            st.markdown("<br>", unsafe_allow_html=True)
            
            # Use responsive columns to display groups side-by-side if there are multiple
            cols = st.columns(2)
            for idx, (g_name, players) in enumerate(draw_data["groups"].items()):
                with cols[idx % 2]:
                    st.markdown(f"<h5 style='color: #ffffff; text-shadow: 0 0 10px rgba(255,255,255,0.4);'>{g_name}</h5>", unsafe_allow_html=True)
                    for p in players:
                        seed_badge = "<strong style='color:#CCFF00; font-size:0.75rem; font-family: \"Montserrat\", sans-serif; font-style: italic; font-weight: bold; margin-right: 4px;'>SEED  </strong>" if p.get("is_seed") else ""
                        pago_val = str(p.get("Pago", "")).strip()
                        if "/" in pago_val:
                            parts = pago_val.split("/")
                            b1 = "🟢" if "Pagado" in parts[0] else "🔴"
                            b2 = "🟢" if "Pagado" in parts[1] else "🔴"
                            pago_badge = f"{b1} / {b2}"
                        else:
                            pago_badge = "🟢" if pago_val == "Pagado" else "🔴"
                            
                        p_name = f"{p['Nombre']} {p['Apellido']}".strip()
                        st.markdown(f"""
                        <div class="player-card">
                            <span>{seed_badge}{p_name}</span>
                            <span title='Estado de pago'>{pago_badge}</span>
                        </div>
                        """, unsafe_allow_html=True)
                    st.markdown("<br>", unsafe_allow_html=True)
