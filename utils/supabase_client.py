import streamlit as st
from supabase import create_client, Client

@st.cache_resource
def get_supabase_client() -> Client:
    """
    Initializes and returns the Supabase client.
    Uses Streamlit's @st.cache_resource so it's only created once per session.
    Expects SUPABASE_URL and SUPABASE_KEY in .streamlit/secrets.toml
    """
    try:
        url = st.secrets["SUPABASE_URL"]
        key = st.secrets["SUPABASE_KEY"]
        return create_client(url, key)
    except KeyError as e:
        st.error(f"Falta una credencial de Supabase en secrets.toml: {e}")
        st.stop()
    except Exception as e:
        st.error(f"Error al inicializar Supabase: {e}")
        st.stop()
