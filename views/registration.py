import streamlit as st
import pandas as pd
import os
import streamlit.components.v1 as components
from components.dialogs import show_add_player_dialog, show_edit_player_dialog

def render_registration_view():
    st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
    
    col_reg_left, col_reg_right = st.columns([1, 2])
    
    with col_reg_left:
        st.subheader("Acciones Rápidas")
        if st.button("AÑADIR NUEVO JUGADOR", use_container_width=True):
            show_add_player_dialog()
        
        # CSV Uploader Logic disguised as a button
        uploaded_file = st.file_uploader("IMPORTAR JUGADORES (CSV)", type=["csv"], label_visibility="collapsed")
        
        if uploaded_file is None:
            st.markdown("""
            <style>
            .block-container [data-testid="stFileUploader"] {
                margin-bottom: -15px !important;
                margin-top: 0px !important;
            }
            .block-container [data-testid="stFileUploader"] label,
            .block-container [data-testid="stFileUploader"] section + div {
                display: none !important;
            }
            .block-container [data-testid="stFileUploader"] section {
                background-color: #450084 !important;
                font-family: 'Montserrat', sans-serif !important;
                color: #ffffff !important; 
                border: 2px solid #ffffff !important;
                border-radius: 4px !important; 
                padding: 0 !important;
                width: 100%;
                height: 48px !important;
                min-height: 48px !important;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                position: relative;
            }
            .block-container [data-testid="stFileUploader"] section:hover {
                background-color: #ffffff !important;
                color: #450084 !important;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            }
            .block-container [data-testid="stFileUploader"] section > div,
            .block-container [data-testid="stFileUploader"] button {
                display: none !important;
            }
            .block-container [data-testid="stFileUploader"] section::before {
                content: "IMPORTAR DESDE EXCEL";
                font-family: 'Montserrat', sans-serif;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                font-size: 0.85rem;
                position: absolute;
                pointer-events: none;
            }
            .block-container [data-testid="stFileUploader"] section:hover::before {
                color: #450084 !important;
            }
            </style>
            """, unsafe_allow_html=True)
        
        st.button("GUARDAR JUGADORES", type="primary", use_container_width=True)
        
        st.markdown("<br>", unsafe_allow_html=True)
        st.info("Tip: Asegúrate de que todos los jugadores hayan firmado el waiver antes de agregarlos a la lista.")
        
    with col_reg_right:
        # Integration logic for uploaded csv
        if "processed_csv_files" not in st.session_state:
            st.session_state.processed_csv_files = []
            
        if uploaded_file is not None and uploaded_file.name not in st.session_state.processed_csv_files:
            df_uploaded = pd.read_csv(uploaded_file)
            st.session_state.players_df = pd.concat([st.session_state.players_df, df_uploaded], ignore_index=True)
            st.session_state.processed_csv_files.append(uploaded_file.name)
            st.rerun() # Refresh the page immediately so the top metric cards recalculate
            
        display_df = st.session_state.players_df.copy()
            
        st.subheader(f"LISTA DE JUGADORES ({len(display_df)})")

        # Declare the Official Bi-Directional Custom Component
        import streamlit.components.v1 as components
        import os
        
        # We need to compute an upward relative path since the component is still in the root folder.
        component_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "custom_table_component")
        _table_component = components.declare_component(
            "custom_table_component",
            path=component_path
        )

        st.text_input("Buscar Jugador", placeholder="   Buscar por nombre, apellido o celular...", label_visibility="collapsed", key="live_search_input")

        def html_table_component(df):
            # Inject the row index as a hidden span into the first column of each row
            df_html = df.copy()
            if not df_html.empty:
                first_col = df_html.columns[0]
                df_html[first_col] = df_html.apply(
                    lambda row: f'<span class="row-id" data-idx="{row.name}" style="display:none;"></span>{row[first_col]}', 
                    axis=1
                )

            # 1. Convert DF to HTML
            table_html = df_html.to_html(classes="luxury-wimbledon-table", index=False, escape=False)
            
            # 2. Extract the CSS from what we used to have globally
            custom_css = """
            <style>
            .luxury-wimbledon-table {
                width: 100%; border-collapse: separate; border-spacing: 0;
                background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(15px);
                border-radius: 12px; overflow: hidden; border: 1px solid rgba(255, 255, 255, 0.2);
                color: #ffffff; font-family: 'Inter', sans-serif; margin-top: 1.5rem;
                box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
            }
            .luxury-wimbledon-table thead th {
                background-color: rgba(69,0,132,0.85); color: #ffffff; font-family: 'Montserrat', sans-serif;
                font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px;
                padding: 1.2rem 1rem; text-align: left; border-bottom: 2px solid #450084;
                backdrop-filter: blur(5px); cursor: pointer; user-select: none; position: relative;
                transition: background-color 0.2s;
            }
            .luxury-wimbledon-table thead th:hover { background-color: rgba(69,0,132,1); }
            .luxury-wimbledon-table tbody tr { transition: all 0.2s ease; }
            .luxury-wimbledon-table tbody tr:hover { background-color: rgba(255,255,255,0.1); cursor: pointer; }
            .luxury-wimbledon-table td { padding: 1rem; font-size: 0.95rem; border-bottom: 1px solid rgba(255, 255, 255, 0.1); }
            .luxury-wimbledon-table tbody tr:last-child td { border-bottom: none; }
            /* Extra wrapper fix */
            body { margin: 0; padding: 0; overflow: hidden; }
            </style>
            """
            
            # Compile full HTML string to pass to the React bridge
            full_html = f"{custom_css}{table_html}"
            
            # Call the declared component. `html_content` gets serialized and passed to JS.
            return _table_component(html_content=full_html, key="table_view")

        # Call the component wrapper. It yields the string index of the clicked row.
        clicked_idx_str = html_table_component(display_df)
        
        # If the Custom Component returned a value (a user clicked), show the dialog!
        if clicked_idx_str is not None:
            # We must use session state to ensure the dialog stays open after interaction
            if "last_clicked_row" not in st.session_state or st.session_state.last_clicked_row != clicked_idx_str:
                st.session_state.last_clicked_row = clicked_idx_str
                idx = int(clicked_idx_str)
                show_edit_player_dialog(idx)

        # ---------------------------------------------------------
        # Bridge the parent "Buscar Jugador" to the iframe 
        # Since the iframe is isolated, we use a tiny script in the parent to pass the input value down.
        # ---------------------------------------------------------
        components.html(
            """
            <script>
            const doc = window.parent.document;
            const input = doc.querySelector('input[aria-label="Buscar Jugador"]');
            
            if (input) {
                input.addEventListener('keyup', () => {
                    const filter = input.value;
                    // Find our specific table iframe (usually the last rendered or biggest)
                    const iframes = doc.querySelectorAll('iframe');
                    iframes.forEach(iframe => {
                        try {
                            if (iframe.contentWindow && iframe.contentWindow.applyFilter) {
                                iframe.contentWindow.applyFilter(filter);
                            }
                        } catch(e) { } // Cross-origin errors for external iframes
                    });
                });
            }
            </script>
            """,
            height=0
        )
