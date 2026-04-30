import streamlit as st
from supabase import create_client, Client


@st.cache_resource
def get_anon_client() -> Client:
    """
    Returns a Supabase client initialized with the ANON key.
    Used for authentication operations (login, signup, password reset).
    Cached globally since it doesn't carry user-specific state.
    """
    try:
        url = st.secrets["SUPABASE_URL"]
        key = st.secrets["SUPABASE_ANON_KEY"]
        return create_client(url, key)
    except KeyError as e:
        st.error(f"Falta una credencial de Supabase en secrets.toml: {e}")
        st.stop()
    except Exception as e:
        st.error(f"Error al inicializar Supabase: {e}")
        st.stop()


@st.cache_resource
def get_admin_client() -> Client:
    """
    Returns a Supabase client initialized with the SERVICE_ROLE key.
    Bypasses ALL RLS policies. Used ONLY for admin operations:
    - Inviting new coaches (auth.admin.create_user)
    - Fetching coach profiles during login
    
    WARNING: Never expose this client to browser-side code.
    Safe in Streamlit because all Python runs server-side.
    """
    try:
        url = st.secrets["SUPABASE_URL"]
        key = st.secrets["SUPABASE_SERVICE_KEY"]
        return create_client(url, key)
    except KeyError as e:
        st.error(f"Falta SUPABASE_SERVICE_KEY en secrets.toml: {e}")
        st.stop()
    except Exception as e:
        st.error(f"Error al inicializar Supabase Admin: {e}")
        st.stop()


def create_session_client(access_token: str) -> Client:
    """
    Creates a NEW Supabase client and sets the user's access token on it.
    This client carries the JWT so that RLS policies are enforced.
    
    NOT cached — stored per-session in st.session_state by the auth module.
    """
    try:
        url = st.secrets["SUPABASE_URL"]
        key = st.secrets["SUPABASE_ANON_KEY"]
        client = create_client(url, key)
        # Set the auth token so all subsequent requests carry the JWT
        client.postgrest.auth(access_token)
        return client
    except Exception as e:
        st.error(f"Error al crear cliente autenticado: {e}")
        st.stop()


def get_supabase_client() -> Client:
    """
    Smart wrapper that returns the session-authenticated client when available,
    falling back to the admin client. This ensures ALL existing call sites
    throughout the codebase continue to work without modification.
    
    After login: returns the JWT-carrying session client (RLS enforced)
    Before login: returns the admin client (RLS bypassed — safe because
                   the login gate in main.py prevents unauthorized access)
    """
    session_client = st.session_state.get('supabase_session_client')
    if session_client:
        return session_client
    
    # Fallback: admin client (only reachable during login flow or edge cases)
    return get_admin_client()
