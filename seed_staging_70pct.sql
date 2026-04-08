-- SYNTHETIC SEED DATA: 70% CAPACITY
-- Projected Max Matches: 558
-- Target Matches Generated: 390
-- Total Simulated Players: 222

DO $$
DECLARE
    t_id UUID;
    c_Varonil UUID := (SELECT id FROM categories WHERE name = 'Varonil' LIMIT 1);
    c_Femenil UUID := (SELECT id FROM categories WHERE name = 'Femenil' LIMIT 1);
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
    VALUES ('Staging Cup 70Pct', '2026-04-09', '2026-04-29', 6, 'active')
    ON CONFLICT (name) DO UPDATE SET start_date = EXCLUDED.start_date, end_date = EXCLUDED.end_date, num_courts = EXCLUDED.num_courts
    RETURNING id INTO t_id;

    -- INSERT SYNTHETIC PLAYERS & REGISTRATIONS
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gomez 1396', '5558432113')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gomez 9655', '5553145221')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Ruiz 3642', '5559043091')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Martinez 5003', '5552692733')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Garcia 6127', '5554469424')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Fernandez 898', '5559070084')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Sanchez 9857', '5559552323')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Ruiz 772', '5555071881')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Diaz 9420', '5558213313')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gonzalez 3268', '5559948118')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Torres 8452', '5559889185')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Rodriguez 797', '5553461175')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Garcia 2312', '5557068395')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Garcia 9285', '5556590221')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Diaz 9855', '5559698790')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gomez 5870', '5555498538')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Garcia 4475', '5555700160')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Diaz 2178', '5559316367')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Fernandez 5734', '5555889767')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Garcia 4585', '5558609416')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Diaz 4214', '5554921511')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Perez 5383', '5559973552')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Garcia 699', '5551088628')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Lopez 8112', '5557279816')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Martinez 4617', '5557753859')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Garcia 9807', '5553938269')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Martinez 1638', '5555862870')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gonzalez 5271', '5558761802')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Gomez 1718', '5551733160')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Gomez 5491', '5553595960')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Sanchez 4188', '5559507542')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Lopez 5105', '5558033825')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Martinez 8891', '5554095898')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Gomez 1578', '5559142147')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Rodriguez 5720', '5557006719')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez 6913', '5553893599')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Fernandez 4000', '5554289130')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Lopez 5271', '5555065880')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Martinez 7290', '5553905484')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Martinez 2330', '5553162673')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Ruiz 4879', '5553177996')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Fernandez 4031', '5554947221')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Torres 6067', '5558152950')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gonzalez 4419', '5557442472')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Martinez 1341', '5558665740')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Gonzalez 9458', '5556029164')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Lopez 2719', '5555426614')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Lopez 6388', '5558412636')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Rodriguez 3066', '5554066065')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Perez 9111', '5559237349')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Diaz 3859', '5557830023')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Garcia 5622', '5555728461')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Lopez 9288', '5551173039')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gonzalez 9542', '5559391899')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Fernandez 6170', '5551321116')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gomez 8072', '5557527298')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gonzalez 99', '5551825961')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Diaz 4063', '5558638811')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Sanchez 5733', '5555511733')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Ruiz 2936', '5556047963')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Rodriguez 9110', '5558920211')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Fernandez 3166', '5558482483')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Diaz 8848', '5556377233')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Perez 4382', '5559891583')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gomez 4988', '5555284632')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gomez 244', '5555525133')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Martinez 3137', '5557443803')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Fernandez 5210', '5555083682')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Gomez 1817', '5551845718')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz 409', '5553452106')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Torres 7678', '5558036516')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Torres 15', '5555961130')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Perez 2932', '5559504154')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Torres 5005', '5554098528')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Martinez 8495', '5554970294')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 174', '5553121398')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gomez 4446', '5551270800')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Fernandez 2980', '5553738009')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Diaz 4401', '5554994896')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Lopez 3849', '5556768966')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Torres 2009', '5558018551')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Garcia 9197', '5557649973')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Ruiz 777', '5553307567')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Perez 8754', '5559029692')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gomez 7053', '5556828270')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Perez 9015', '5557287297')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Diaz 4677', '5554720654')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Rodriguez 1000', '5556086646')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Fernandez 4079', '5559162261')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Rodriguez 5580', '5556473240')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Sanchez 5058', '5553342568')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Sanchez 5025', '5554469356')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Lopez 9914', '5558804094')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Perez 7163', '5551094410')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Ruiz 5420', '5556200125')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Sanchez 5844', '5559592400')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Rodriguez 3486', '5558284191')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Torres 4318', '5554674697')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Lopez 9224', '5552082995')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Gomez 5017', '5554356424')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Garcia 4553', '5556199949')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Rodriguez 6408', '5557306444')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Torres 5124', '5553407957')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gonzalez 8345', '5551543833')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Torres 6283', '5559829233')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Perez 8091', '5551341057')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gonzalez 3612', '5551491010')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Sanchez 5027', '5554946016')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Garcia 8581', '5555604763')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Perez 346', '5557846909')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Fernandez 8261', '5556160795')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Perez 821', '5556394583')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Fernandez 5457', '5552787137')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Lopez 4971', '5552580844')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Perez 3005', '5559329694')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Diaz 2119', '5557748726')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Perez 4114', '5558182324')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Gonzalez 2774', '5555906860')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Sanchez 326', '5556575494')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Lopez 9524', '5553662574')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Rodriguez 249', '5551253169')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Garcia 6925', '5553193642')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Sanchez 1128', '5553343742')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz 1440', '5552901997')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Lopez 4921', '5558835218')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Garcia 3393', '5557686978')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Lopez 3194', '5554050986')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Fernandez 7584', '5558161690')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Fernandez 4481', '5556655938')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Sanchez 582', '5558337166')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Gonzalez 697', '5554317590')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Lopez 3214', '5557529254')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Fernandez 4534', '5556862666')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Perez 4044', '5558510237')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 5686', '5553904678')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Gomez 7153', '5557359441')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Sanchez 607', '5556860189')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez 5991', '5559710453')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Garcia 319', '5553408390')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Torres 193', '5555713170')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Torres 3312', '5555730887')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Sanchez 896', '5553149692')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Ruiz 3601', '5558581926')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Sanchez 8684', '5559945167')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Torres 4507', '5556302014')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Rodriguez 5955', '5556445958')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Rodriguez 1145', '5558865975')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz 9646', '5559269729')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Sanchez 4214', '5552931330')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Rodriguez 8335', '5557489765')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Lopez 4885', '5556482192')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz 1862', '5558943438')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gomez 8266', '5559322637')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Sanchez 514', '5555638941')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Lopez 7167', '5557305696')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Sanchez 3901', '5554671813')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Perez 2213', '5559818782')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Gomez 3964', '5554214885')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Diaz 5642', '5558840242')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Lopez 25', '5555861597')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Gomez 2539', '5553139823')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez 7001', '5559970412')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Ruiz 6496', '5556731355')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Gomez 5296', '5558771147')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Lopez 6895', '5557281234')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Garcia 1821', '5558345178')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Lopez 3537', '5555292375')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Gomez 6050', '5552078938')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Perez 4279', '5554338725')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Gonzalez 8626', '5555193571')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Perez 9308', '5555236672')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Sanchez 8422', '5557588314')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Rodriguez 2857', '5552475313')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Martinez 5555', '5558158908')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez 6270', '5558586624')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Perez 9346', '5559139468')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Lopez 8772', '5553706384')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Fernandez 3191', '5555730845')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Rodriguez 2414', '5552949179')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Fernandez 9900', '5555108984')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Sanchez 2467', '5554975201')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Rodriguez 2542', '5557641142')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Perez 439', '5551563721')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Diaz 8435', '5556143378')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Rodriguez 2096', '5557240284')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Gomez 8931', '5554263895')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Fernandez 7846', '5558257203')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Martinez 9278', '5553613920')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Fernandez 2442', '5558209523')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gonzalez 6285', '5555636756')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Sanchez 1122', '5555787071')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gonzalez 5463', '5554445194')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Garcia 311', '5555831553')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Diaz 6022', '5553678670')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Sanchez 3235', '5553453604')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gomez 6900', '5551681479')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Gomez 9572', '5558430768')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Diaz 6474', '5552417136')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez 3715', '5559343820')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Torres 9240', '5558824859')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Gonzalez 7343', '5555490683')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Diaz 755', '5557581325')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Perez 375', '5559658459')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Diaz 6769', '5557119997')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Perez 31', '5555747723')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Fernandez 1008', '5552761003')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Diaz 3008', '5557918114')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Rodriguez 9631', '5556018159')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Sanchez 24', '5559721142')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz 6851', '5558279996')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gonzalez 1881', '5553630313')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Rodriguez 731', '5552001722')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Diaz 7824', '5555425787')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Fernandez 8074', '5552772913')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gonzalez 7030', '5552334428')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Martinez 8973', '5554873511')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Lopez 8615', '5558083225')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Sanchez 8166', '5553131443')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Torres 4593', '5552878118')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Ruiz 227', '5554848005')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Perez 846', '5553180723')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 2872', '5551401611')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
END $$;
