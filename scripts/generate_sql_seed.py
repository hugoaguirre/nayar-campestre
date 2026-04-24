# -*- coding: utf-8 -*-
import os
import sys
import argparse
from datetime import datetime, timedelta
import random

def calculate_max_capacity(start_date, end_date, num_courts=6):
    total_slots = 0
    curr_day = start_date
    while curr_day <= end_date:
        weekday = curr_day.weekday()
        if 1 <= weekday <= 4: total_slots += 4
        elif weekday == 5: total_slots += 8
        elif weekday == 6: total_slots += 7
        curr_day += timedelta(days=1)
    return total_slots * num_courts

def generate_synthetic_sql(t_name, start_date_raw, end_date_raw, exclude_cats, percent_capacity, num_courts=6):
    try:
        start_date = datetime.strptime(start_date_raw, "%m/%d/%Y")
        end_date = datetime.strptime(end_date_raw, "%m/%d/%Y")
    except ValueError:
        print("Error: Dates must be in MM/DD/YYYY format.")
        return False
        
    start_str = start_date.strftime('%Y-%m-%d')
    end_str = end_date.strftime('%Y-%m-%d')
    
    max_slots = calculate_max_capacity(start_date, end_date, num_courts)
    if max_slots == 0:
        print("Error: Invalid date range (zero schedule slots generated).")
        return False
        
    target_matches = int(max_slots * (percent_capacity / 100.0))
    target_players = int(target_matches / 1.75)
    
    categories = ["Varonil", "Femenil"]
    all_subcategories = ["AA", "A", "B+", "B", "C", "D", "Mini-Tenis", "8-10 años"]
    
    # Process exclusions
    excludes = [e.strip() for e in exclude_cats.split(",")] if exclude_cats else []
    subcategories = [s for s in all_subcategories if s not in excludes]
    
    if not subcategories:
        print("Error: All categories have been excluded.")
        return False
        
    male_names = ["Carlos", "Jorge", "Hugo", "Miguel", "David", "Alejandro", "Diego", "Javier", "Luis", "Roberto", "Daniel", "Fernando", "Ricardo", "Eduardo"]
    female_names = ["Maria", "Lucia", "Ana", "Sofia", "Emma", "Valeria", "Carmen", "Laura", "Daniela", "Camila", "Isabella", "Valentina", "Victoria", "Martina"]
    last_names = ["Garcia", "Martinez", "Lopez", "Gonzalez", "Rodriguez", "Fernandez", "Perez", "Gomez", "Sanchez", "Diaz", "Torres", "Ruiz", "Ramirez", "Flores"]
    
    sql_filename = f"seed_{t_name.replace(' ', '_').lower()}.sql"
    file_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), sql_filename)
    
    with open(file_path, 'w', encoding='utf-8') as out:
        out.write(f"-- SYNTHETIC SEED DATA: {t_name} \n")
        out.write(f"-- Target Capacity: {percent_capacity}%\n")
        out.write(f"-- Projected Max Matches: {max_slots}\n")
        out.write(f"-- Target Matches Generated: {target_matches}\n\n")
        
        out.write("DO $$\n")
        out.write("DECLARE\n")
        out.write("    t_id UUID;\n")
        
        for c in set(categories):
            var_name = "".join(x if x.isalnum() else "_" for x in c)
            out.write(f"    c_{var_name} UUID := (SELECT id FROM categories WHERE name = '{c}' LIMIT 1);\n")
        
        for s in set(subcategories):
            var_name = "".join(x if x.isalnum() else "_" for x in s)
            out.write(f"    s_{var_name} UUID := (SELECT id FROM subcategories WHERE name = '{s}' LIMIT 1);\n")
            
        out.write("BEGIN\n")
        out.write(f"    SELECT id INTO t_id FROM tournaments WHERE name = '{t_name}' LIMIT 1;\n")
        out.write(f"    IF t_id IS NULL THEN\n")
        out.write(f"        INSERT INTO tournaments (name, start_date, end_date, num_courts, status)\n")
        out.write(f"        VALUES ('{t_name}', '{start_str}', '{end_str}', {num_courts}, 'active')\n")
        out.write(f"        RETURNING id INTO t_id;\n")
        out.write(f"    ELSE\n")
        out.write(f"        UPDATE tournaments SET start_date = '{start_str}', end_date = '{end_str}', num_courts = {num_courts} WHERE id = t_id;\n")
        out.write(f"    END IF;\n\n")

        out.write("    -- INSERT SYNTHETIC PLAYERS & REGISTRATIONS\n")
        
        total_players_generated = 0
        s_only = 0
        d_only = 0
        both_only = 0
        current_match_cost = 0.0
        
        while current_match_cost < target_matches:
            cat = random.choice(categories)
            scat = random.choice(subcategories)
            
            if cat == "Femenil":
                fname = random.choice(female_names)
            else:
                fname = random.choice(male_names)
                
            lname = f"{random.choice(last_names)} {random.choice(last_names)}"
            phone = f"55{random.randint(10000000, 99999999)}"
            
            c_var = "".join(x if x.isalnum() else "_" for x in cat)
            s_var = "".join(x if x.isalnum() else "_" for x in scat)
            
            rand_val = random.random()
            if rand_val < 0.35:
                # Singles Only
                is_singles = True
                is_doubles = False
                current_match_cost += 1.5
                s_only += 1
            elif rand_val < 0.65:
                # Doubles Only
                is_singles = False
                is_doubles = True
                current_match_cost += 0.75 # Costs half per person
                d_only += 1
            else:
                # Both
                is_singles = True
                is_doubles = True
                current_match_cost += 2.25
                both_only += 1
            
            out.write(f"    WITH new_player AS (\n")
            out.write(f"        INSERT INTO players (first_name, last_name, phone)\n")
            out.write(f"        VALUES ('{fname}', '{lname}', '{phone}')\n")
            out.write(f"        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone\n")
            out.write(f"        RETURNING id\n")
            out.write(f"    )\n")
            out.write(f"    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)\n")
            out.write(f"    SELECT t_id, id, c_{c_var}, s_{s_var}, {str(is_singles).lower()}, {str(is_doubles).lower()}, 'Pagado'\n")
            out.write(f"    FROM new_player;\n")
            
            total_players_generated += 1

        # AUTO-PAIR DOUBLES
        out.write("    -- LINK DOUBLES PARTNERS AUTOMATICALLY\n")
        out.write("    WITH doubles_players AS (\n")
        out.write("        SELECT id as reg_id, player_id, category_id, subcategory_id,\n")
        out.write("               row_number() OVER (PARTITION BY category_id, subcategory_id ORDER BY random()) as rn\n")
        out.write("        FROM tournament_registrations\n")
        out.write("        WHERE is_doubles = true AND tournament_id = t_id\n")
        out.write("    ),\n")
        out.write("    pairs AS (\n")
        out.write("        SELECT d1.reg_id as r1, d2.player_id as p2\n")
        out.write("        FROM doubles_players d1\n")
        out.write("        JOIN doubles_players d2 ON d1.category_id = d2.category_id \n")
        out.write("                                AND d1.subcategory_id = d2.subcategory_id\n")
        out.write("                                AND ((d1.rn % 2 <> 0 AND d2.rn = d1.rn + 1) OR (d1.rn % 2 = 0 AND d2.rn = d1.rn - 1))\n")
        out.write("    )\n")
        out.write("    UPDATE tournament_registrations tr\n")
        out.write("    SET partner_id = pairs.p2\n")
        out.write("    FROM pairs\n")
        out.write("    WHERE tr.id = pairs.r1;\n\n")
        out.write("    -- STRIP DOUBLES FLAG FROM THE ODD-MAN-OUT REMAINDERS\n")
        out.write("    UPDATE tournament_registrations\n")
        out.write("    SET is_doubles = false\n")
        out.write("    WHERE partner_id IS NULL AND is_doubles = true AND tournament_id = t_id;\n\n")
        out.write("    -- IF THEY LOST THEIR ONLY MODALITY, FORCE THEM INTO SINGLES\n")
        out.write("    UPDATE tournament_registrations\n")
        out.write("    SET is_singles = true\n")
        out.write("    WHERE is_singles = false AND is_doubles = false AND tournament_id = t_id;\n\n")
        out.write("END $$;\n")
        
    print(f"Generated: {sql_filename}")
    print(f" => Target Players Matched: {total_players_generated}")
    print(f"    - Singles Only: {s_only}")
    print(f"    - Doubles Only: {d_only}")
    print(f"    - Hybrid (Both): {both_only}")
    print(f" => Total Physical Matches Represented: {current_match_cost}")
    return True

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Universal Random Tournament Seed Generator")
    parser.add_argument("-t", "--tournament", type=str, required=True, help="Tournament name")
    parser.add_argument("-d", "--dates", type=str, required=True, help="Tournament dates 'MM/DD/YYYY MM/DD/YYYY'")
    parser.add_argument("-e", "--exclude", type=str, default="", help="Exclude categories (comma separated, e.g. 'AA,A')")
    parser.add_argument("-c", "--capacity", type=int, required=True, help="Percentage capacity (e.g. 98)")
    
    args = parser.parse_args()
    
    date_parts = args.dates.strip().split(" ")
    if len(date_parts) != 2:
        print("Error: -d flag must be strictly formatted 'MM/DD/YYYY MM/DD/YYYY' separated by space.")
        sys.exit(1)
        
    start_dt, end_dt = date_parts[0], date_parts[1]
    generate_synthetic_sql(args.tournament, start_dt, end_dt, args.exclude, args.capacity)
