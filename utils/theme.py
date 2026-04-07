import streamlit as st

def apply_wimbledon_ui():
    st.markdown(
        """
    <style>
        /* 1. Global Modern Typography */
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&family=Inter:wght@400;500;600&display=swap');
        
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

        /* Global Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        ::-webkit-scrollbar-thumb {
            background: #450084;
            border-radius: 8px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #CCFF00;
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
        div[data-testid="stDownloadButton"] {
            margin: 0 !important;
            padding: 0 !important;
        }

        div[data-testid="stButton"] > button,
        div.stButton > button,
        div[data-testid="stDownloadButton"] > button,
        div[data-testid="stBaseButton-secondary"] {
            width: 100% !important;
            display: block !important;
        }
        
        div.stButton > button, div[data-testid="stDownloadButton"] > button {
            background-color: #450084 !important; /* Regal Purple */
            color: #ffffff !important; 
            border: 2px solid #ffffff !important;
            border-radius: 4px !important; 
            padding: 0 !important;
            transition: all 0.3s ease;
            box-shadow: none !important;
            height: 48px !important;
            min-height: 48px !important;
            max-height: 48px !important;
            box-sizing: border-box !important;
        }
        
        div.stButton > button p, div[data-testid="stDownloadButton"] > button p {
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 700 !important;
            font-size: 0.85rem !important;
            text-transform: uppercase !important;
            letter-spacing: 1px !important;
            margin: 0 !important;
            color: #ffffff !important; 
        }

        div.stButton > button:hover, div[data-testid="stDownloadButton"] > button:hover {
            background-color: #ffffff !important;
            color: #450084 !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4) !important;
        }
        
        div.stButton > button:hover p, div[data-testid="stDownloadButton"] > button:hover p {
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
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
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
        /* Aggressively clear Streamlit's native input formatting */
        [data-testid="stTextInput"] div[data-baseweb="input"] > div,
        div.stKeyup div[data-baseweb="input"] > div {
            background-color: transparent !important;
            background: transparent !important;
        }

        /* Sync input wrapper margins and heights identical to button offsets */
        [data-testid="stTextInput"], 
        [data-testid="stExpander"] {
            /* Inheriting native gap structure */
        }
        
        /* Neutralize any phantom spacing from invisible labels so elements sit flush */
        [data-testid="stTextInput"] div[data-testid="stWidgetLabel"],
        [data-testid="stFileUploader"] div[data-testid="stWidgetLabel"],
        [data-testid="stFileUploader"] small,
        [data-testid="stFileUploader"] [data-testid="stMarkdownContainer"] {
            display: none !important;
            height: 0px !important;
            min-height: 0px !important;
            margin: 0px !important;
            padding: 0px !important;
        }

        /* Stop native Streamlit Uploader wrapper from commanding 100px+ height */
        [data-testid="stFileUploader"] {
            height: 48px !important;
            min-height: 48px !important;
            max-height: 48px !important;
            margin: 0 !important;
            padding: 0 !important;
            box-sizing: border-box !important;
            overflow: hidden !important;
            position: relative !important;
        }

        [data-testid="stFileUploader"] section {
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            bottom: 0 !important;
            width: 100% !important;
            height: 48px !important;
            margin: 0 !important;
            padding: 0 !important;
            box-sizing: border-box !important;
        }

        [data-testid="stTextInput"], 
        [data-testid="stExpander"] {
            margin: 0 !important;
            padding: 0 !important;
        }

        /* Provide a unified Frosted Glass shell to all text inputs (Live Search, Modals, etc.) */
        [data-testid="stTextInput"] div[data-baseweb="input"],
        div.stKeyup div[data-baseweb="input"] {
            border-radius: 50px !important;
            border: 1px solid rgba(255, 255, 255, 0.2) !important;
            background-color: rgba(255, 255, 255, 0.08) !important; 
            backdrop-filter: blur(15px) !important;
            padding: 0 1rem !important;
            height: 48px !important;
            min-height: 48px !important;
            max-height: 48px !important;
            box-sizing: border-box !important;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.1) !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            display: flex !important;
            align-items: center !important;
        }
        
        [data-testid="stTextInput"] div[data-baseweb="input"]:focus-within,
        div.stKeyup div[data-baseweb="input"]:focus-within {
            box-shadow: 0 4px 20px rgba(204, 255, 0, 0.15) !important;
            transform: translateY(-2px);
            border-color: #CCFF00 !important; /* Tennis Ball Yellow glow */
            background-color: rgba(255, 255, 255, 0.12) !important;
        }
        
        /* The Actual Input Text */
        div.stKeyup input,
        [data-testid="stTextInput"] input {
            color: #ffffff !important; /* Premium White Text */
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 500 !important;
            background-color: transparent !important;
            -webkit-text-fill-color: #ffffff !important;
            margin: 0 !important;
            padding: 0 !important;
        }

        /* Placeholder Styling */
        div.stKeyup input::placeholder,
        [data-testid="stTextInput"] input::placeholder {
            color: rgba(255, 255, 255, 0.6) !important; /* Frosted White */
            -webkit-text-fill-color: rgba(255, 255, 255, 0.6) !important;
            font-style: italic !important;
            font-weight: 400 !important;
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
            background-color: transparent !important;
            border: none !important;
        }
        
        div[data-testid="stSelectbox"] [data-baseweb="select"] {
            background-color: rgba(255, 255, 255, 0.08) !important; 
            backdrop-filter: blur(15px) !important;
            border-radius: 50px !important;
            border: 1px solid rgba(255, 255, 255, 0.2) !important;
            height: 48px !important;
            min-height: 48px !important;
            max-height: 48px !important;
            box-sizing: border-box !important;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.1) !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1) !important;
            padding: 0 1rem !important;
            display: flex !important;
            align-items: center !important;
        }
        
        div[data-testid="stSelectbox"] [data-baseweb="select"]:focus-within {
            box-shadow: 0 4px 20px rgba(204, 255, 0, 0.15) !important;
            transform: translateY(-2px);
            border-color: #CCFF00 !important; /* Tennis Ball Yellow glow */
            background-color: rgba(255, 255, 255, 0.12) !important;
        }
        /* Selectbox Text & Icon */
        div[data-testid="stSelectbox"] [data-baseweb="select"] div {
            color: #ffffff !important;
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 500 !important;
            background-color: transparent !important;
            margin: 0 !important;
            padding: 0 !important;
            display: flex !important;
            align-items: center !important;
            height: 100% !important;
            line-height: normal !important;
        }
        div[data-testid="stSelectbox"] [data-baseweb="select"] svg {
            fill: #ffffff !important;
        }
        /* Dropdown Options Popup Container */
        div[data-baseweb="popover"] {
            background-color: rgba(0, 51, 25, 0.95) !important; /* Deep Green frosted */
            backdrop-filter: blur(15px) !important;
            border-radius: 12px !important;
            border: 1px solid rgba(255,255,255,0.2) !important;
            box-shadow: 0 8px 32px rgba(0,0,0,0.5) !important;
            overflow: hidden !important;
        }
        ul[role="listbox"] {
            background-color: transparent !important;
            padding: 0 !important;
        }
        /* Individual Dropdown Options */
        li[role="option"] {
            background-color: transparent !important;
            color: #ffffff !important;
            font-family: 'Montserrat', sans-serif !important;
            font-weight: 500 !important;
            padding: 0.75rem 1rem !important;
            border-bottom: 1px solid rgba(255,255,255,0.1) !important;
            transition: all 0.2s ease !important;
        }
        li[role="option"]:last-child {
            border-bottom: none !important;
        }
        li[role="option"]:hover, 
        li[role="option"][aria-selected="true"] {
            background-color: #450084 !important; /* Royal Purple hover */
            color: #CCFF00 !important; /* Yellow text on selection */
        }
        /* Custom JS Component Styling */
        
        /* Removed .luxury-wimbledon-table css from global scope 
           as it will be injected into the isolated component iframe */

        /* Expander Geometry Syncing */
        [data-testid="stExpander"] details, 
        [data-testid="stExpander"] {
            margin: 0 !important; 
            padding: 0 !important;
        }
        
        [data-testid="stExpander"] details summary {
            height: 48px !important;
            min-height: 48px !important;
            max-height: 48px !important;
            padding: 0 1rem !important; /* Restore left/right padding for chevron */
            box-sizing: border-box !important;
        }

        /* 11. Custom Fonts for Expanders and internal elements (like Pills) */
        [data-testid="stExpander"] *,
        [data-testid*="SegmentedControl"] *,
        [data-testid*="stPill"] *,
        .stPills * {
            font-family: 'Montserrat', sans-serif !important;
        }
        
        /* Explicitly DEFEND the native chevron arrow so it doesn't break into raw text again */
        [data-testid="stExpander"] summary svg,
        [data-testid="stExpander"] summary .st-icon,
        [data-testid="stExpander"] summary [class*="icon"],
        [data-testid="stExpander"] summary [class*="material"],
        [data-testid="stExpander"] summary [data-testid*="Icon"] {
            font-family: "Material Symbols Rounded", "Material Icons", sans-serif !important;
        }

        /* 12. Custom Modal Styling for Dark Green UI */
        div[data-testid="stModal"] > div[role="dialog"] {
            background-color: #003319 !important; /* Dark Green */
            border: 2px solid #450084 !important; /* Purple Accent */
            border-radius: 12px !important;
            box-shadow: 0 10px 40px rgba(0,0,0,0.6) !important;
            color: #ffffff !important;
        }

        div[data-testid="stModal"] > div[role="dialog"] [data-testid="stMarkdownContainer"] h3 {
            color: #ffffff !important;
            font-family: 'Montserrat', sans-serif !important;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Override general modal close button to white */
        div[data-testid="stModal"] button[aria-label="Close"] {
            color: #ffffff !important;
        }

        /* 12. Hide System Trigger Input */
        div[data-testid="stTextInput"]:has(input[aria-label="hidden_edit_trigger"]) {
            display: none !important;
        }

        /* 13. Wimbledon Alerts (Notices/Tips/Success) */
        div[data-testid="stAlert"] {
            background-color: rgba(204, 255, 0, 0.08) !important; 
            backdrop-filter: blur(15px) !important;
            border: 1px solid rgba(204, 255, 0, 0.3) !important;
            border-radius: 8px !important;
        }
        
        div[data-testid="stAlert"] [data-testid="stMarkdownContainer"] *,
        div[data-testid="stAlert"] [data-testid="stMarkdownContainer"] p {
            color: #ffffff !important;
            font-family: 'Montserrat', sans-serif !important;
        }
        
        div[data-testid="stAlert"] svg,
        div[data-testid="stAlert"] [data-testid="stIconMaterial"] {
            fill: #CCFF00 !important;
            color: #CCFF00 !important;
        }
        
        /* RESTORE ERROR RED STYLING explicitly targeting the Streamlit native error icon path (h-2V7h2v6z) */
        div[data-testid="stAlert"]:has(svg path[d*="h-2V7h2v6z"]) {
            background-color: rgba(255, 43, 43, 0.1) !important;
            border: 1px solid rgba(255, 43, 43, 0.4) !important;
        }
        
        div[data-testid="stAlert"]:has(svg path[d*="h-2V7h2v6z"]) svg,
        div[data-testid="stAlert"]:has(svg path[d*="h-2V7h2v6z"]) [data-testid="stIconMaterial"] {
            fill: #ff2b2b !important;
            color: #ff2b2b !important;
        }
    </style>
        """,
        unsafe_allow_html=True,
    )
