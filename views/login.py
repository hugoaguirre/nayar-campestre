"""
Premium Wimbledon-themed login page for Club Nayar Campestre.
Renders a frosted-glass login card with club branding.
"""
import streamlit as st
from utils.auth import login_user, send_password_reset


def render_login_view():
    """
    Renders the full-screen login page with Wimbledon luxury aesthetics.
    This page is shown when no authenticated session is detected.
    """
    
    # Inject login-specific CSS (scoped styles for this page only)
    st.markdown("""
    <style>
        /* Center the login card vertically and horizontally */
        .login-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 70vh;
            padding: 2rem;
        }
        
        .login-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 16px;
            padding: 3rem 2.5rem;
            max-width: 420px;
            width: 100%;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
            position: relative;
            overflow: hidden;
        }
        
        .login-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #450084, #CCFF00, #450084);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .login-header h1 {
            font-family: 'Tilt Warp', sans-serif !important;
            font-size: 2.8rem !important;
            letter-spacing: -1px !important;
            margin-bottom: 0 !important;
            color: #ffffff !important;
            text-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        }
        
        .login-header .subtitle {
            font-family: 'Montserrat', sans-serif;
            font-size: 0.85rem;
            color: #CCFF00;
            letter-spacing: 4px;
            font-weight: 500;
            margin-top: 0.5rem;
        }
        
        .login-header .lock-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            opacity: 0.7;
        }
        
        .login-divider {
            border: none;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            margin: 1.5rem 0;
        }
        
        .login-footer {
            text-align: center;
            margin-top: 2rem;
        }
        
        .login-footer p {
            font-family: 'Montserrat', sans-serif;
            font-size: 0.65rem;
            color: rgba(255, 255, 255, 0.35);
            letter-spacing: 2px;
            text-transform: uppercase;
        }
    </style>
    """, unsafe_allow_html=True)
    
    # Build the layout: center column
    col_l, col_center, col_r = st.columns([1, 2, 1])
    
    with col_center:
        # Spacer for vertical centering
        st.markdown("<div style='padding-top: 8vh;'></div>", unsafe_allow_html=True)
        
        # Login Card Header
        st.markdown("""
        <div class="login-header">
            <div class="lock-icon">🔒</div>
            <h1>NAYAR CLUB</h1>
            <div class="subtitle">ACCESO DE ENTRENADORES</div>
        </div>
        <div class="login-divider"></div>
        """, unsafe_allow_html=True)
        
        # Login Form
        with st.form("login_form", clear_on_submit=False):
            email = st.text_input(
                "Email",
                placeholder="coach@nayarclub.com",
                key="login_email",
                label_visibility="collapsed"
            )
            password = st.text_input(
                "Contraseña", 
                type="password",
                placeholder="Contraseña",
                key="login_password",
                label_visibility="collapsed"
            )
            
            st.markdown("<div style='height: 0.5rem;'></div>", unsafe_allow_html=True)
            
            submitted = st.form_submit_button(
                "INICIAR SESIÓN",
                type="primary",
                use_container_width=True
            )
            
            if submitted:
                if not email or not password:
                    st.toast("⚠️ Ingresa tu email y contraseña", icon="⚠️")
                else:
                    with st.spinner("Verificando credenciales..."):
                        user = login_user(email.strip(), password)
                        if user:
                            st.toast(f"✅ Bienvenido, {user.get('display_name', 'Coach')}!", icon="🎾")
                            st.rerun()
        
        # Password Reset Section
        st.markdown("<div class='login-divider'></div>", unsafe_allow_html=True)
        
        with st.expander("¿Olvidaste tu contraseña?", expanded=False):
            reset_email = st.text_input(
                "Tu email registrado",
                placeholder="coach@nayarclub.com",
                key="reset_email",
                label_visibility="collapsed"
            )
            if st.button("ENVIAR ENLACE DE RECUPERACIÓN", use_container_width=True):
                if not reset_email:
                    st.toast("⚠️ Ingresa tu email", icon="⚠️")
                else:
                    with st.spinner("Enviando..."):
                        if send_password_reset(reset_email.strip()):
                            st.success("📧 Revisa tu bandeja de entrada para cambiar tu contraseña.")
        
        # Footer
        st.markdown("""
        <div class="login-footer">
            <p>Establecido 1974 • Club Nayar Campestre</p>
            <p>Tour Management System v1.0</p>
        </div>
        """, unsafe_allow_html=True)
