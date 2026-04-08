import csv
import os

def generate_sql():
    csv_file = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'jugadores_registrados_200.csv')
    sql_file = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'seed_presidentes.sql')
    
    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    with open(sql_file, 'w', encoding='utf-8') as out:
        out.write("-- SEED DATA FOR COPA PRESIDENTES\n")
        out.write("DO $$\n")
        out.write("DECLARE\n")
        out.write("    t_id UUID := (SELECT id FROM tournaments WHERE name ILIKE '%Copa Presidente%' LIMIT 1);\n")
        
        categories = set(r['Categoría'] for r in rows)
        subcategories = set(r['Subcategoría'] for r in rows)
        
        for c in categories:
            var_name = "".join(x if x.isalnum() else "_" for x in c)
            out.write(f"    c_{var_name} UUID := (SELECT id FROM categories WHERE name = '{c}' LIMIT 1);\n")
        
        for s in subcategories:
            var_name = "".join(x if x.isalnum() else "_" for x in s)
            out.write(f"    s_{var_name} UUID := (SELECT id FROM subcategories WHERE name = '{s}' LIMIT 1);\n")
            
        out.write("BEGIN\n")
        out.write("    IF t_id IS NULL THEN\n")
        out.write("        RAISE EXCEPTION 'Tournament Copa Presidentes not found';\n")
        out.write("    END IF;\n\n")

        out.write("    -- INSERT PLAYERS\n")
        for row in rows:
            fname = row['Nombre'].strip().replace("'", "''")
            lname = row['Apellido'].strip().replace("'", "''")
            phone = row['Celular'].strip()
            out.write(f"    INSERT INTO players (first_name, last_name, phone)\n")
            out.write(f"    VALUES ('{fname}', '{lname}', '{phone}')\n")
            out.write(f"    ON CONFLICT (first_name, last_name, phone) DO NOTHING;\n")
            
        out.write("\n    -- INSERT REGISTRATIONS\n")
        for row in rows:
            fname = row['Nombre'].strip().replace("'", "''")
            lname = row['Apellido'].strip().replace("'", "''")
            phone = row['Celular'].strip()
            
            c_var = "".join(x if x.isalnum() else "_" for x in row['Categoría'])
            s_var = "".join(x if x.isalnum() else "_" for x in row['Subcategoría'])
            
            is_singles = 'true' if row['Singles'] == 'Sí' else 'false'
            is_doubles = 'true' if row['Dobles'] == 'Sí' else 'false'
            status = row['Pago']
            
            out.write(f"    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)\n")
            out.write(f"    SELECT t_id, id, c_{c_var}, s_{s_var}, {is_singles}, {is_doubles}, '{status}'\n")
            out.write(f"    FROM players WHERE first_name = '{fname}' AND last_name = '{lname}' AND phone = '{phone}'\n")
            out.write(f"    ON CONFLICT (tournament_id, player_id) DO UPDATE SET \n")
            out.write(f"      category_id = EXCLUDED.category_id,\n")
            out.write(f"      subcategory_id = EXCLUDED.subcategory_id,\n")
            out.write(f"      is_singles = EXCLUDED.is_singles,\n")
            out.write(f"      is_doubles = EXCLUDED.is_doubles,\n")
            out.write(f"      payment_status = EXCLUDED.payment_status;\n")

        out.write("\n    -- UPDATE DOUBLES PARTNERS\n")
        for row in rows:
            partner = row.get('Pareja de dobles', '').strip()
            if partner:
                fname = row['Nombre'].strip().replace("'", "''")
                lname = row['Apellido'].strip().replace("'", "''")
                phone = row['Celular'].strip()
                
                partner_full = partner.replace("'", "''")
                
                out.write(f"    UPDATE tournament_registrations SET partner_id = (\n")
                out.write(f"        SELECT id FROM players WHERE first_name || ' ' || last_name = '{partner_full}' LIMIT 1\n")
                out.write(f"    ) WHERE tournament_id = t_id AND player_id = (\n")
                out.write(f"        SELECT id FROM players WHERE first_name = '{fname}' AND last_name = '{lname}' AND phone = '{phone}'\n")
                out.write(f"    );\n")

        out.write("END $$;\n")

if __name__ == '__main__':
    generate_sql()
    print("Generated seed_presidentes.sql")
