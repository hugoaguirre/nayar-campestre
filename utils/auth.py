"""
Authentication module for Club Nayar Campestre.
Handles login, logout, session management, password reset, and coach invitation.
Uses Supabase Auth with email/password strategy.
"""
import streamlit as st
from supabase import create_client
from utils.supabase_client import get_anon_client, get_admin_client, create_session_client


def _get_ephemeral_auth_client():
    """
    Returns a fresh, un-cached Supabase client.
    Never cached with @st.cache_resource so authentication operations
    do not contaminate the global anonymous client with user JWTs.
    """
    return create_client(st.secrets["SUPABASE_URL"], st.secrets["SUPABASE_ANON_KEY"])


def login_user(email: str, password: str) -> dict | None:
    """
    Authenticates a user with email + password via Supabase Auth.
    On success, stores the session and creates an authenticated client in session_state.
    Returns the user dict on success, None on failure.
    """
    try:
        # Use an isolated ephemeral client so get_anon_client() is never polluted
        auth_client = _get_ephemeral_auth_client()
        response = auth_client.auth.sign_in_with_password({
            "email": email,
            "password": password
        })
        
        user = response.user
        session = response.session
        
        if user and session:
            # Store auth state in session
            st.session_state.user = {
                "id": user.id,
                "email": user.email,
            }
            st.session_state.access_token = session.access_token
            st.session_state.refresh_token = session.refresh_token
            
            # Create the authenticated client for data operations
            st.session_state.supabase_session_client = create_session_client(
                session.access_token
            )
            
            # Fetch coach profile for display name
            try:
                admin = get_admin_client()
                profile = admin.table('coach_profiles').select('display_name, role').eq('id', user.id).execute()
                if profile.data:
                    st.session_state.user['display_name'] = profile.data[0]['display_name']
                    st.session_state.user['role'] = profile.data[0]['role']
                else:
                    st.session_state.user['display_name'] = user.email.split('@')[0]
                    st.session_state.user['role'] = 'coach'
            except Exception:
                st.session_state.user['display_name'] = user.email.split('@')[0]
                st.session_state.user['role'] = 'coach'
            
            return st.session_state.user
        
        return None
    except Exception as e:
        error_msg = str(e)
        if "Invalid login credentials" in error_msg:
            st.toast("❌ Email o contraseña incorrectos", icon="🔒")
        elif "Email not confirmed" in error_msg:
            st.toast("📧 Confirma tu email antes de iniciar sesión", icon="✉️")
        else:
            st.toast(f"❌ Error de autenticación: {error_msg}", icon="🚫")
        return None


def refresh_user_session() -> bool:
    """Attempts to refresh the user's access token using the stored refresh_token."""
    refresh_token = st.session_state.get('refresh_token')
    if not refresh_token:
        return False
    try:
        auth_client = _get_ephemeral_auth_client()
        response = auth_client.auth.refresh_session(refresh_token)
        if response.session and response.user:
            st.session_state.access_token = response.session.access_token
            st.session_state.refresh_token = response.session.refresh_token
            st.session_state.supabase_session_client = create_session_client(
                response.session.access_token
            )
            return True
    except Exception:
        pass
    return False


def logout_user():
    """Signs out the current user and clears all session state."""
    try:
        session_client = st.session_state.get('supabase_session_client')
        if session_client:
            session_client.auth.sign_out()
        else:
            auth_client = _get_ephemeral_auth_client()
            auth_client.auth.sign_out()
    except Exception:
        pass  # Best-effort sign out
    
    # Clear auth-related session state
    keys_to_clear = [
        'user', 'access_token', 'refresh_token',
        'supabase_session_client',
        'tournament_active', 'tournament_data', 'players_df', 'last_sync'
    ]
    for key in keys_to_clear:
        if key in st.session_state:
            del st.session_state[key]
    
    st.rerun()


def get_current_user() -> dict | None:
    """Returns the current authenticated user dict, or None if not logged in."""
    return st.session_state.get('user', None)


def require_auth() -> dict:
    """
    Defense-in-depth gate for admin pages.
    With st.navigation, unauthenticated users never see admin pages in the menu.
    This guard protects against direct URL access.
    Returns the user dict if authenticated, stops execution if not.
    """
    user = get_current_user()
    if user:
        # Ensure the session client exists (might have been lost on rerun)
        if 'supabase_session_client' not in st.session_state:
            access_token = st.session_state.get('access_token')
            if access_token:
                st.session_state.supabase_session_client = create_session_client(
                    access_token
                )
            elif not refresh_user_session():
                # Token lost and refresh failed — force re-login
                logout_user()
                return None  # Won't reach here due to rerun
        return user
    
    # Not authenticated — block access
    st.error("🔒 Acceso denegado. Inicia sesión para continuar.")
    st.stop()


def send_password_reset(email: str) -> bool:
    """Sends a password reset email via Supabase Auth."""
    try:
        auth_client = _get_ephemeral_auth_client()
        auth_client.auth.reset_password_email(email)
        return True
    except Exception as e:
        st.toast(f"❌ Error al enviar el enlace: {e}", icon="🚫")
        return False


def invite_coach(email: str, display_name: str, password: str = "NayarClub2026!") -> bool:
    """
    Creates a new coach account in Supabase Auth and inserts a coach_profiles row.
    Uses the admin (service_role) client to bypass RLS.
    """
    try:
        admin = get_admin_client()
        
        # 1. Create the user in Supabase Auth
        response = admin.auth.admin.create_user({
            "email": email,
            "password": password,
            "email_confirm": True,  # Skip email verification for coach invites
        })
        
        new_user = response.user
        if not new_user:
            st.toast("❌ No se pudo crear la cuenta", icon="🚫")
            return False
        
        # 2. Insert coach profile
        admin.table('coach_profiles').insert({
            "id": new_user.id,
            "display_name": display_name,
            "role": "coach"
        }).execute()
        
        return True
        
    except Exception as e:
        error_msg = str(e)
        if "already been registered" in error_msg or "already exists" in error_msg:
            st.toast("⚠️ Este email ya tiene una cuenta registrada", icon="📧")
        else:
            st.toast(f"❌ Error al invitar coach: {error_msg}", icon="🚫")
        return False
