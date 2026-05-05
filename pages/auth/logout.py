"""
Logout page — immediately signs out and reruns.
When st.navigation loads this page, the user is logged out
and redirected to the public default page.
"""
import streamlit as st
from utils.auth import logout_user

st.markdown(
    "<div style='text-align:center; padding-top: 20vh;'>"
    "<p style='font-family: Montserrat, sans-serif; font-size: 1.2rem; color: rgba(255,255,255,0.6);'>"
    "Cerrando sesión...</p></div>",
    unsafe_allow_html=True,
)

logout_user()
