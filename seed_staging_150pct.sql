-- SYNTHETIC SEED DATA: 150% CAPACITY
-- Projected Max Matches: 324
-- Target Matches Generated: 486
-- Total Simulated Players: 277

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
    VALUES ('Staging Cup 150Pct', '2026-04-09', '2026-04-20', 6, 'active')
    ON CONFLICT (name) DO UPDATE SET start_date = EXCLUDED.start_date, end_date = EXCLUDED.end_date, num_courts = EXCLUDED.num_courts
    RETURNING id INTO t_id;

    -- INSERT SYNTHETIC PLAYERS & REGISTRATIONS
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Sanchez 671', '5555375381')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Fernandez 1464', '5556797606')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Sanchez 5255', '5559234524')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Fernandez 165', '5558612038')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Sanchez 6266', '5552040804')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Ruiz 6821', '5555842240')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Gonzalez 3197', '5557673366')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Rodriguez 3181', '5557758400')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Torres 4130', '5556232976')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez 3998', '5555382504')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Sanchez 9526', '5552052530')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gonzalez 2801', '5553311782')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Lopez 7366', '5557638818')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Martinez 185', '5554830534')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Garcia 73', '5552080815')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Torres 9958', '5555149951')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gonzalez 9920', '5559819397')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Garcia 6950', '5555944977')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Garcia 3445', '5551350687')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Rodriguez 2911', '5558261566')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Torres 4321', '5553024571')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Gomez 5007', '5559707729')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Garcia 6601', '5556031956')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Lopez 116', '5559511713')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Martinez 3276', '5556735376')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Ruiz 4151', '5555770675')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Gonzalez 4465', '5554976158')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Ruiz 6353', '5552527001')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Martinez 4726', '5552493091')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Lopez 3189', '5552817900')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz 6223', '5559666600')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Lopez 8247', '5551052571')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Torres 1406', '5559463740')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Torres 2777', '5559006310')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Gonzalez 1336', '5552827174')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Martinez 7582', '5557809099')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Ruiz 6730', '5556010176')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ruiz 5834', '5553866556')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Ruiz 5390', '5554724256')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Sanchez 4500', '5551627892')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Martinez 1383', '5552972717')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Fernandez 5545', '5558747074')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Martinez 3302', '5558907484')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Fernandez 4117', '5556644705')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Sanchez 4684', '5552524344')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Gonzalez 1883', '5553405511')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Lopez 1621', '5558769934')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Perez 5556', '5554575542')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Sanchez 930', '5555346077')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Diaz 9520', '5557000043')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gonzalez 3148', '5553475229')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Sanchez 8381', '5552796637')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Rodriguez 4949', '5552968979')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Sanchez 6892', '5554972069')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Fernandez 7504', '5553235150')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gonzalez 3687', '5559511123')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Lopez 9787', '5557538334')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Perez 2200', '5551035243')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gomez 7152', '5554150660')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Torres 5710', '5555968144')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Torres 2277', '5558252213')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz 6938', '5552225280')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Gomez 3489', '5555429727')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Sanchez 7620', '5556741737')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Sanchez 6798', '5554223187')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Fernandez 6372', '5554651172')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz 107', '5556234139')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Martinez 5021', '5552018366')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Perez 1129', '5558610508')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Lopez 537', '5556494000')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Torres 9644', '5553519699')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Rodriguez 5842', '5553415620')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Perez 6663', '5557509728')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Lopez 1479', '5553450875')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Ruiz 7814', '5553575498')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Gomez 2651', '5556616032')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Diaz 5543', '5558154204')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Ruiz 7581', '5552430029')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Ruiz 1124', '5553861786')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Diaz 5656', '5551277103')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Ruiz 5348', '5555348201')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Sanchez 2983', '5554509512')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Sanchez 1045', '5558060910')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Martinez 9909', '5557433467')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Garcia 1370', '5559242481')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Perez 697', '5558855025')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Perez 5153', '5553665254')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Garcia 3893', '5556109144')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Fernandez 7509', '5556121004')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Rodriguez 6220', '5555745100')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Perez 2521', '5556528482')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Ruiz 2162', '5555217603')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Sanchez 873', '5554604190')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Diaz 245', '5554634921')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Gomez 3701', '5553936793')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez 7500', '5555220598')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Sanchez 7037', '5555595176')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Rodriguez 2338', '5554235929')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Ruiz 5064', '5555756647')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Perez 5153', '5555792300')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz 1697', '5551980652')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Gonzalez 7238', '5559333085')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Diaz 4624', '5557277032')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Gonzalez 1025', '5552581922')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Torres 8949', '5559043242')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Sanchez 4259', '5555383197')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Ruiz 1499', '5559371478')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Garcia 6183', '5552669543')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gomez 2328', '5559920360')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Lopez 7694', '5551539480')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Lopez 550', '5552233029')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Fernandez 2387', '5559704391')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Diaz 4558', '5552846537')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gonzalez 695', '5558646715')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Rodriguez 5939', '5559945126')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Martinez 8166', '5551156381')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Rodriguez 2596', '5557857441')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gonzalez 8597', '5558120542')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Garcia 1050', '5557851634')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Perez 5752', '5553705064')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Diaz 3969', '5556752014')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Fernandez 7407', '5555547642')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gomez 8199', '5555575890')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Ruiz 3238', '5554443421')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Gomez 6488', '5553449109')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 2894', '5555619735')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gomez 9639', '5552414239')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Diaz 5755', '5551550128')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gonzalez 8814', '5558544168')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Rodriguez 9855', '5557377019')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gomez 1909', '5553062745')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Sanchez 453', '5559100065')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gomez 3482', '5555758112')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Martinez 5372', '5552481657')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Torres 2249', '5554356724')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Fernandez 1023', '5557641407')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Diaz 3034', '5556454705')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gonzalez 8379', '5552709198')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Sanchez 9929', '5551490589')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Lopez 2336', '5551123399')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Ruiz 1133', '5552211412')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Gomez 4932', '5551861888')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Fernandez 3951', '5553474577')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez 1251', '5554950539')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Garcia 7029', '5557804612')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Rodriguez 437', '5553473040')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Sanchez 1933', '5557111773')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez 9720', '5554867428')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Lopez 428', '5558508153')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Garcia 9930', '5556039037')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Rodriguez 9321', '5553283782')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gonzalez 8316', '5559364614')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Torres 5732', '5557259995')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Martinez 167', '5551648986')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Perez 3147', '5552220345')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Sanchez 3646', '5556182358')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Torres 1404', '5558024964')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Ruiz 3771', '5556136962')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Fernandez 4853', '5551369539')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gomez 3668', '5554383621')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Diaz 3335', '5559283611')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz 2359', '5553514116')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Perez 8206', '5559942860')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 696', '5552002532')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Diaz 4238', '5558341330')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Garcia 294', '5551638133')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Rodriguez 424', '5556969178')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Lopez 4519', '5556003309')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gomez 7669', '5558328087')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Sanchez 9385', '5551734180')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Torres 9296', '5557791883')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Ruiz 6329', '5554847438')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Lopez 7241', '5553219770')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Lopez 9471', '5559541408')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Rodriguez 1058', '5558497279')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Diaz 9557', '5554775285')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Perez 3257', '5554974723')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Gomez 7287', '5559027442')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Diaz 1292', '5553840361')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz 8948', '5559058792')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gonzalez 5364', '5559421310')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Sanchez 1362', '5551928973')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Garcia 341', '5553664706')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez 6804', '5553341556')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Garcia 9339', '5559856846')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Garcia 9157', '5557299364')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Gonzalez 4925', '5552320383')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Gomez 7828', '5554731816')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Sanchez 4221', '5557401220')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Martinez 5190', '5553354703')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Garcia 6594', '5558031098')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Perez 9064', '5557768494')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Gomez 1817', '5551016340')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Ruiz 7211', '5551383054')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Fernandez 1745', '5553957832')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Torres 9145', '5559152609')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Torres 9126', '5556965548')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Rodriguez 8806', '5558237009')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Martinez 4947', '5558377537')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Lopez 722', '5559053080')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Lopez 3427', '5555181926')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Gonzalez 4212', '5556831709')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Lopez 8588', '5555645290')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Garcia 9407', '5552538539')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Martinez 7523', '5554665885')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Perez 1502', '5558289180')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Perez 562', '5559487761')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Gonzalez 3515', '5553101984')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Diaz 157', '5553342589')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Fernandez 5478', '5558001180')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Rodriguez 5284', '5559190707')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gomez 9048', '5556077768')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gomez 6771', '5559223670')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Lopez 4019', '5553853246')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Garcia 2951', '5555850053')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Perez 7006', '5556546309')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Garcia 6146', '5554761394')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Perez 4847', '5556733863')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Torres 5771', '5559306634')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Fernandez 4723', '5552145744')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Torres 4126', '5555053177')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gomez 940', '5557723965')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Ruiz 2133', '5552387967')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Ruiz 1247', '5553249403')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Sanchez 764', '5551749245')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Martinez 6269', '5553543981')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gonzalez 8156', '5556282426')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Lopez 6171', '5558388801')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Torres 4833', '5554521584')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Garcia 5689', '5555992243')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Lopez 818', '5559956643')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Gomez 4109', '5559638119')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Fernandez 3921', '5552288833')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Sanchez 4840', '5559983778')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Gomez 2942', '5555262694')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Sanchez 3034', '5556568936')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Fernandez 3104', '5557165903')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Perez 4934', '5553438828')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Garcia 1427', '5558165967')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Rodriguez 1388', '5558098456')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Martinez 7389', '5557568180')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Lopez 4834', '5555923680')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gomez 3700', '5553922474')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Sanchez 5686', '5558555949')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Lopez 4909', '5556015122')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Gonzalez 1412', '5555147347')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Gonzalez 5157', '5557419599')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Rodriguez 4029', '5552358107')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Lopez 5535', '5553556627')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Gonzalez 9237', '5552465136')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Fernandez 1969', '5559039337')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz 932', '5556053172')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Diaz 9099', '5558363778')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Rodriguez 5228', '5552172757')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Ruiz 549', '5552732668')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Fernandez 8295', '5558846394')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Ruiz 6031', '5557985620')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Torres 3820', '5557788944')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Lopez 5464', '5552045212')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Gomez 2667', '5556896788')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Garcia 3785', '5557263288')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Torres 61', '5557689048')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ruiz 6761', '5552785060')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Perez 5689', '5557235598')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Garcia 7351', '5559649137')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Diaz 7285', '5555885851')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Perez 4959', '5554083019')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Ruiz 2789', '5559077994')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Rodriguez 6185', '5559956081')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gonzalez 2092', '5556481234')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Fernandez 6708', '5556864335')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Lopez 9356', '5559555718')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Diaz 2713', '5557071433')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Garcia 743', '5552395254')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Perez 6517', '5557647091')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Ruiz 7579', '5552888813')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Lopez 4599', '5556874010')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
END $$;
