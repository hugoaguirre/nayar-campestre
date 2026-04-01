import pandas as pd
import streamlit as st
from utils.supabase_client import get_supabase_client

def fetch_tournament_players(tournament_name="Torneo Inicial 2026"):
    """
    Fetches all registered players for the active tournament and transforms 
    them back into the Pandas DataFrame format expected by the Streamlit UI.
    """
    try:
        supabase = get_supabase_client()
        
        # 1. Get Tournament ID
        t_resp = supabase.table('tournaments').select('id').eq('name', tournament_name).execute()
        if not t_resp.data:
            return pd.DataFrame()
        t_id = t_resp.data[0]['id']
        
        # 2. Get Registrations with nested player/category/partner data natively to avoid N+1 slow queries
        response = supabase.table('tournament_registrations').select(
            'id, is_singles, is_doubles, payment_status, partner_id,'
            'players:players!tournament_registrations_player_id_fkey(id, first_name, last_name, phone),'
            'partner:players!tournament_registrations_partner_id_fkey(first_name, last_name),'
            'categories(name),'
            'subcategories(name)'
        ).eq('tournament_id', t_id).execute()
        
        if not response.data:
            df = pd.DataFrame()
            desired_cols = ["Nombre", "Apellido", "Subcategoría", "Categoría", "Pago", "Celular", "Singles", "Dobles", "Pareja de dobles", "ID_Registro", "ID_Jugador"]
            for c in desired_cols: df[c] = ""
            return df[desired_cols]
            
        data = []
        for reg in response.data:
            p = reg.get('players') or {}
            c = reg.get('categories') or {}
            sc = reg.get('subcategories') or {}
            partner_data = reg.get('partner') or {}
            
            partner_name = ""
            if partner_data:
                partner_name = f"{partner_data.get('first_name', '')} {partner_data.get('last_name', '')}".strip()

            row = {
                "ID_Registro": reg.get('id'), # Hidden metadata
                "ID_Jugador": p.get('id'),    # Hidden metadata
                "Nombre": p.get('first_name', ''),
                "Apellido": p.get('last_name', ''),
                "Categoría": c.get('name', ''),
                "Subcategoría": sc.get('name', ''),
                "Celular": p.get('phone', ''),
                "Pago": reg.get('payment_status', 'Pendiente'),
                "Singles": "Sí" if reg.get('is_singles') else "No",
                "Dobles": "Sí" if reg.get('is_doubles') else "No",
                "Pareja de dobles": partner_name
            }
            data.append(row)
            
        df = pd.DataFrame(data)
        # Enforce column order for the UI
        desired_cols = ["Nombre", "Apellido", "Subcategoría", "Categoría", "Pago", "Celular", "Singles", "Dobles", "Pareja de dobles", "ID_Registro", "ID_Jugador"]
        for c in desired_cols:
            if c not in df.columns:
                df[c] = ""
                
        return df[desired_cols]
        
    except Exception as e:
        st.error(f"Error fetching from Supabase: {e}")
        df = pd.DataFrame()
        desired_cols = ["Nombre", "Apellido", "Subcategoría", "Categoría", "Pago", "Celular", "Singles", "Dobles", "Pareja de dobles", "ID_Registro", "ID_Jugador"]
        for c in desired_cols: df[c] = ""
        return df[desired_cols]

def upsert_player_to_supabase(player_data, tournament_name="Torneo Inicial 2026"):
    try:
        supabase = get_supabase_client()
        
        # 1. Resolve Category & Subcategory IDs
        c_resp = supabase.table('categories').select('id').eq('name', player_data['Categoría']).execute()
        sc_resp = supabase.table('subcategories').select('id').eq('name', player_data['Subcategoría']).execute()
        
        c_id = c_resp.data[0]['id'] if c_resp.data else None
        sc_id = sc_resp.data[0]['id'] if sc_resp.data else None
        
        # 2. Upsert Player
        p_payload = {
            "first_name": player_data['Nombre'],
            "last_name": player_data['Apellido'],
            "phone": player_data['Celular'] if player_data['Celular'] else None,
            "category_id": c_id,
            "subcategory_id": sc_id
        }
        
        p_id = player_data.get('ID_Jugador')
        if p_id:
            supabase.table('players').update(p_payload).eq('id', p_id).execute()
        else:
            p_ins = supabase.table('players').insert(p_payload).execute()
            if p_ins.data:
                p_id = p_ins.data[0]['id']
                
        if not p_id: return False

        # 3. Get Tournament ID
        t_resp = supabase.table('tournaments').select('id').eq('name', tournament_name).execute()
        t_id = t_resp.data[0]['id'] if t_resp.data else None
        if not t_id: return False
        
        # 4. Resolve Partner ID
        partner_id = None
        p_name = player_data.get('Pareja de dobles', '').strip()
        if p_name and p_name != "Ninguna":
            # Very basic lookup by exact full name based on local state (or query)
            parts = p_name.split(' ', 1)
            f_n = parts[0]
            l_n = parts[1] if len(parts) > 1 else ""
            pr_resp = supabase.table('players').select('id').eq('first_name', f_n).eq('last_name', l_n).execute()
            if pr_resp.data:
                partner_id = pr_resp.data[0]['id']

        # 5. Upsert Registration
        reg_payload = {
            "tournament_id": t_id,
            "player_id": p_id,
            "category_id": c_id,
            "subcategory_id": sc_id,
            "is_singles": True if player_data['Singles'] == 'Sí' else False,
            "is_doubles": True if player_data['Dobles'] == 'Sí' else False,
            "partner_id": partner_id,
            "payment_status": player_data['Pago']
        }
        
        r_id = player_data.get('ID_Registro')
        if r_id:
            supabase.table('tournament_registrations').update(reg_payload).eq('id', r_id).execute()
        else:
            # Check if it exists for this tournament just in case
            exist_reg = supabase.table('tournament_registrations').select('id').eq('tournament_id', t_id).eq('player_id', p_id).execute()
            if exist_reg.data:
                supabase.table('tournament_registrations').update(reg_payload).eq('id', exist_reg.data[0]['id']).execute()
            else:
                supabase.table('tournament_registrations').insert(reg_payload).execute()
                
        return True
    except Exception as e:
        print(f"Supabase upsert error: {e}")
        return False
