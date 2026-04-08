-- SYNTHETIC SEED DATA: 80% CAPACITY
-- Projected Max Matches: 324
-- Target Matches Generated: 259
-- Total Simulated Players: 148

DO $$
DECLARE
    t_id UUID;
    c_Femenil UUID := (SELECT id FROM categories WHERE name = 'Femenil' LIMIT 1);
    c_Varonil UUID := (SELECT id FROM categories WHERE name = 'Varonil' LIMIT 1);
    s_AA UUID := (SELECT id FROM subcategories WHERE name = 'AA' LIMIT 1);
    s_A UUID := (SELECT id FROM subcategories WHERE name = 'A' LIMIT 1);
    s_B_ UUID := (SELECT id FROM subcategories WHERE name = 'B+' LIMIT 1);
    s_B UUID := (SELECT id FROM subcategories WHERE name = 'B' LIMIT 1);
    s_C UUID := (SELECT id FROM subcategories WHERE name = 'C' LIMIT 1);
    s_D UUID := (SELECT id FROM subcategories WHERE name = 'D' LIMIT 1);
    s_Mini_Tenis UUID := (SELECT id FROM subcategories WHERE name = 'Mini-Tenis' LIMIT 1);
    s_8_10_años UUID := (SELECT id FROM subcategories WHERE name = '8-10 años' LIMIT 1);
BEGIN
    -- Insert Synthetic Tournament
    INSERT INTO tournaments (name, start_date, end_date, num_courts, status)
    VALUES ('Staging Cup 80Pct', '2026-04-09', '2026-04-20', 6, 'active')
    ON CONFLICT (name) DO UPDATE SET start_date = EXCLUDED.start_date, end_date = EXCLUDED.end_date, num_courts = EXCLUDED.num_courts
    RETURNING id INTO t_id;

    -- INSERT SYNTHETIC PLAYERS & REGISTRATIONS
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gomez 8058', '5557543480')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Perez 360', '5551967093')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Perez 6327', '5554469765')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Perez 8136', '5552191415')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez 7061', '5556397820')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Lopez 9349', '5558203185')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 8481', '5557385794')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Sanchez 1748', '5556864746')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Lopez 8780', '5559420921')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Ruiz 778', '5555211499')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Garcia 2469', '5555380679')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Sanchez 5365', '5556172708')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez 2759', '5556747490')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Gonzalez 5800', '5559293614')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Lopez 8557', '5558075637')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Garcia 6965', '5551562943')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Diaz 9955', '5551300087')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Diaz 7579', '5557343766')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Torres 6512', '5551854633')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz 856', '5557972130')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gomez 6157', '5551995541')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Ruiz 672', '5556743018')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Sanchez 3609', '5558063053')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz 7989', '5552744899')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Martinez 8800', '5555220209')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ruiz 295', '5559726207')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Diaz 9436', '5558397759')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Perez 3260', '5552032754')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 7301', '5552849373')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Diaz 6937', '5557281524')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Rodriguez 6761', '5556836900')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Rodriguez 7262', '5553010764')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Sanchez 3368', '5559352854')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Rodriguez 8360', '5556464664')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Sanchez 2850', '5551178381')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Sanchez 2512', '5554404039')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Lopez 9498', '5556672736')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Sanchez 8250', '5555737756')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Perez 9927', '5557068383')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gonzalez 9166', '5557524573')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Garcia 8139', '5551139043')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Ruiz 6015', '5557579066')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Ruiz 3241', '5553291794')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Garcia 270', '5552025993')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Diaz 2650', '5557062254')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Garcia 7550', '5551765495')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Ruiz 9075', '5554471583')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Perez 2049', '5554848790')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Perez 1960', '5556853777')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Lopez 5393', '5555227923')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Lopez 8937', '5555564371')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gomez 2099', '5553682264')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Rodriguez 8608', '5553089840')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Diaz 6521', '5551436365')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Garcia 2691', '5552266381')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Perez 5187', '5552576003')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Gomez 1402', '5558435380')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Perez 3400', '5558026023')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Ruiz 7693', '5559177603')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Lopez 4473', '5555278017')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Diaz 6093', '5554388566')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Perez 7369', '5551640203')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez 7496', '5556446770')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Lopez 4647', '5551143510')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Lopez 6745', '5551496927')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Diaz 5381', '5554855527')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Torres 7610', '5553784168')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Fernandez 7735', '5553988269')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Garcia 5940', '5551663719')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Rodriguez 435', '5554503978')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Torres 6090', '5552964205')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Gonzalez 5536', '5559337965')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Garcia 9528', '5551380196')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Martinez 7536', '5559614257')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Garcia 5815', '5557019200')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Fernandez 5247', '5553423213')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Lopez 1880', '5554831962')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Torres 5938', '5553620734')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez 8409', '5556927664')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Garcia 7869', '5559170477')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Rodriguez 5237', '5554477557')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Perez 5437', '5557618656')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Martinez 1762', '5559644906')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Perez 3098', '5551231507')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Rodriguez 5875', '5558889042')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Garcia 7735', '5558175944')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Torres 6004', '5558600911')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Diaz 2356', '5558783842')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Ruiz 6438', '5554461492')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Ruiz 6550', '5554468225')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Rodriguez 7544', '5558221107')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Lopez 6690', '5557212577')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Lopez 8987', '5551208775')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Rodriguez 6940', '5552253047')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Fernandez 780', '5555867961')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Ruiz 7404', '5559745388')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Torres 5973', '5552429337')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gomez 4050', '5553656795')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Martinez 3617', '5554790889')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Rodriguez 5925', '5551662024')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Torres 9294', '5554956929')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Gonzalez 6734', '5557272137')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Ruiz 8265', '5555767927')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Gonzalez 8766', '5559098901')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 6493', '5557508286')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Martinez 1814', '5555560262')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Sanchez 2974', '5558257019')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Garcia 2559', '5559117830')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Perez 7202', '5558416083')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Lopez 6917', '5557577382')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Fernandez 958', '5558588458')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Lopez 5842', '5553367897')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz 9616', '5558803308')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Perez 1895', '5555972498')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Garcia 9205', '5553068498')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Diaz 1440', '5554540857')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Garcia 1528', '5551460742')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Garcia 8599', '5554734312')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Perez 2794', '5554661899')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Martinez 1699', '5555618707')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Ruiz 5074', '5556563074')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Martinez 9016', '5554188593')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Diaz 8908', '5555095670')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Perez 5338', '5555732573')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Lopez 8550', '5558721984')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gomez 9371', '5553927814')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Martinez 1655', '5558511156')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Perez 2313', '5554231738')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Rodriguez 8223', '5551469441')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Lopez 234', '5555077148')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Martinez 3385', '5552511193')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gomez 9681', '5557283427')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Ruiz 1618', '5556166498')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Garcia 4121', '5555946469')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Fernandez 501', '5556119533')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gonzalez 3831', '5552686756')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Lopez 3867', '5559165202')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gonzalez 6729', '5553772337')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gomez 4008', '5556742110')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Martinez 4218', '5552803336')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Diaz 9871', '5553041474')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Martinez 4518', '5552935745')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Perez 6009', '5558471972')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Diaz 9513', '5552843473')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Sanchez 181', '5555091904')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Fernandez 9164', '5559904245')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Sanchez 3170', '5555014011')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Gomez 6843', '5559000546')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
END $$;
