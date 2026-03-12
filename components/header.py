import streamlit as st
import streamlit.components.v1 as components

def render_hero_header(t_name, l_logo, r_logo):
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
