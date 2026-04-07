import pandas as pd
import streamlit as st
from utils.supabase_client import get_supabase_client

def fetch_tournament_players(tournament_name=None):
    """
    Fetches all registered players for the active tournament and transforms 
    them back into the Pandas DataFrame format expected by the Streamlit UI.
    """
    if tournament_name is None:
        t_data = st.session_state.get('tournament_data')
        tournament_name = t_data.get('name') if t_data else None
        
    if not tournament_name:
        return pd.DataFrame()
        
    try:
        supabase = get_supabase_client()
        
        # 1. Get Tournament ID
        t_resp = supabase.table('tournaments').select('id').eq('name', tournament_name).execute()
        if not t_resp.data:
            return pd.DataFrame()
        t_id = t_resp.data[0]['id']
        
        # 2. Get Registrations with nested player/category/partner data
        response = supabase.table('tournament_registrations').select(
            'id, is_singles, is_doubles, payment_status, partner_id,'
            'players:players!tournament_registrations_player_id_fkey(id, first_name, last_name, phone),'
            'partner:players!tournament_registrations_partner_id_fkey(first_name, last_name),'
            'categories(name),'
            'subcategories(name)'
        ).eq('tournament_id', t_id)\
         .or_('is_singles.eq.true,is_doubles.eq.true')\
         .execute()
        
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
                "ID_Registro": reg.get('id'),
                "ID_Jugador": p.get('id'),
                "ID_Pareja": reg.get('partner_id'),
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
        desired_cols = ["Nombre", "Apellido", "Subcategoría", "Categoría", "Pago", "Celular", "Singles", "Dobles", "Pareja de dobles", "ID_Registro", "ID_Jugador", "ID_Pareja"]
        for c in desired_cols:
            if c not in df.columns:
                df[c] = ""
                
        return df[desired_cols]
        
    except Exception as e:
        st.error(f"Error fetching from Supabase: {e}")
        return pd.DataFrame()

def upsert_player_to_supabase(player_data, tournament_name=None):
    """
    Upserts a player to the club members directory and optionally registers 
    them for a tournament.
    """
    if tournament_name is None:
        t_data = st.session_state.get('tournament_data')
        tournament_name = t_data.get('name') if t_data else None
        
    try:
        supabase = get_supabase_client()
        
        # 0. Check if tournament is finalized (safely falling back if column missing)
        if tournament_name:
            t_check = supabase.table('tournaments').select('*').eq('name', tournament_name).execute()
            if t_check.data and t_check.data[0].get('is_finalized'):
                # Technically we should skip registration changes if finalized
                pass

        # 1. Resolve Category & Subcategory IDs
        c_id, sc_id = None, None
        if tournament_name:
            c_resp = supabase.table('categories').select('id').eq('name', player_data.get('Categoría', '')).execute()
            sc_resp = supabase.table('subcategories').select('id').eq('name', player_data.get('Subcategoría', '')).execute()
            c_id = c_resp.data[0]['id'] if c_resp.data else None
            sc_id = sc_resp.data[0]['id'] if sc_resp.data else None
        
        # 2. Handle Player Identity
        p_id = player_data.get('ID_Jugador')
        if not p_id:
            p_payload = {
                "first_name": player_data['Nombre'],
                "last_name": player_data['Apellido'],
                "phone": player_data['Celular'] if player_data['Celular'] else None
            }
            p_ins = supabase.table('players').insert(p_payload).execute()
            if p_ins.data:
                p_id = p_ins.data[0]['id']
        
        if not p_id: return False

        # 3. Handle Tournament Registration
        if not tournament_name:
            return True
            
        t_resp = supabase.table('tournaments').select('id').eq('name', tournament_name).execute()
        t_id = t_resp.data[0]['id'] if t_resp.data else None
        if not t_id: return True
        
        # 4. Resolve Partner ID
        partner_id = None
        p_name = player_data.get('Pareja de dobles', '').strip()
        if p_name and p_name != "Ninguna":
            parts = p_name.split(' ', 1)
            f_n, l_n = parts[0], parts[1] if len(parts) > 1 else ""
            pr_resp = supabase.table('players').select('id').eq('first_name', f_n).eq('last_name', l_n).execute()
            partner_id = pr_resp.data[0]['id'] if pr_resp.data else None

        # 5. Upsert Registration
        reg_payload = {
            "tournament_id": t_id,
            "player_id": p_id,
            "category_id": c_id,
            "subcategory_id": sc_id,
            "is_singles": True if player_data.get('Singles') == 'Sí' else False,
            "is_doubles": True if player_data.get('Dobles') == 'Sí' else False,
            "partner_id": partner_id,
            "payment_status": player_data.get('Pago', 'Pendiente')
        }
        
        r_id = player_data.get('ID_Registro')
        if r_id:
            supabase.table('tournament_registrations').update(reg_payload).eq('id', r_id).execute()
        else:
            ex_reg = supabase.table('tournament_registrations').select('id').eq('tournament_id', t_id).eq('player_id', p_id).execute()
            if ex_reg.data:
                supabase.table('tournament_registrations').update(reg_payload).eq('id', ex_reg.data[0]['id']).execute()
            else:
                supabase.table('tournament_registrations').insert(reg_payload).execute()
                
        return True
    except Exception as e:
        print(f"Supabase upsert error: {e}")
        return False

# --- NEW: DRAW PERSISTENCE & FINALIZATION ---

def fetch_saved_draw(tournament_id, cat_name, scat_name, format_text):
    """Retrieves a saved draw snapshot from Supabase."""
    try:
        supabase = get_supabase_client()
        # 1. Resolve IDs
        c_r = supabase.table('categories').select('id').eq('name', cat_name).execute()
        sc_r = supabase.table('subcategories').select('id').eq('name', scat_name).execute()
        if not c_r.data or not sc_r.data: return None
        
        # 2. Query Draws table
        resp = supabase.table('tournament_draws').select('draw_json').eq('tournament_id', tournament_id).eq('category_id', c_r.data[0]['id']).eq('subcategory_id', sc_r.data[0]['id']).eq('format_text', format_text).execute()
        
        return resp.data[0]['draw_json'] if resp.data else None
    except Exception as e:
        print(f"Error fetching draw: {e}")
        return None

def save_tournament_draw(tournament_id, cat_name, scat_name, format_text, groups_data):
    """Saves/Updates the group snapshot for a specific category."""
    try:
        supabase = get_supabase_client()
        # 1. Resolve IDs
        c_r = supabase.table('categories').select('id').eq('name', cat_name).execute()
        sc_r = supabase.table('subcategories').select('id').eq('name', scat_name).execute()
        if not c_r.data or not sc_r.data: return False
        
        payload = {
            "tournament_id": tournament_id,
            "category_id": c_r.data[0]['id'],
            "subcategory_id": sc_r.data[0]['id'],
            "format_text": format_text,
            "draw_json": groups_data,
            "updated_at": "now()"
        }
        
        # Use UPSERT (Matches UNIQUE constraint in migration)
        # In supabase-py, we can use insert with upsert=True if configured, 
        # or check existence
        exist = supabase.table('tournament_draws').select('id').eq('tournament_id', tournament_id).eq('category_id', c_r.data[0]['id']).eq('subcategory_id', sc_r.data[0]['id']).eq('format_text', format_text).execute()
        
        if exist.data:
            supabase.table('tournament_draws').update(payload).eq('id', exist.data[0]['id']).execute()
        else:
            supabase.table('tournament_draws').insert(payload).execute()
            
        return True
    except Exception as e:
        print(f"Error saving draw: {e}")
        return False

def update_tournament_finalization(tournament_id, finalized=True):
    """Updates the is_finalized flag for the tournament."""
    try:
        supabase = get_supabase_client()
        supabase.table('tournaments').update({"is_finalized": finalized}).eq('id', tournament_id).execute()
        return True
    except Exception as e:
        print(f"Error updating finalization: {e}")
        return False
