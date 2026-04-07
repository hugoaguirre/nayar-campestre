import toml
from supabase import create_client

def check_schema():
    try:
        secrets = toml.load(".streamlit/secrets.toml")
        url = secrets["SUPABASE_URL"]
        key = secrets["SUPABASE_KEY"]
        supabase = create_client(url, key)
        
        print("--- Checking Tournaments Table ---")
        t_resp = supabase.table('tournaments').select('*').limit(1).execute()
        if t_resp.data:
            print("Columns:", list(t_resp.data[0].keys()))
        else:
            print("Tournaments table is empty. Trying to guess columns via select('*')...")
            # Fallback: check table definition if possible (Postgres specific)
            # For now, let's just see if we can get anything.
            
        print("\n--- Checking Categories Table ---")
        c_resp = supabase.table('categories').select('name').execute()
        print("Categories:", [c['name'] for c in c_resp.data])
        
        print("\n--- Checking Subcategories Table ---")
        sc_resp = supabase.table('subcategories').select('name').execute()
        print("Subcategories:", [sc['name'] for sc in sc_resp.data])

    except Exception as e:
        print(f"Error checking Supabase: {e}")

if __name__ == "__main__":
    check_schema()
