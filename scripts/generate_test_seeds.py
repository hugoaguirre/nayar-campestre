# -*- coding: utf-8 -*-
import os
import sys
import argparse
from datetime import datetime, timedelta
import random

# Add parent to path to import core logic
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
try:
    from core.capacity_planner import calculate_max_capacity
except ImportError:
    # Fallback if run standalone without the core package correctly linked
    def calculate_max_capacity(start_date_str, end_date_str, num_courts=6):
        start_date = datetime.strptime(start_date_str, "%Y-%m-%d")
        end_date = datetime.strptime(end_date_str, "%Y-%m-%d")
        total_slots = 0
        curr_day = start_date
        while curr_day <= end_date:
            weekday = curr_day.weekday()
            if 1 <= weekday <= 4: total_slots += 4
            elif weekday == 5: total_slots += 8
            elif weekday == 6: total_slots += 7
            curr_day += timedelta(days=1)
        return total_slots * num_courts

def generate_synthetic_sql(percent_capacity, num_courts, days_duration):
    """
    Synthesizes a full SQL seed payload based on a mathematical percentage of club capacity.
    """
    # 1. Establish temporal boundaries
    start_date = datetime.today()
    # Ensure it starts on a Thursday to span the weekends realistically
    while start_date.weekday() != 3: 
        start_date += timedelta(days=1)
        
    end_date = start_date + timedelta(days=days_duration)
    
    start_str = start_date.strftime('%Y-%m-%d')
    end_str = end_date.strftime('%Y-%m-%d')
    
    # 2. Mathematically Project Target Players
    max_slots = calculate_max_capacity(start_str, end_str, num_courts)
    target_matches = int(max_slots * (percent_capacity / 100.0))
    # Formula: ~1.75 matches per active registration participation
    target_players = int(target_matches / 1.75)
    
    # 3. Random Generation Seed Data
    categories = ["Varonil", "Varonil", "Varonil", "Femenil", "Femenil"]
    subcategories = ["AA", "A", "B+", "B", "C", "D", "Mini-Tenis", "8-10 años"]
    first_names = ["Carlos", "Maria", "Jorge", "Lucia", "Hugo", "Ana", "Miguel", "Sofia", "David", "Emma", "Alejandro", "Valeria", "Diego", "Carmen", "Javier"]
    last_names = ["Garcia", "Martinez", "Lopez", "Gonzalez", "Rodriguez", "Fernandez", "Perez", "Gomez", "Sanchez", "Diaz", "Torres", "Ruiz"]
    
    t_name = f"Staging Cup {percent_capacity}Pct"
    sql_filename = f"seed_staging_{percent_capacity}pct.sql"
    file_path = os.path.join(os.path.dirname(os.path.dirname(__file__)), sql_filename)
    
    with open(file_path, 'w', encoding='utf-8') as out:
        out.write(f"-- SYNTHETIC SEED DATA: {percent_capacity}% CAPACITY\n")
        out.write(f"-- Projected Max Matches: {max_slots}\n")
        out.write(f"-- Target Matches Generated: {target_matches}\n")
        out.write(f"-- Total Simulated Players: {target_players}\n\n")
        
        out.write("DO $$\n")
        out.write("DECLARE\n")
        out.write("    t_id UUID;\n")
        
        for c in set(categories):
            var_name = "".join(x if x.isalnum() else "_" for x in c)
            out.write(f"    c_{var_name} UUID := (SELECT id FROM categories WHERE name = '{c}' LIMIT 1);\n")
        
        for s in subcategories:
            var_name = "".join(x if x.isalnum() else "_" for x in s)
            out.write(f"    s_{var_name} UUID := (SELECT id FROM subcategories WHERE name = '{s}' LIMIT 1);\n")
            
        out.write("BEGIN\n")
        # Ensure parent tournament exists
        out.write(f"    -- Insert Synthetic Tournament\n")
        out.write(f"    INSERT INTO tournaments (name, start_date, end_date, num_courts, status)\n")
        out.write(f"    VALUES ('{t_name}', '{start_str}', '{end_str}', {num_courts}, 'active')\n")
        out.write(f"    ON CONFLICT (name) DO UPDATE SET start_date = EXCLUDED.start_date, end_date = EXCLUDED.end_date, num_courts = EXCLUDED.num_courts\n")
        out.write(f"    RETURNING id INTO t_id;\n\n")

        out.write("    -- INSERT SYNTHETIC PLAYERS & REGISTRATIONS\n")
        
        generated_players = []
        for i in range(target_players):
            fname = random.choice(first_names)
            lname = f"{random.choice(last_names)} {random.randint(1, 9999)}" # Suffix prevents collision
            phone = f"555{random.randint(1000000, 9999999)}"
            cat = random.choice(categories)
            scat = random.choice(subcategories)
            
            c_var = "".join(x if x.isalnum() else "_" for x in cat)
            s_var = "".join(x if x.isalnum() else "_" for x in scat)
            
            # Everyone plays singles for staging, 40% play doubles
            is_doubles = random.random() < 0.4
            
            out.write(f"    WITH new_player AS (\n")
            out.write(f"        INSERT INTO players (first_name, last_name, phone)\n")
            out.write(f"        VALUES ('{fname}', '{lname}', '{phone}')\n")
            out.write(f"        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone\n")
            out.write(f"        RETURNING id\n")
            out.write(f"    )\n")
            out.write(f"    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)\n")
            out.write(f"    SELECT t_id, id, c_{c_var}, s_{s_var}, true, {str(is_doubles).lower()}, 'Pagado'\n")
            out.write(f"    FROM new_player;\n")
            
            if is_doubles:
                generated_players.append({"fname": fname, "lname": lname, "cat": cat, "scat": scat})

        out.write("END $$;\n")
        
    print(f"Generated {sql_filename} -> {target_players} Players (Capacity: {percent_capacity}%)")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Generate synthetic staging seeds based on mathematical club capacity.")
    parser.add_argument("percent", type=int, nargs='?', default=100, help="Target capacity percentage (e.g., 80 for Normal, 150 for Overflow)")
    parser.add_argument("--courts", type=int, default=6, help="Number of physical courts (default 6)")
    parser.add_argument("--days", type=int, default=11, help="Tournament duration in days (default 11, wraps two weekends)")
    
    args = parser.parse_args()
    generate_synthetic_sql(args.percent, args.courts, args.days)
