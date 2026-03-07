import streamlit as st
import pandas as pd
from PIL import Image
# from database import get_supabase_client
# from logic import shuffle_players, generate_groups
# from pdf_generator import export_tournament_pdf

# --- 1. PAGE CONFIG & THEME INJECTION ---
st.set_page_config(
    page_title="Club Nayar Campestre - Tenis | Manejador de Torneos", 
    layout="wide",
    initial_sidebar_state="expanded"
)

def apply_wimbledon_ui():
    st.markdown(
        """
    <style>
        /* 1. Global Modern Typography */
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@700;800;900&family=Inter:wght@400;500;600&display=swap');
        
        /* Dark Wimbledon Theme Base */
        .stApp {
            background-color: #004422; /* Deep Wimbledon Green */
            background-image: radial-gradient(circle at 20% 30%, #006633 0%, #004422 100%);
            color: #f8fafc;
            font-family: 'Inter', sans-serif;
        }
        
        /* Hide Default Streamlit Elements (but preserve the header containing the Sidebar toggle) */
        #MainMenu {visibility: hidden;}
        footer {visibility: hidden;}
        
        /* Make header transparent instead of completely hidden to keep the expand/collapse button */
        header[data-testid="stHeader"] {
            background-color: transparent !important;
            background-image: none !important;
            border: none !important;
        }

        /* Hide the Deploy button entirely */
        [data-testid="stAppDeploy"] {
            display: none !important;
        }

        /* Style the chevron toggle to be pure white */
        [data-testid="stSidebarCollapseButton"] svg {
            color: #ffffff !important;
            fill: #ffffff !important;
        }
        
        /* Typography Imports: Distinct font for titles */
        @import url('https://fonts.googleapis.com/css2?family=Tilt+Warp&display=swap');

        /* Top Padding Adjustment */
        .block-container {
            padding-top: 2rem !important;
            padding-bottom: 2rem !important;
        }

        /* 2. Headers & Titles */
        h1, h2, h3, .hero-title {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: -1px;
            color: #ffffff;
            margin-bottom: 15px;
        }
        
        .hero-title {
            font-family: 'Tilt Warp', sans-serif !important;
            font-weight: 900 !important;
            letter-spacing: -1px !important;
            color: #ffffff;
            text-shadow: 0 4px 10px rgba(0, 0, 0, 0.5); /* Solid shadow, no neon */
        }

        /* 3. Wimbledon Action Buttons */
        div[data-testid="stButton"],
        div[data-testid="stButton"] > button,
        div.stButton > button,
        div[data-testid="stBaseButton-secondary"] {
            width: 100% !important;
            display: block !important;
        }
        
        div.stButton > button {
            background-color: #450084 !important; /* Regal Purple */
            color: #ffffff !important; 
            border: 2px solid #ffffff !important;
            border-radius: 4px !important; 
            padding: 0.75rem 1.5rem !important;
            transition: all 0.3s ease;
            box-shadow: none !important;
        }
        
        div.stButton > button p {
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 700 !important;
            font-size: 0.85rem !important;
            text-transform: uppercase !important;
            letter-spacing: 1px !important;
            margin: 0 !important;
            color: #ffffff !important; 
        }

        div.stButton > button:hover {
            background-color: #ffffff !important;
            color: #450084 !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4) !important;
        }
        
        div.stButton > button:hover p {
            color: #450084 !important;
        }

        /* 4. Elegant Dashboard Cards */
        [data-testid="stHorizontalBlock"] {
            align-items: stretch !important;
        }
        
        [data-testid="stColumn"] [data-testid="stVerticalBlock"]:has(.glass-card-anchor) {
            background: rgba(255, 255, 255, 0.08); /* Frosted Glass */
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.15); 
            border-left: 4px solid #450084; /* Purple Accent Border */
            padding: 1.5rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3);
            height: 100% !important;
            display: flex !important;
            flex-direction: column !important;
        }
        
        .stMain > div > [data-testid="stVerticalBlock"]:has(.glass-card-anchor) {
            background: transparent !important;
            border: none !important;
            box-shadow: none !important;
            backdrop-filter: none !important;
        }
        .glass-card-anchor { display: none; }
        
        .player-card {
             background: rgba(255, 255, 255, 0.05);
             border: 1px solid rgba(255, 255, 255, 0.1);
             padding: 1rem;
             border-radius: 6px;
             margin-bottom: 0.5rem;
             display: flex;
             justify-content: space-between;
             align-items: center;
        }
        .player-card strong {
             color: #ffffff;
             font-family: 'Montserrat', sans-serif;
        }

        /* 5. Custom Tab Navigation */
        button[data-baseweb="tab"] {
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 700 !important;
            text-transform: uppercase !important;
            letter-spacing: 1.5px !important;
            color: rgba(255,255,255,0.6) !important;
            background: transparent !important;
            border: none !important;
        }
        button[data-baseweb="tab"] p,
        button[data-baseweb="tab"] span {
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 700 !important;
            text-transform: uppercase !important;
            letter-spacing: 1.5px !important;
            color: inherit !important;
        }
        button[aria-selected="true"] {
            color: #ffffff !important;
        }
        
        /* Remove default empty boxes and lines below tabs */
        div[role="tablist"] {
            border-bottom: none !important;
        }
        div[data-baseweb="tab-border"] {
            display: none !important;
        }
        
        /* Restore animated highlight indicator for sweeping transition */
        div[data-baseweb="tab-highlight"] {
            background-color: #ffffff !important;
            height: 2px !important;
            bottom: 0px !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }
        
        /* Ensure internal button containers don't conflict with animated border */
        div.stTabs [role="tablist"] button > div {
            border-bottom: none !important;
        }
        
        /* 6. Metrics Styling */
        [data-testid="stMetric"] {
            background: rgba(255, 255, 255, 0.08); /* Frosted Glass */
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.15); 
            padding: 1rem;
            border-radius: 8px;
            border-top: 3px solid #450084; /* Purple Accent */
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.3);
            height: 140px !important;
            display: flex !important;
            flex-direction: column !important;
            justify-content: flex-start !important;
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1) !important;
        }

        [data-testid="stMetric"]:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.12);
            border-color: rgba(255, 255, 255, 0.3);
            border-top-color: #450084; /* Keep the purple accent during hover */
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.3), 0 0 15px rgba(255, 255, 255, 0.2);
        }
        [data-testid="stMetric"] label {
            color: rgba(255,255,255,0.8) !important; 
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.8rem;
        }
        [data-testid="stMetric"] div[data-testid="stMetricValue"] {
            color: #ffffff !important;
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            font-size: 2rem;
        }
        
        /* 7. Highlight Dataframes & Sidebar */
        .stDataFrame {
            border: 1px solid rgba(255, 255, 255, 0.15); 
            border-radius: 8px;
            overflow: hidden;
        }
        
        [data-testid="stSidebar"] {
            background-color: #003319 !important; /* Richer Dark Green */
            border-right: 1px solid rgba(255,255,255,0.1) !important;
        }
        
        /* 8. Widgets & Inputs */
        [data-testid="stWidgetLabel"] p {
            font-size: 1.15rem !important;
            font-weight: 700 !important;
            color: #ffffff !important;
            margin-bottom: 0.5rem !important;
        }
        
        [data-testid="stTextInput"] div[data-baseweb="input"] {
            background-color: #ffffff !important;
            border-radius: 6px !important;
            border: 1px solid transparent !important;
            transition: all 0.2s ease-in-out !important;
        }
        
        [data-testid="stTextInput"] div[data-baseweb="input"]:focus-within,
        [data-testid="stTextInput"] div[data-baseweb="input"]:hover {
            border-color: #450084 !important;
            box-shadow: 0 0 0 2px rgba(69,0,132,0.4) !important;
        }
        
        [data-testid="stTextInput"] input {
            color: #450084 !important; /* Regal Purple Text */
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 700 !important;
            background-color: transparent !important;
        }
        
        [data-testid="stSidebar"] [data-testid="stFileUploader"] section {
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
        
        [data-testid="stSidebar"] [data-testid="stFileUploader"] section:hover {
            background-color: #ffffff !important;
            color: #450084 !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
        }
        
        [data-testid="stSidebar"] [data-testid="stFileUploader"] section > div,
        [data-testid="stSidebar"] [data-testid="stFileUploader"] button {
            display: none !important;
        }
        
        [data-testid="stSidebar"] [data-testid="stFileUploader"] section::before {
            content: "SELECCIONAR IMAGEN";
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.85rem;
            position: absolute;
            pointer-events: none;
        }
        
        [data-testid="stSidebar"] [data-testid="stFileUploader"] section:hover::before {
            color: #450084 !important;
        }
        
        [data-testid="stSidebar"] [data-testid="stFileUploader"] section + div {
            display: none !important;
        }
        
        /* 9. Luxurious Wimbledon Table & Live Search */
        /* Aggressively target ALL base web inputs entirely to force pure white backgrounds */
        [data-testid="stTextInput"] div[data-baseweb="input"],
        [data-testid="stTextInput"] div[data-baseweb="input"] > div,
        div.stKeyup div[data-baseweb="input"],
        div.stKeyup div[data-baseweb="input"] > div {
            background-color: #ffffff !important;
            background: #ffffff !important;
        }

        /* The Live Search Pill Container */
        div.stKeyup > div > div {
            border-radius: 50px !important;
            border: 2px solid #450084 !important;
            background-color: #ffffff !important; 
            padding: 0.2rem 1rem !important;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2) !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }
        div.stKeyup > div > div:focus-within {
            box-shadow: 0 6px 20px rgba(69,0,132,0.6) !important;
            transform: translateY(-2px);
            border-color: #ffffff !important;
        }
        
        /* The Actual Input Text */
        div.stKeyup input,
        [data-testid="stTextInput"] input {
            color: #450084 !important; /* Regal Purple Text */
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 700 !important;
            background-color: transparent !important;
            -webkit-text-fill-color: #450084 !important;
        }

        /* Placeholder Styling */
        div.stKeyup input::placeholder,
        [data-testid="stTextInput"] input::placeholder {
            color: rgba(69, 0, 132, 0.4) !important; /* Opaque Regal Purple */
            -webkit-text-fill-color: rgba(69, 0, 132, 0.4) !important;
            font-style: italic !important;
            font-weight: 500 !important;
            transition: opacity 0.2s ease-in-out !important;
        }

        /* Hide placeholder on focus */
        div.stKeyup input:focus::placeholder,
        [data-testid="stTextInput"] input:focus::placeholder {
            opacity: 0 !important;
            color: transparent !important;
            -webkit-text-fill-color: transparent !important;
        }

        /* 10. Wimbledon Selectbox (Dropdowns) */
        /* Main Selectbox Container */
        div[data-testid="stSelectbox"] [data-baseweb="select"],
        div[data-testid="stSelectbox"] [data-baseweb="select"] > div {
            background-color: #ffffff !important;
            border-radius: 6px !important;
            border: 1px solid transparent !important;
            transition: all 0.2s ease-in-out !important;
        }
        div[data-testid="stSelectbox"] [data-baseweb="select"]:focus-within {
            border-color: #450084 !important;
            box-shadow: 0 0 0 2px rgba(69,0,132,0.4) !important;
        }
        /* Selectbox Text & Icon */
        div[data-testid="stSelectbox"] [data-baseweb="select"] div {
            color: #450084 !important;
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 700 !important;
            background-color: transparent !important;
        }
        div[data-testid="stSelectbox"] [data-baseweb="select"] svg {
            fill: #450084 !important;
        }
        /* Dropdown Options Popup Container */
        div[data-baseweb="popover"] {
            background-color: #ffffff !important;
            border-radius: 6px !important;
            border: 1px solid rgba(69,0,132,0.2) !important;
            box-shadow: 0 8px 24px rgba(0,0,0,0.15) !important;
            overflow: hidden !important;
        }
        ul[role="listbox"] {
            background-color: #ffffff !important;
            padding: 0 !important;
        }
        /* Individual Dropdown Options */
        li[role="option"] {
            background-color: #ffffff !important;
            color: #450084 !important;
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 600 !important;
            padding: 0.75rem 1rem !important;
            border-bottom: 1px solid rgba(69,0,132,0.05) !important;
            transition: background-color 0.2s ease !important;
        }
        li[role="option"]:last-child {
            border-bottom: none !important;
        }
        li[role="option"]:hover, 
        li[role="option"][aria-selected="true"] {
            background-color: #450084 !important; /* Royal Purple hover */
            color: #ffffff !important;
        }
        
        .luxury-wimbledon-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: rgba(255, 255, 255, 0.05); /* Frosted Glass */
            backdrop-filter: blur(15px);
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #ffffff;
            font-family: 'Inter', sans-serif;
            margin-top: 1.5rem;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
        }
        .luxury-wimbledon-table thead th {
            background-color: rgba(69,0,132,0.85) !important; /* Semi-transparent Purple */
            color: #ffffff;
            font-family: 'Montserrat', sans-serif;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 1.2rem 1rem;
            text-align: left;
            border-bottom: 2px solid #450084;
            backdrop-filter: blur(5px);
            cursor: pointer;
            user-select: none;
            position: relative;
            transition: background-color 0.2s;
        }
        .luxury-wimbledon-table thead th:hover {
            background-color: rgba(69,0,132,1) !important;
        }
        .luxury-wimbledon-table thead th::after {
            content: '↕';
            position: absolute;
            right: 10px;
            opacity: 0.3;
            font-size: 1rem;
        }
        .luxury-wimbledon-table thead th.sort-asc::after {
            content: '↑';
            opacity: 1;
            color: #00ff88;
        }
        .luxury-wimbledon-table thead th.sort-desc::after {
            content: '↓';
            opacity: 1;
            color: #00ff88;
        }
        .luxury-wimbledon-table tbody tr {
            transition: all 0.2s ease;
        }
        .luxury-wimbledon-table tbody tr:hover {
            background-color: rgba(255,255,255,0.1) !important; 
            cursor: pointer;
        }
        .luxury-wimbledon-table td {
            padding: 1rem;
            font-size: 0.95rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .luxury-wimbledon-table tbody tr:last-child td {
            border-bottom: none;
        }
    </style>
    """,
        unsafe_allow_html=True,
    )


apply_wimbledon_ui()

# --- 2. DYNAMIC SIDEBAR (Admin Branding) ---
with st.sidebar:
    st.markdown("### CONFIGURACION")
    t_name = st.text_input("Nombre del Torneo", "KIA OPEN 2026")
    st.divider()
    l_logo = st.file_uploader("Patrocinador Izquierdo (Nayar)", type=["png", "jpg"])
    r_logo = st.file_uploader("Patrocinador Derecho (Kia)", type=["png", "jpg"])
    st.divider()
    st.caption("Donación por Hugo Aguirre | Version 1.0")

# --- 3. THE "COURTIX" HERO HEADER ---
col_logo_l, col_title, col_logo_r = st.columns([1, 4, 1])
with col_logo_l:
    if l_logo:
        st.image(l_logo, width=100)
with col_title:
    # Inject Google Font exactly where it's used to avoid Streamlit sanitizing it from global CSS
    st.markdown(
        '<link href="https://fonts.googleapis.com/css2?family=Tilt+Warp&display=swap" rel="stylesheet">',
        unsafe_allow_html=True
    )
    
    # Explicitly set 0 blur on initial load to avoid flashing or default blurring
    # Replaced 'transition: all' with explicit properties to stop other Streamlit CSS (like backgrounds) from "tilting" or easing unexpectedly
    st.markdown(
        f'<h1 id="main-hero" class="hero-title" style="font-family: \'Tilt Warp\', sans-serif !important; font-size: 100px; text-align: center; filter: blur(0px); opacity: 1; transform: scale(1); transition: filter 0.1s ease-out, opacity 0.1s ease-out, transform 0.1s ease-out;">{t_name}</h1>',
        unsafe_allow_html=True,
    )
    
    # Inject JavaScript to dynamically detect scrolling no matter how the sidebar shifts the containers
    import streamlit.components.v1 as components
    components.html(
        """
        <script>
            const doc = window.parent.document;
            let ticking = false;
            
            function applyEffects() {
                // To combad Streamlit DOM changes, find the maximum scroll depth of ANY element on screen
                let maxScroll = doc.documentElement.scrollTop || doc.body.scrollTop || 0;
                
                // Also check typical Streamlit container names and all generic scrollable divs
                const containers = doc.querySelectorAll('.main, section, div');
                containers.forEach(c => {
                    if (c && c.scrollTop > maxScroll) maxScroll = c.scrollTop;
                });
                
                const blurValue = Math.min(maxScroll / 20, 10);
                const opacityValue = Math.max(1 - (maxScroll / 150), 0.2);
                const scaleValue = Math.max(1 - (maxScroll / 700), 0.90);
                
                const titles = doc.querySelectorAll('.hero-title');
                titles.forEach(el => {
                    el.style.filter = `blur(${blurValue}px)`;
                    el.style.opacity = `${opacityValue}`;
                    el.style.transform = `scale(${scaleValue})`;
                });
            }

            // Fire multiple times during load to ensure Streamlit's asynchronous renders are caught at blur(0)
            applyEffects();
            setTimeout(applyEffects, 100);
            setTimeout(applyEffects, 500);

            // Listen to scroll events during the capture phase, which intercepts scrolling inside any parent element.
            // This prevents the listener from breaking when the sidebar opens/closes
            window.parent.addEventListener('scroll', function(e) {
                if (!ticking) {
                    window.requestAnimationFrame(function() {
                        applyEffects();
                        ticking = false;
                    });
                    ticking = true;
                }
            }, true);
        </script>
        """,
        height=0,
    )

with col_logo_r:
    if r_logo:
        st.image(r_logo, width=100)

st.divider()

# --- 4. DASHBOARD METRICS ---
if "players_df" not in st.session_state:
    st.session_state.players_df = pd.DataFrame(
        {
            "Categoría": ["Infantil", "Infantil", "Infantil", "Infantil"],
            "Nombre": ["Sara", "Diego", "Mariel", "Amelí"],
            "Apellido": ["Alexandra", "Manzano", "Lozano", "Chatelet"],
            "Celular": ["3111234567", "3117654321", "3119876543", "3114567890"],
            "Pago": ["Confirmado", "Confirmado", "Pendiente", "Confirmado"]
        }
    )

_df = st.session_state.players_df
total_players = len(_df)
count_f = len(_df[_df['Categoría'].str.upper() == 'FEMENIL'])
count_i = len(_df[_df['Categoría'].str.upper() == 'INFANTIL'])
count_v = len(_df[~_df['Categoría'].str.upper().isin(['FEMENIL', 'INFANTIL'])])

count_pago_confirmado = len(_df[_df['Pago'].str.upper() == 'CONFIRMADO'])
count_pago_pendiente = len(_df[_df['Pago'].str.upper() == 'PENDIENTE'])

m1, m2, m3, m4 = st.columns(4)
m1.metric(label="Jugadores Registrados", value=str(total_players), delta=f"Varonil: {count_v} Femenil: {count_f} Infantil: {count_i}", delta_color="normal")
m2.metric(label="Pagos Confirmados", value=str(count_pago_confirmado), delta=None)
m3.metric(label="Pagos Pendientes", value=str(count_pago_pendiente), delta=None, delta_color="inverse")
m4.metric(label="Partidos Próximos", value="16", delta=None)

st.markdown("<br>", unsafe_allow_html=True)

@st.dialog("NUEVO JUGADOR")
def show_add_player_dialog():
    st.markdown("### Datos del Jugador")
    c1, c2 = st.columns(2)
    with c1:
        f_name = st.text_input("Nombre(s)", placeholder="Ej. Roger")
        f_cat = st.selectbox("Categoría", ["Varonil", "Femenil", "Infantil"])
        f_scat = st.selectbox("Subcategoría", ["AA", "A", "B", "C", "D"])
    with c2:
        f_last = st.text_input("Apellido(s)", placeholder="Ej. Federer")
        f_phone = st.text_input("Celular", placeholder="Ej. 311...")
        f_infantil = st.toggle("Infantil", value=False)
    
    f_pago = st.selectbox("Estado de Pago", ["Confirmado", "Pendiente"])
    
    # Inject JavaScript to prevent default Streamlit auto-focusing on the first text input
    import streamlit.components.v1 as components
    components.html(
        """
        <script>
            const doc = window.parent.document;
            // Blur the active element slightly after the modal renders to override Streamlit's focus
            setTimeout(() => {
                if (doc.activeElement) {
                    doc.activeElement.blur();
                }
            }, 50);
            setTimeout(() => {
                if (doc.activeElement) {
                    doc.activeElement.blur();
                }
            }, 150);
        </script>
        """,
        height=0,
    )
    
    st.markdown("<br>", unsafe_allow_html=True)
    if st.button("GUARDAR", type="primary", use_container_width=True):
        if f_name and f_last and f_phone:
            new_player = pd.DataFrame([{
                "Categoría": f_cat,
                "SubCategoría": f_scat,
                "Nombre": f_name,
                "Apellido": f_last,
                "Celular": f_phone,
                "Pago": f_pago,
                "Infantil": f_infantil
            }])
            st.session_state.players_df = pd.concat([st.session_state.players_df, new_player], ignore_index=True)
            st.rerun()
        else:
            st.error("Por favor llena todos los campos.")

# --- 5. MAIN NAVIGATION ---
tab_reg, tab_draw, tab_print = st.tabs(
    ["01 REGISTRO", "02 GENERAR DRAW", "03 EXPORTAR & IMPRIMIR"]
)

with tab_reg:
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
            
        display_df = st.session_state.players_df
            
        st.subheader(f"LISTA DE JUGADORES ({len(display_df)})")

        st.text_input("Buscar Jugador", placeholder="   Buscar por nombre, apellido o celular...", label_visibility="collapsed", key="live_search_input")
        
        # Render luxurious HTML table
        html_table = display_df.to_html(classes="luxury-wimbledon-table", index=False, escape=False)
        st.markdown(html_table, unsafe_allow_html=True)

        # Inject JavaScript for instantaneous client-side filtering and sorting
        import streamlit.components.v1 as components
        components.html(
            """
            <script>
            const doc = window.parent.document;
            const input = doc.querySelector('input[aria-label="Buscar Jugador"]');
            const table = doc.querySelector('.luxury-wimbledon-table');
            
            if (table) {
                // 1. Filtering Logic
                if (input) {
                    function applyFilter() {
                        const filter = input.value.toUpperCase();
                        const trs = table.getElementsByTagName("tr");
                        for (let i = 1; i < trs.length; i++) {
                            let rowText = trs[i].textContent || trs[i].innerText;
                            if (rowText.toUpperCase().indexOf(filter) > -1) {
                                trs[i].style.display = "";
                            } else {
                                trs[i].style.display = "none";
                            }
                        }
                    }
                    input.addEventListener('keyup', applyFilter);
                    setTimeout(applyFilter, 100);
                }

                // 2. Sorting Logic
                const headers = table.querySelectorAll('th');
                headers.forEach((header, index) => {
                    header.addEventListener('click', () => {
                        const tbody = table.querySelector('tbody');
                        const rows = Array.from(tbody.querySelectorAll('tr'));
                        const isAscending = header.classList.contains('sort-asc');
                        
                        // Remove sort classes from all headers
                        headers.forEach(h => {
                            h.classList.remove('sort-asc', 'sort-desc');
                        });
                        
                        // Toggle sorting direction
                        const direction = isAscending ? -1 : 1;
                        if (!isAscending) {
                            header.classList.add('sort-asc');
                        } else {
                            header.classList.add('sort-desc');
                        }

                        // Sort the rows
                        const sortedRows = rows.sort((a, b) => {
                            const aColText = a.querySelectorAll('td')[index].textContent.trim();
                            const bColText = b.querySelectorAll('td')[index].textContent.trim();
                            
                            // Check if numeric
                            const aNum = parseFloat(aColText);
                            const bNum = parseFloat(bColText);
                            
                            if (!isNaN(aNum) && !isNaN(bNum)) {
                                return (aNum - bNum) * direction;
                            }
                            
                            return aColText.localeCompare(bColText) * direction;
                        });

                        // Re-append rows to table body in the newly sorted order
                        // This uses appendChild which moves existing DOM elements without recreating them
                        sortedRows.forEach(row => tbody.appendChild(row));
                    });
                });
            }
            </script>
            """,
            height=0
        )

with tab_draw:
    col_l, col_r = st.columns(2)
    with col_l:
        st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
        st.subheader("Lógica de Grupos")
        cat_select = st.selectbox("Categoría", ["AA", "A", "B", "C", "D", "Infantil"])
        if st.button("SORTEAR Y CREAR GRUPOS"):
            st.success(f"Grupos generados para {cat_select}")

    with col_r:
        st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
        st.subheader("Vista Previa: Infantil")
        # Visualizing the 4x4 grid we discussed earlier
        st.markdown("""
        <div class="player-card">
            <span><strong>Seed 1</strong> Sara Alexandra</span>
            <span><em>vs</em></span>
            <span><strong>Seed 2</strong> Diego Manzano</span>
        </div>
        <div class="player-card">
            <span><strong>Seed 3</strong> Mariel Lozano</span>
            <span><em>vs</em></span>
            <span><strong>Seed 4</strong> Amelí Chatelet</span>
        </div>
        """, unsafe_allow_html=True)
        
        st.markdown("<br>", unsafe_allow_html=True)
        st.success("El Grupo 1 está equilibrado y listo.")

with tab_print:
    st.markdown('<div class="glass-card-anchor"></div>', unsafe_allow_html=True)
    st.subheader("Exportar PDF")
    st.write("Genera los documentos para la mesa de control del club.")

    c1, c2 = st.columns(2)
    with c1:
        st.button("DESCARGAR FORMATO ROUND ROBIN", use_container_width=True)
    with c2:
        st.button("DESCARGAR FORMATO 16-JUGADORES", use_container_width=True)

# --- 6. FOOTER ---
st.caption("Dashboard del torneo | Designed for Nayar Club Campestre")
