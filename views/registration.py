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
        
        is_uploaded = uploaded_file is not None
        
        # Unconditionally disguise the file_uploader as a button, but gray it out if a file is already uploaded.
        css_state = f"""
        <style>
        .block-container [data-testid="stFileUploader"] {{
            margin-bottom: -15px !important;
            margin-top: 0px !important;
            pointer-events: {'none' if is_uploaded else 'auto'} !important;
        }}
        .block-container [data-testid="stFileUploader"] label,
        .block-container [data-testid="stFileUploader"] section + div {{
            display: none !important;
        }}
        .block-container [data-testid="stFileUploader"] section {{
            background-color: {'rgba(255, 255, 255, 0.1)' if is_uploaded else '#450084'} !important;
            font-family: 'Montserrat', sans-serif !important;
            color: {'rgba(255, 255, 255, 0.3)' if is_uploaded else '#ffffff'} !important; 
            border: 2px solid {'rgba(255, 255, 255, 0.2)' if is_uploaded else '#ffffff'} !important;
            border-radius: 4px !important; 
            padding: 0 !important;
            width: 100%;
            height: 48px !important;
            min-height: 48px !important;
            max-height: 48px !important;
            box-sizing: border-box !important;
            cursor: {'not-allowed' if is_uploaded else 'pointer'};
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            position: relative;
        }}
        {'' if is_uploaded else '''
        .block-container [data-testid="stFileUploader"] section:hover {
            background-color: #ffffff !important;
            color: #450084 !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
        }
        .block-container [data-testid="stFileUploader"] section:hover::before {
            color: #450084 !important;
        }
        '''}
        .block-container [data-testid="stFileUploader"] section > div,
        .block-container [data-testid="stFileUploader"] button {{
            display: none !important;
        }}
        .block-container [data-testid="stFileUploader"] section::before {{
            content: "{'JUGADORES IMPORTADOS' if is_uploaded else 'IMPORTAR DESDE EXCEL'}";
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.85rem;
            position: absolute;
            pointer-events: none;
            color: {'rgba(255, 255, 255, 0.4)' if is_uploaded else 'inherit'} !important;
        }}
        </style>
        """
        st.markdown(css_state, unsafe_allow_html=True)
        
        # Preemptively enforce exactly the new column order Requested by user before ANY display/export outputs 
        desired_cols = ["Nombre", "Apellido", "Subcategoría", "Categoría", "Pago", "Celular", "Singles", "Dobles"]
        for c in desired_cols:
             if c not in st.session_state.players_df.columns:
                 st.session_state.players_df[c] = "Sí" if c in ["Singles", "Dobles"] else ""
        st.session_state.players_df = st.session_state.players_df[desired_cols]

        csv_data = st.session_state.players_df.to_csv(index=False).encode('utf-8')
        st.download_button(
            label="GUARDAR JUGADORES",
            data=csv_data,
            file_name="jugadores_torneo.csv",
            mime="text/csv",
            type="primary",
            use_container_width=True
        )
        

        
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
            
        if display_df.empty:
            st.subheader(" ")
            st.warning("Para empezar, importa un archivo de Excel con la información de los jugadores que participarán en el torneo", icon="🎾")
        else:
            st.markdown(f"### LISTA DE JUGADORES ({len(display_df)})")
    
            # We need to compute an upward relative path since the component is still in the root folder.
            component_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), "custom_table_component")
            _table_component = components.declare_component(
                "custom_table_component",
                path=component_path
            )
    
            st.text_input("Buscar Jugador", placeholder="   Buscar por nombre, apellido o celular...", label_visibility="collapsed", key="live_search_input")
    
            # Form Filters (Accordion)
            with st.expander("Filtros"):
                f_filters = st.pills(
                    "Filtros de Tabla", 
                    ["Varonil", "Femenil", "Singles", "Dobles", "Pagado", "Pendiente"], 
                    default=[], 
                    selection_mode="multi",
                    label_visibility="collapsed"
                )

            # Parse Unified Filters
            f_cat = [f for f in f_filters if f in ["Varonil", "Femenil"]]
            f_format = [f for f in f_filters if f in ["Singles", "Dobles"]]
            f_pago = [f for f in f_filters if f in ["Pagado", "Pendiente"]]

            # Apply Pandas Masks
            if f_cat:
                display_df = display_df[display_df["Categoría"].isin(f_cat)]
                
            if "Singles" in f_format and "Dobles" not in f_format:
                display_df = display_df[display_df["Singles"] == "Sí"]
            elif "Dobles" in f_format and "Singles" not in f_format:
                display_df = display_df[display_df["Dobles"] == "Sí"]
            elif "Singles" in f_format and "Dobles" in f_format:
                display_df = display_df[(display_df["Singles"] == "Sí") | (display_df["Dobles"] == "Sí")]
                
            if f_pago:
                display_df = display_df[display_df["Pago"].isin(f_pago)]

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
                
                .table-scroll-container::-webkit-scrollbar {
                    width: 8px;
                    height: 8px;
                }
                .table-scroll-container::-webkit-scrollbar-track {
                    background: rgba(0,0,0,0.1);
                    border-radius: 8px;
                }
                .table-scroll-container::-webkit-scrollbar-thumb {
                    background: #450084;
                    border-radius: 8px;
                }
                
                .luxury-wimbledon-table {
                    min-width: 1200px !important; border-collapse: collapse; border-spacing: 0;
                    color: #ffffff; font-family: 'Montserrat', sans-serif;
                    table-layout: auto !important;
                }
                .luxury-wimbledon-table thead th {
                    position: sticky; top: 0; z-index: 10;
                    background-color: rgba(69,0,132,0.95); color: #ffffff; font-family: 'Montserrat', sans-serif;
                    font-size: 0.9rem; text-transform: uppercase; letter-spacing: 1px;
                    padding: 1.2rem 1rem; text-align: left; border-bottom: 2px solid #ffffff;
                    backdrop-filter: blur(5px); cursor: pointer; user-select: none;
                    transition: background-color 0.2s;
                    white-space: nowrap !important;
                    min-width: 120px !important;
                    word-break: keep-all !important;
                }
                .luxury-wimbledon-table thead th:hover { background-color: rgba(69,0,132,1); }
                .luxury-wimbledon-table tbody tr { transition: all 0.2s ease; }
                .luxury-wimbledon-table tbody tr:hover { background-color: rgba(255,255,255,0.1); cursor: pointer; }
                .luxury-wimbledon-table td { 
                    padding: 1rem; font-size: 0.95rem; font-weight: 400; 
                    border-bottom: 1px solid rgba(255, 255, 255, 0.1); 
                    white-space: nowrap !important;
                    min-width: 120px !important;
                    word-break: keep-all !important;
                }
                .luxury-wimbledon-table tbody tr:last-child td { border-bottom: none; }
                /* Extra wrapper fix */
                body { margin: 0; padding: 0; overflow: hidden; }
                </style>
                """
                
                # Compile full HTML string to pass to the React bridge
                full_html = f"{custom_css}<div class='table-scroll-container'>{table_html}</div>"
                
                # ---------------------------------------------------------------------
                # Dynamic Iframe Height Calculator
                # ---------------------------------------------------------------------
                # The custom component iframe needs to safely expand and contract based 
                # on the dataframe size. To avoid relying on buggy React height sensors,
                # we calculate the exact physical pixel height required natively in Python.
                # ---------------------------------------------------------------------
                MAX_IFRAME_HEIGHT = 750  # Prevent the table iframe from growing larger than 750 pixels
                TABLE_HEADER_HEIGHT = 50 # Physical pixel height of the CSS list headers
                ROW_HEIGHT = 55          # Average physical height of a single player row
                BASE_PADDING = 50        # Extra buffer padding for the container borders
                
                calculated_height = min(
                    MAX_IFRAME_HEIGHT, 
                    TABLE_HEADER_HEIGHT + (len(df_html) * ROW_HEIGHT) + BASE_PADDING
                )
                return _table_component(html_content=full_html, key="table_view", default_height=calculated_height)
    
            if display_df.empty:
                st.markdown("<br>", unsafe_allow_html=True)
                st.warning("Ups, parece ser que no hay nadie con esas condiciones", icon="🎾")
            else:
                # Call the component wrapper. It yields the string index of the clicked row.
                clicked_idx_str = html_table_component(display_df)
                
                # If the Custom Component returned a value (a user clicked), show the dialog!
                if clicked_idx_str is not None:
                    # We must use session state to ensure the dialog stays open after interaction
                    if "last_clicked_row" not in st.session_state or st.session_state.last_clicked_row != clicked_idx_str:
                        st.session_state.last_clicked_row = clicked_idx_str
                        # Extract the row index from the timestamped payload (e.g., "5_1734919293")
                        idx = int(str(clicked_idx_str).split("_")[0])
                        show_edit_player_dialog(idx)
    
            # ---------------------------------------------------------
            # Bridge the parent "Buscar Jugador" to the iframe 
            # Since the iframe is isolated, we use a tiny script in the parent to pass the input value down.
            # ---------------------------------------------------------
            components.html(
                """
                <script>
                const doc = window.parent.document;
                
                // 1. Live Search Bridge
                const input = doc.querySelector('input[aria-label="Buscar Jugador"]');
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

                // 2. Prevent accidental refresh/leave when data is loaded
                window.parent.onbeforeunload = function(e) {
                    const msg = 'Estás seguro que deseas salir sin guardar los cambios?';
                    e = e || window.parent.event;
                    if (e) {
                        e.returnValue = msg;
                    }
                    return msg;
                };
                </script>
                """,
                height=0
            )
