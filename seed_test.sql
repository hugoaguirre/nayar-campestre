-- SYNTHETIC SEED DATA: test 
-- Target Capacity: 98%
-- Projected Max Matches: 462
-- Target Matches Generated: 452

DO $$
DECLARE
    t_id UUID;
    c_Femenil UUID := (SELECT id FROM categories WHERE name = 'Femenil' LIMIT 1);
    c_Varonil UUID := (SELECT id FROM categories WHERE name = 'Varonil' LIMIT 1);
    s_C UUID := (SELECT id FROM subcategories WHERE name = 'C' LIMIT 1);
    s_D UUID := (SELECT id FROM subcategories WHERE name = 'D' LIMIT 1);
    s_8_10_años UUID := (SELECT id FROM subcategories WHERE name = '8-10 años' LIMIT 1);
    s_B UUID := (SELECT id FROM subcategories WHERE name = 'B' LIMIT 1);
    s_A UUID := (SELECT id FROM subcategories WHERE name = 'A' LIMIT 1);
    s_B_ UUID := (SELECT id FROM subcategories WHERE name = 'B+' LIMIT 1);
    s_Mini_Tenis UUID := (SELECT id FROM subcategories WHERE name = 'Mini-Tenis' LIMIT 1);
BEGIN
    SELECT id INTO t_id FROM tournaments WHERE name = 'test' LIMIT 1;
    IF t_id IS NULL THEN
        INSERT INTO tournaments (name, start_date, end_date, num_courts, status)
        VALUES ('test', '2026-05-16', '2026-05-31', 6, 'active')
        RETURNING id INTO t_id;
    ELSE
        UPDATE tournaments SET start_date = '2026-05-16', end_date = '2026-05-31', num_courts = 6 WHERE id = t_id;
    END IF;

    -- INSERT SYNTHETIC PLAYERS & REGISTRATIONS
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Sanchez Lopez', '5534498584')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniel', 'Ruiz Flores', '5562846968')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Diaz Sanchez', '5590519047')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Gomez Garcia', '5555260891')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valentina', 'Gomez Diaz', '5539137195')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Gonzalez Garcia', '5593938157')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Rodriguez Gomez', '5539320003')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Ruiz Diaz', '5519532991')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez Torres', '5568128001')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Sanchez Perez', '5596648978')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Rodriguez Ruiz', '5560547539')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gomez Gomez', '5547801532')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Garcia Garcia', '5526666078')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Martinez Lopez', '5544138609')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ramirez Flores', '5523379235')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Torres Lopez', '5589287184')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Diaz Perez', '5539792941')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Gomez Perez', '5581595635')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Eduardo', 'Ruiz Rodriguez', '5572948210')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Lopez Flores', '5567886711')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Perez Rodriguez', '5512855978')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Ramirez Diaz', '5554567261')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Laura', 'Lopez Sanchez', '5562582284')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Torres Fernandez', '5526278444')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Sanchez Flores', '5511837167')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez Rodriguez', '5551875291')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Martinez Garcia', '5576163497')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Perez Lopez', '5549061385')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ramirez Torres', '5515587274')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Fernandez Rodriguez', '5525662098')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Garcia Perez', '5550869614')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Fernandez Martinez', '5555299205')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Garcia Rodriguez', '5555723691')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Flores Flores', '5542560943')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Garcia Torres', '5599211922')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Lopez Martinez', '5567095392')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Martinez Flores', '5559160330')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gomez Rodriguez', '5550685899')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Martinez Rodriguez', '5513699874')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Garcia Sanchez', '5543092838')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Rodriguez Sanchez', '5590577123')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Flores Sanchez', '5578126340')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Fernandez Rodriguez', '5542941537')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Fernandez Lopez', '5546100970')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Rodriguez Martinez', '5543804930')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Garcia Martinez', '5535208345')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Flores Gonzalez', '5546633401')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Ramirez Ruiz', '5517312781')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Lopez Sanchez', '5588095592')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Sanchez Fernandez', '5536577343')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Fernandez Rodriguez', '5536522180')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Gonzalez Torres', '5555224653')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Laura', 'Gomez Ramirez', '5543255155')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Garcia Ruiz', '5568175034')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Sanchez Garcia', '5560815153')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Garcia Gomez', '5521670984')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Perez Perez', '5563877249')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Fernandez Perez', '5536711579')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valentina', 'Gonzalez Ramirez', '5564607580')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Eduardo', 'Martinez Martinez', '5516847749')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Lopez Perez', '5530466121')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Torres Diaz', '5563267103')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Torres Lopez', '5568716982')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ramirez Flores', '5561345454')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Fernandez Sanchez', '5547984656')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Lopez Ramirez', '5532486548')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Fernandez Rodriguez', '5587321589')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Lopez Ruiz', '5579645558')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Sanchez Ramirez', '5581592273')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Rodriguez Ramirez', '5550771063')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Lopez Martinez', '5537764145')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Gonzalez Perez', '5540100938')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Sanchez Diaz', '5577290278')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Ruiz Martinez', '5564366634')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Sanchez Ruiz', '5594307415')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Torres Gomez', '5563062009')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ruiz Lopez', '5514333110')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniel', 'Lopez Rodriguez', '5555471244')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Flores Gomez', '5550757475')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Diaz Rodriguez', '5554412675')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Lopez Gomez', '5521527540')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Rodriguez Fernandez', '5521456559')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Sanchez Ruiz', '5563276149')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Laura', 'Sanchez Garcia', '5592650410')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Diaz Ruiz', '5576615464')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Torres Rodriguez', '5597613851')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Fernandez Ruiz', '5535150257')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Gonzalez Sanchez', '5576484781')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Ruiz Garcia', '5565773425')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Garcia Gonzalez', '5511051771')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Rodriguez Gonzalez', '5550660164')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz Flores', '5533909234')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valentina', 'Ruiz Perez', '5564535608')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Diaz Gomez', '5549831349')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Perez Lopez', '5512403522')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Gomez Diaz', '5575950059')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Laura', 'Sanchez Flores', '5547351608')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Diaz Ramirez', '5547312485')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Ruiz Diaz', '5517218715')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gonzalez Ramirez', '5512765655')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Rodriguez Gonzalez', '5523368597')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Garcia Garcia', '5575785404')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Ramirez Perez', '5599613874')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Flores Garcia', '5564572398')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Ramirez Flores', '5545459624')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Martinez Gomez', '5540510571')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Gonzalez Gomez', '5564685266')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Diaz Torres', '5563316085')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Flores Fernandez', '5550898320')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Lopez Diaz', '5514461714')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Fernandez Torres', '5562332209')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Sanchez Garcia', '5510987527')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Sanchez Ruiz', '5513203438')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Martinez Diaz', '5521394438')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Diaz Sanchez', '5564526660')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Ruiz Torres', '5597121068')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Ruiz Rodriguez', '5518649556')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Lopez Diaz', '5510094737')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gomez Fernandez', '5561783966')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Ramirez Ramirez', '5556955610')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Gomez Lopez', '5532470135')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Torres Torres', '5551407501')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Rodriguez Torres', '5569968035')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Martinez Ramirez', '5533229423')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Lopez Torres', '5528095836')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Gomez Lopez', '5579282725')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Ramirez Gomez', '5567669406')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Martinez Gomez', '5569282226')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Sanchez Rodriguez', '5563505891')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Ramirez Torres', '5560394741')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Lopez Ruiz', '5589133656')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Ramirez Ramirez', '5541744009')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Laura', 'Rodriguez Garcia', '5537426484')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ana', 'Lopez Ramirez', '5541451405')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniel', 'Gomez Rodriguez', '5548076995')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Gonzalez Ramirez', '5522790957')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Torres Gomez', '5580949372')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Rodriguez Perez', '5543970228')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Gonzalez Perez', '5534933314')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Ramirez Sanchez', '5545038538')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gomez Garcia', '5596328501')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Diaz Gonzalez', '5569862586')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Eduardo', 'Fernandez Rodriguez', '5547550155')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Ruiz Ruiz', '5566763976')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Gomez Martinez', '5566733902')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniel', 'Martinez Sanchez', '5592665120')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Rodriguez Fernandez', '5572205293')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Gomez Rodriguez', '5567819073')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez Rodriguez', '5583407744')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Ruiz Martinez', '5581281595')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Perez Diaz', '5563381598')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Sanchez Perez', '5570141853')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Ruiz Ruiz', '5517031476')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Ramirez Garcia', '5553648697')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Ramirez Gonzalez', '5513386084')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Eduardo', 'Ruiz Diaz', '5523308898')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Lopez Martinez', '5561159156')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gonzalez Perez', '5533019226')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Lopez Diaz', '5590612451')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Flores Flores', '5551097329')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Martinez Lopez', '5533291910')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Rodriguez Ruiz', '5573111232')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniel', 'Lopez Rodriguez', '5539219015')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Perez Gonzalez', '5522202719')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Sanchez Diaz', '5555569046')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Rodriguez Rodriguez', '5569986306')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Torres Martinez', '5544260901')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Lopez Ramirez', '5559067301')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Lopez Gonzalez', '5527205527')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Rodriguez Gonzalez', '5561316204')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Diaz Rodriguez', '5556572187')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Fernandez Fernandez', '5598602709')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Sanchez Rodriguez', '5561039070')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Rodriguez Martinez', '5516302035')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Rodriguez Gonzalez', '5514587977')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ruiz Ruiz', '5533218559')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Fernandez Torres', '5510635234')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Sanchez Ruiz', '5515823489')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Sanchez Ramirez', '5562146576')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Sanchez Lopez', '5534305442')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ramirez Diaz', '5596995360')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Garcia Ramirez', '5524130031')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Flores Lopez', '5571881059')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Rodriguez Sanchez', '5560408606')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Ramirez Lopez', '5573295370')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Maria', 'Lopez Diaz', '5541833067')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Garcia Sanchez', '5547863439')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Diaz Gomez', '5534536383')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Sanchez Sanchez', '5522351110')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Lopez Gomez', '5516486501')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Fernandez Diaz', '5593027582')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Flores Rodriguez', '5538042954')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Gomez Ramirez', '5583670085')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Perez Garcia', '5565165160')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Gonzalez Garcia', '5572876349')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Perez Torres', '5535483377')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Gomez Lopez', '5585272686')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Rodriguez Garcia', '5584899948')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Fernandez Martinez', '5546027389')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Eduardo', 'Sanchez Sanchez', '5587333557')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Ramirez Garcia', '5585863438')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Ramirez Ramirez', '5510037215')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Martinez Fernandez', '5523068411')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Diaz Martinez', '5554845361')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Martinez Gomez', '5540994335')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniel', 'Martinez Rodriguez', '5547235008')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Garcia Gomez', '5579808480')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Flores Gomez', '5592396229')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Fernandez Gomez', '5593994857')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gonzalez Diaz', '5548433101')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Fernandez Gonzalez', '5587166177')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Garcia Flores', '5533328013')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Garcia Torres', '5563461098')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Fernandez Gomez', '5523791223')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniel', 'Garcia Ruiz', '5510529002')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gomez Rodriguez', '5535592850')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Torres Gonzalez', '5546065384')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Sanchez Diaz', '5563863305')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Sanchez Gomez', '5596792785')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Martinez Ruiz', '5560258365')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Sanchez Diaz', '5578277890')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Diaz Garcia', '5544855673')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Gonzalez Lopez', '5594320786')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Flores Diaz', '5567846119')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Fernandez Diaz', '5589126807')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Flores Gonzalez', '5561018347')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniel', 'Sanchez Flores', '5560129972')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Ruiz Gomez', '5582701761')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Garcia Perez', '5593392293')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valentina', 'Gomez Rodriguez', '5555570069')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Fernandez Gomez', '5552893173')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Garcia Ramirez', '5530661615')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Torres Ramirez', '5566175667')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Perez Gomez', '5527599301')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Garcia Garcia', '5546282235')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Victoria', 'Perez Flores', '5518546806')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Flores Torres', '5551530784')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Rodriguez Garcia', '5513093726')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ruiz Diaz', '5514587520')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Gonzalez Rodriguez', '5574820631')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Torres Rodriguez', '5514583731')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Martinez Ramirez', '5510790809')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Diaz Lopez', '5590407947')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Gomez Ramirez', '5592537590')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ramirez Perez', '5535712781')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Isabella', 'Torres Gonzalez', '5570831884')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Laura', 'Torres Flores', '5550737531')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Gomez Diaz', '5520406411')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Perez Flores', '5577709716')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Rodriguez Sanchez', '5551558487')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Garcia Garcia', '5541636382')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Ramirez Gomez', '5556163080')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Sanchez Fernandez', '5542591356')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Diaz Sanchez', '5582762615')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carlos', 'Martinez Rodriguez', '5517665048')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Gomez Ramirez', '5586324243')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Rodriguez Gonzalez', '5513275500')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Laura', 'Torres Torres', '5526513077')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Diaz Sanchez', '5532933620')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Emma', 'Gomez Sanchez', '5521598225')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Roberto', 'Martinez Ramirez', '5536872114')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Ramirez Diaz', '5541186402')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Sanchez Martinez', '5591900923')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Lopez Lopez', '5566333590')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B_, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Gomez Sanchez', '5540882693')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Lopez Ruiz', '5588990558')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Lucia', 'Gonzalez Garcia', '5522083159')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Diaz Gonzalez', '5537747485')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Ruiz Torres', '5519841781')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Eduardo', 'Sanchez Flores', '5528508230')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Fernandez Lopez', '5573425597')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Javier', 'Ramirez Rodriguez', '5586200527')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Gomez Ramirez', '5561664495')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Lopez Gonzalez', '5575127859')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Valeria', 'Martinez Gonzalez', '5589068913')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Garcia Ramirez', '5513056873')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Lopez Ramirez', '5545884137')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Martinez Flores', '5559473851')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Garcia Fernandez', '5572285958')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Diego', 'Fernandez Torres', '5542146952')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Perez Rodriguez', '5549214790')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Rodriguez Lopez', '5542089025')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Ruiz Gonzalez', '5566291069')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Fernando', 'Martinez Sanchez', '5518424948')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Hugo', 'Gonzalez Perez', '5597803816')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Laura', 'Gomez Lopez', '5560420606')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Flores Ramirez', '5589364332')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Garcia Torres', '5563213923')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Camila', 'Sanchez Lopez', '5535657155')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Jorge', 'Sanchez Ramirez', '5595977785')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Eduardo', 'Torres Sanchez', '5567732361')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Alejandro', 'Garcia Ruiz', '5596710188')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Martina', 'Fernandez Martinez', '5585520293')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Sofia', 'Perez Sanchez', '5571854004')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('David', 'Diaz Flores', '5523061652')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Luis', 'Ruiz Gonzalez', '5544358772')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Miguel', 'Diaz Ruiz', '5584338890')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, false, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Carmen', 'Fernandez Garcia', '5561511046')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B_, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Sanchez Sanchez', '5547280454')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Ricardo', 'Sanchez Martinez', '5595533289')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM new_player;
    WITH new_player AS (
        INSERT INTO players (first_name, last_name, phone)
        VALUES ('Daniela', 'Martinez Gonzalez', '5520475429')
        ON CONFLICT (first_name, last_name, phone) DO UPDATE SET phone = EXCLUDED.phone
        RETURNING id
    )
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM new_player;
    -- LINK DOUBLES PARTNERS AUTOMATICALLY
    WITH doubles_players AS (
        SELECT id as reg_id, player_id, category_id, subcategory_id,
               row_number() OVER (PARTITION BY category_id, subcategory_id ORDER BY random()) as rn
        FROM tournament_registrations
        WHERE is_doubles = true AND tournament_id = t_id
    ),
    pairs AS (
        SELECT d1.reg_id as r1, d2.player_id as p2
        FROM doubles_players d1
        JOIN doubles_players d2 ON d1.category_id = d2.category_id 
                                AND d1.subcategory_id = d2.subcategory_id
                                AND ((d1.rn % 2 <> 0 AND d2.rn = d1.rn + 1) OR (d1.rn % 2 = 0 AND d2.rn = d1.rn - 1))
    )
    UPDATE tournament_registrations tr
    SET partner_id = pairs.p2
    FROM pairs
    WHERE tr.id = pairs.r1;

    -- STRIP DOUBLES FLAG FROM THE ODD-MAN-OUT REMAINDERS
    UPDATE tournament_registrations
    SET is_doubles = false
    WHERE partner_id IS NULL AND is_doubles = true AND tournament_id = t_id;

    -- IF THEY LOST THEIR ONLY MODALITY, FORCE THEM INTO SINGLES
    UPDATE tournament_registrations
    SET is_singles = true
    WHERE is_singles = false AND is_doubles = false AND tournament_id = t_id;

END $$;
