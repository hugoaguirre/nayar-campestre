import pandas as pd
import streamlit as st
from supabase import create_client, Client
import math

def get_client() -> Client:
    url = st.secrets["SUPABASE_URL"]
    key = st.secrets["SUPABASE_KEY"]
    return create_client(url, key)

def run_migration():
    print("Iniciando migración a Supabase...")
    supabase = get_client()
    
    # Read CSV
    df = pd.read_csv("jugadores_registrados_200.csv")
    
    # 1. Insert Categories
    categories = df['Categoría'].dropna().unique().tolist()
    cat_map = {}
    for c in categories:
        resp = supabase.table('categories').select('id, name').eq('name', c).execute()
        if not resp.data:
            ins = supabase.table('categories').insert({"name": c}).execute()
            cat_map[c] = ins.data[0]['id']
        else:
            cat_map[c] = resp.data[0]['id']
    print("Categorías listas:", cat_map)

    # 2. Insert Subcategories
    subcategories = df['Subcategoría'].dropna().unique().tolist()
    sub_map = {}
    for sc in subcategories:
        resp = supabase.table('subcategories').select('id, name').eq('name', sc).execute()
        if not resp.data:
            ins = supabase.table('subcategories').insert({"name": sc}).execute()
            sub_map[sc] = ins.data[0]['id']
        else:
            sub_map[sc] = resp.data[0]['id']
    print("Subcategorías listas:", len(sub_map))

    # 3. Create Default Tournament
    tourney_name = "Torneo Inicial 2026"
    resp = supabase.table('tournaments').select('id').eq('name', tourney_name).execute()
    if not resp.data:
        ins = supabase.table('tournaments').insert({"name": tourney_name, "status": "open"}).execute()
        tourney_id = ins.data[0]['id']
    else:
        tourney_id = resp.data[0]['id']
    print("Torneo activo ID:", tourney_id)

    # 4. Insert Players
    player_id_map = {}
    for _, row in df.iterrows():
        fname = str(row['Nombre']).strip()
        lname = str(row['Apellido']).strip()
        phone = str(row.get('Celular', '')).strip()
        if phone == "nan": phone = None

        cat_id = cat_map.get(row['Categoría'])
        scat_id = sub_map.get(row['Subcategoría'])
        
        full_name = f"{fname} {lname}"

        # Check existing
        q = supabase.table('players').select('id').eq('first_name', fname).eq('last_name', lname)
        if phone:
            q = q.eq('phone', phone)
            
        resp = q.execute()
        
        if not resp.data:
            data = {
                "first_name": fname,
                "last_name": lname,
                "phone": phone,
                "category_id": cat_id,
                "subcategory_id": scat_id
            }
            ins = supabase.table('players').insert(data).execute()
            p_id = ins.data[0]['id']
        else:
            p_id = resp.data[0]['id']
            
        player_id_map[full_name] = p_id

    print("Jugadores base migrados:", len(player_id_map))

    # 5. Insert Registrations & Resolve Partners
    for _, row in df.iterrows():
        fname = str(row['Nombre']).strip()
        lname = str(row['Apellido']).strip()
        full_name = f"{fname} {lname}"
        
        p_id = player_id_map.get(full_name)
        if not p_id: continue

        partner_name = str(row.get('Pareja de dobles', '')).strip()
        partner_id = None
        if partner_name and partner_name.lower() != 'nan':
            # Intentar encontrar el ID de la pareja (puede haber pequeños errores en escritura, 
            # pero asumimos consistencia de los datos del CSV)
            partner_id = player_id_map.get(partner_name)
            
        is_singles = True if str(row.get('Singles', 'Sí')).strip() == 'Sí' else False
        is_doubles = True if str(row.get('Dobles', 'No')).strip() == 'Sí' else False
        pago_status = str(row.get('Pago', 'Pendiente')).strip()

        cat_id = cat_map.get(row['Categoría'])
        scat_id = sub_map.get(row['Subcategoría'])

        # Upsert Registration
        resp = supabase.table('tournament_registrations') \
            .select('id') \
            .eq('tournament_id', tourney_id) \
            .eq('player_id', p_id) \
            .execute()

        reg_data = {
            "tournament_id": tourney_id,
            "player_id": p_id,
            "category_id": cat_id,
            "subcategory_id": scat_id,
            "is_singles": is_singles,
            "is_doubles": is_doubles,
            "partner_id": partner_id,
            "payment_status": pago_status
        }

        if not resp.data:
            supabase.table('tournament_registrations').insert(reg_data).execute()
        else:
            supabase.table('tournament_registrations').update(reg_data).eq('id', resp.data[0]['id']).execute()

    print("Migración completada exitosamente!")

if __name__ == "__main__":
    run_migration()
