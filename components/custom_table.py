import os
import streamlit.components.v1 as components

component_path = os.path.join(
    os.path.dirname(os.path.dirname(__file__)), "custom_table_component"
)

_table_component = components.declare_component(
    "custom_table_component",
    path=component_path
)
