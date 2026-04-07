import streamlit as st
import pandas as pd
import os
import streamlit.components.v1 as components
from components.dialogs import show_edit_player_dialog
from services.tournament_service import TournamentService

def render_registration_view():
    st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
    
    # 1. ENROLLMENT HERO SECTION (Inscribir Socio)
    with st.container(border=True):
        st.markdown(
            """
            <div style="text-align: center; margin-bottom: 1.5rem;">
                <h2 style="color: #CCFF00; font-family: 'Montserrat', sans-serif; letter-spacing: 2px;">INSCRIBIR SOCIO AL TORNEO</h2>
                <p style="opacity: 0.7;">Busca miembros existentes en el club para agregarlos a la competencia actual.</p>
            </div>
            """, 
            unsafe_allow_html=True
        )
        
        c_h1, c_h2, c_h3 = st.columns([1, 2, 1])
        with c_h2:
            all_members = TournamentService.get_all_club_players()
            
            # Filter members to only show those NOT already in the current tournament_players df
            registered_ids = st.session_state.players_df['ID_Jugador'].tolist() if 'ID_Jugador' in st.session_state.players_df.columns else []
            member_options = {f"{m['first_name']} {m['last_name']}": m['id'] for m in all_members if m['id'] not in registered_ids}
            
            selected_member = st.selectbox(
                "Buscar Socio en la Base del Club...",
                options=["Escribe el nombre del socio..."] + list(member_options.keys()),
                index=0,
                label_visibility="collapsed"
            )
            
            if selected_member != "Escribe el nombre del socio...":
                from components.dialogs import show_register_existing_player_dialog
                member_id = member_options[selected_member]
                show_register_existing_player_dialog(member_id)

    st.markdown("<br>", unsafe_allow_html=True)

    display_df = st.session_state.get('players_df', pd.DataFrame()).copy()
        
    if display_df.empty:
        st.info("No hay jugadores inscritos en este torneo. Usa el buscador de arriba para inscribir socios.", icon="🎾")
    else:
        st.markdown(f"### PARTICIPANTES INSCRITOS ({len(display_df)})")

        # Table Component setup
        component_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "custom_table_component")
        _table_component = components.declare_component(
            "custom_table_component",
            path=component_path
        )

        st.text_input("Filtrar por Nombre o Celular", placeholder="   Buscar en la lista actual...", label_visibility="collapsed", key="live_search_input")

        # Form Filters (Accordion)
        with st.expander("Filtros Avanzados"):
            all_cats, all_subcats = TournamentService.fetch_config_options()
            
            pills_options = all_cats + all_subcats + ["Singles", "Dobles", "Pagado", "Pendiente"]
            
            f_filters = st.pills(
                "Filtros de Tabla", 
                pills_options, 
                default=[], 
                selection_mode="multi",
                label_visibility="collapsed"
            )

        # Parse Unified Filters
        f_cat = [f for f in f_filters if f in all_cats]
        f_scat = [f for f in f_filters if f in all_subcats]
        f_format = [f for f in f_filters if f in ["Singles", "Dobles"]]
        f_pago = [f for f in f_filters if f in ["Pagado", "Pendiente"]]

        # Apply Pandas Masks
        if f_cat:
            display_df = display_df[display_df["Categoría"].isin(f_cat)]
            
        if f_scat:
            display_df = display_df[display_df["Subcategoría"].isin(f_scat)]
            
        if "Singles" in f_format and "Dobles" not in f_format:
            display_df = display_df[display_df["Singles"] == "Sí"]
        elif "Dobles" in f_format and "Singles" not in f_format:
            display_df = display_df[display_df["Dobles"] == "Sí"]
        elif "Singles" in f_format and "Dobles" in f_format:
            display_df = display_df[(display_df["Singles"] == "Sí") | (display_df["Dobles"] == "Sí")]
            
        if f_pago:
            display_df = display_df[display_df["Pago"].isin(f_pago)]

        def html_table_component(df):
            df_html = df.copy()
            if not df_html.empty:
                first_col = df_html.columns[0]
                df_html[first_col] = df_html.apply(
                    lambda row: f'<span class="row-id" data-idx="{row.name}" style="display:none;"></span>{row[first_col]}', 
                    axis=1
                )

            display_cols = [c for c in df_html.columns if c not in ["ID_Jugador", "ID_Registro", "ID_Pareja"]]
            table_html = df_html[display_cols].to_html(classes="luxury-wimbledon-table", index=False, escape=False)
            
            custom_css = """
            <style>
            @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&family=Inter:wght@400;500;600&display=swap');
            .table-scroll-container {
                max-height: 700px;
                overflow-x: auto;
                overflow-y: auto;
                border-radius: 12px;
                box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.2);
                margin-top: 1.5rem;
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(15px);
            }
            .table-scroll-container::-webkit-scrollbar { width: 8px; height: 8px; }
            .table-scroll-container::-webkit-scrollbar-track { background: rgba(0,0,0,0.1); border-radius: 8px; }
            .table-scroll-container::-webkit-scrollbar-thumb { background: #450084; border-radius: 8px; }
            
            .luxury-wimbledon-table {
                width: 100% !important;
                min-width: 1000px; 
                border-collapse: collapse; 
                border-spacing: 0;
                color: #ffffff; font-family: 'Montserrat', sans-serif;
                table-layout: auto !important;
            }
            .luxury-wimbledon-table thead th {
                position: sticky; top: 0; z-index: 10;
                background-color: rgba(69,0,132,0.95); color: #ffffff; font-family: 'Montserrat', sans-serif;
                padding: 1.2rem 1rem; text-align: left; border-bottom: 2px solid #ffffff;
                backdrop-filter: blur(5px); cursor: pointer; transition: background-color 0.2s;
            }
            .luxury-wimbledon-table thead th:hover { background-color: rgba(69,0,132,1); }
            .luxury-wimbledon-table tbody tr:hover { background-color: rgba(255,255,255,0.1); cursor: pointer; }
            .luxury-wimbledon-table td { padding: 1rem; border-bottom: 1px solid rgba(255, 255, 255, 0.1); }
            body { margin: 0; padding: 0; overflow: hidden; }
            </style>
            """
            
            full_html = f"{custom_css}<div class='table-scroll-container'>{table_html}</div>"
            
            MAX_IFRAME_HEIGHT = 750  
            TABLE_HEADER_HEIGHT = 50 
            ROW_HEIGHT = 55          
            BASE_PADDING = 50        
            calculated_height = min(MAX_IFRAME_HEIGHT, TABLE_HEADER_HEIGHT + (len(df_html) * ROW_HEIGHT) + BASE_PADDING)
            
            return _table_component(html_content=full_html, key="table_view", default_height=calculated_height)

        if display_df.empty:
            st.markdown("<br>", unsafe_allow_html=True)
            st.warning("No hay participantes con los filtros seleccionados.", icon="🎾")
        else:
            clicked_idx_str = html_table_component(display_df)
            if clicked_idx_str is not None:
                if "last_clicked_row" not in st.session_state or st.session_state.last_clicked_row != clicked_idx_str:
                    st.session_state.last_clicked_row = clicked_idx_str
                    idx = int(str(clicked_idx_str).split("_")[0])
                    show_edit_player_dialog(idx)

        # Bridge the parent "Filtrar por Nombre o Celular" to the iframe
        components.html(
            """
            <script>
            const doc = window.parent.document;
            const input = doc.querySelector('input[aria-label="Filtrar por Nombre o Celular"]');
            if (input) {
                input.addEventListener('keyup', () => {
                    const filter = input.value;
                    const iframes = doc.querySelectorAll('iframe');
                    iframes.forEach(iframe => {
                        try {
                            if (iframe.contentWindow && iframe.contentWindow.applyFilter) {
                                iframe.contentWindow.applyFilter(filter);
                            }
                        } catch(e) { } 
                    });
                });
            }
            </script>
            """,
            height=0
        )
