-- SEED DATA FOR COPA PRESIDENTES
DO $$
DECLARE
    t_id UUID := (SELECT id FROM tournaments WHERE name ILIKE '%Copa Presidente%' LIMIT 1);
    c_Varonil UUID := (SELECT id FROM categories WHERE name = 'Varonil' LIMIT 1);
    c_Femenil UUID := (SELECT id FROM categories WHERE name = 'Femenil' LIMIT 1);
    s_8_10_años UUID := (SELECT id FROM subcategories WHERE name = '8-10 años' LIMIT 1);
    s_A UUID := (SELECT id FROM subcategories WHERE name = 'A' LIMIT 1);
    s_C UUID := (SELECT id FROM subcategories WHERE name = 'C' LIMIT 1);
    s_Mini_Tenis UUID := (SELECT id FROM subcategories WHERE name = 'Mini-Tenis' LIMIT 1);
    s_D UUID := (SELECT id FROM subcategories WHERE name = 'D' LIMIT 1);
    s_B UUID := (SELECT id FROM subcategories WHERE name = 'B' LIMIT 1);
    s_AA UUID := (SELECT id FROM subcategories WHERE name = 'AA' LIMIT 1);
BEGIN
    IF t_id IS NULL THEN
        RAISE EXCEPTION 'Tournament Copa Presidentes not found';
    END IF;

    -- INSERT PLAYERS
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Roberto', 'Castillo', '3222575133')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Emilio', 'Lopez', '3227718243')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Joaquin', 'Cruz', '3222105239')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Soto', '3223905166')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Santiago', 'Ramirez', '3226478091')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Rodriguez', '3225617414')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luis', 'Rivera', '3226424035')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Pablo', 'Rivera', '3229304944')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Santiago', 'Soto', '3227833606')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Pablo', 'Rodriguez', '3227136671')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Tomas', 'Morales', '3224909630')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernando', 'Torres', '3225449317')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carlos', 'Manzano', '3226905324')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Alejandro', 'Rodriguez', '3227121403')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernando', 'Gomez', '3226233071')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Hugo', 'Aguirre', '3227963126')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Pablo', 'Diaz', '3225362365')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Roberto', 'Sanchez', '3224351661')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Alejandro', 'Morales', '3228569627')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Emilio', 'Martinez', '3224596399')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniel', 'Fernandez', '3229038833')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Gabriel', 'Lopez', '3224846844')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Diego', 'Mendoza', '3226385278')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Pablo', 'Silva', '3224657766')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Eduardo', 'Silva', '3222556725')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luis', 'Ruiz', '3223958705')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Diego', 'Manzano', '3224631128')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Martin', 'Ortiz', '3228489991')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Mateo', 'Martinez', '3228848512')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carlos', 'Morales', '3226757806')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Diego', 'Flores', '3226375909')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carlos', 'Rodriguez', '3221179399')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luis', 'Ramirez', '3225711587')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julian', 'Rodriguez', '3221934550')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Mateo', 'Ortiz', '3226948033')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Sebastian', 'Mendoza', '3226997085')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Santiago', 'Ortiz', '3222203074')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Morales', '3224229924')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Andres', 'Mendoza', '3225906061')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Eduardo', 'Hernandez', '3226687649')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Pablo', 'Sanchez', '3222934321')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Jorge', 'Garcia', '3227894186')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Gabriel', 'Diaz', '3223306288')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Roberto', 'Hernandez', '3228962749')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Pablo', 'Flores', '3228125760')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Diego', 'Silva', '3223186388')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Morales', '3225055264')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Sebastian', 'Castillo', '3225744775')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Ruiz', '3229043721')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carlos', 'Martinez', '3222017949')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Sanchez', '3224619481')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Soto', '3229075966')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('David', 'Sanchez', '3222489484')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Emilio', 'Ramirez', '3228782462')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Sebastian', 'Hernandez', '3224178519')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniel', 'Chavez', '3229751770')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('David', 'Fernandez', '3228565171')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julian', 'Reyes', '3226757608')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Jorge', 'Ruiz', '3221219797')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Gabriel', 'Reyes', '3223081406')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julian', 'Soto', '3224096222')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Manzano', '3229526502')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Tomas', 'Diaz', '3227796802')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Leonardo', 'Cruz', '3224426640')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Emilio', 'Gutierrez', '3228657431')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Ruiz', '3229702116')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Roberto', 'Gonzalez', '3225666060')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Joaquin', 'Rivera', '3228208309')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Ramirez', '3229312651')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('David', 'Hernandez', '3221513510')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Martin', 'Gutierrez', '3226317148')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Alejandro', 'Gomez', '3223673606')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Eduardo', 'Gutierrez', '3229634458')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julian', 'Rivera', '3221692675')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniel', 'Martinez', '3221943419')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carlos', 'Soto', '3225061147')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Emilio', 'Rodriguez', '3223145534')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Pablo', 'Perez', '3229533402')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Roberto', 'Chavez', '3226058836')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Diego', 'Diaz', '3224665679')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Pablo', 'Fernandez', '3225906962')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Garcia', '3225798956')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Leonardo', 'Ramirez', '3223255431')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Mateo', 'Soto', '3222784293')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Roberto', 'Rodriguez', '3223016823')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Roberto', 'Mendoza', '3228996615')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Gabriel', 'Garcia', '3227194160')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('David', 'Flores', '3224293534')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Silva', '3228867914')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julian', 'Mendoza', '3224693545')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Hugo', 'Fernandez', '3224925572')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernando', 'Cruz', '3225674402')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Joaquin', 'Mendoza', '3223953345')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Santiago', 'Chavez', '3229732872')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Tomas', 'Sanchez', '3228601270')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Martinez', '3228371662')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Joaquin', 'Lopez', '3224664378')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Alejandro', 'Sanchez', '3222158467')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Joaquin', 'Soto', '3222383286')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luis', 'Soto', '3224911286')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernando', 'Ramirez', '3225828965')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Leonardo', 'Mendoza', '3229166152')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Sebastian', 'Morales', '3221097474')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Tomas', 'Garcia', '3224385006')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Emilio', 'Aguirre', '3221251280')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Miguel', 'Gutierrez', '3225231799')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luis', 'Perez', '3228334896')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Gabriel', 'Soto', '3226377556')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Mateo', 'Gonzalez', '3229443615')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Flores', '3229948184')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Martin', 'Sanchez', '3229314972')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Emilio', 'Cruz', '3223683160')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Tomas', 'Rivera', '3224893239')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Leonardo', 'Ruiz', '3225246129')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luis', 'Silva', '3222261371')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julian', 'Morales', '3221399473')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Santiago', 'Gomez', '3225425331')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Diego', 'Gonzalez', '3227561261')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julian', 'Castillo', '3229325995')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carlos', 'Gutierrez', '3223794537')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Ramirez', '3226047720')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Martinez', '3223738836')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samuel', 'Gutierrez', '3229175801')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Emilio', 'Torres', '3229396773')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Santiago', 'Morales', '3226427514')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Mateo', 'Morales', '3222678346')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luis', 'Martinez', '3221066513')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Mateo', 'Rivera', '3228002458')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carlos', 'Perez', '3221839753')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Elena', 'Cruz', '3226443339')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Sofia', 'Hernandez', '3223536602')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Romina', 'Ruiz', '3224344944')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julia', 'Castillo', '3222783713')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Renata', 'Flores', '3228164998')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julia', 'Martinez', '3227549209')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Isabella', 'Lopez', '3223108738')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Natalia', 'Rivera', '3226805475')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Elena', 'Soto', '3229607784')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carmen', 'Diaz', '3225228937')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Regina', 'Ruiz', '3223628430')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Romina', 'Rivera', '3222735146')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luciana', 'Chavez', '3226912711')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernanda', 'Gomez', '3224975393')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Paula', 'Rodriguez', '3224134727')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernanda', 'Ruiz', '3223671457')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Andrea', 'Chavez', '3224211342')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valeria', 'Chavez', '3228708929')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Natalia', 'Mendoza', '3227344354')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luciana', 'Flores', '3222764624')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Renata', 'Ortiz', '3228478257')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luciana', 'Manzano', '3225641713')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valentina', 'Ramirez', '3226317444')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valeria', 'Sanchez', '3227838168')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Romina', 'Rodriguez', '3227298165')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ana', 'Silva', '3227091393')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniela', 'Hernandez', '3227345067')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valentina', 'Soto', '3225151694')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julia', 'Ruiz', '3227634114')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Isabella', 'Perez', '3227291243')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Andrea', 'Ortiz', '3226145264')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julia', 'Soto', '3228921176')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ximena', 'Hernandez', '3222416661')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valeria', 'Rodriguez', '3224765398')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samantha', 'Torres', '3227104401')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Laura', 'Manzano', '3228562961')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ana', 'Manzano', '3225062871')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Romina', 'Martinez', '3226131958')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luciana', 'Reyes', '3222966883')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ana', 'Rodriguez', '3222074163')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Paula', 'Chavez', '3227112255')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniela', 'Rivera', '3222579645')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Maria', 'Gutierrez', '3229721310')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernanda', 'Flores', '3225751793')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Andrea', 'Garcia', '3224948691')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Victoria', 'Ortiz', '3224458621')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ximena', 'Torres', '3221983358')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Camila', 'Ortiz', '3229019794')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carmen', 'Reyes', '3222241522')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Elena', 'Garcia', '3229312104')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Carmen', 'Manzano', '3227349812')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Andrea', 'Gonzalez', '3221638206')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Julia', 'Sanchez', '3225626072')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ximena', 'Gonzalez', '3221239649')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernanda', 'Gonzalez', '3222659826')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valeria', 'Ortiz', '3224702859')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ximena', 'Ramirez', '3225836926')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Natalia', 'Gonzalez', '3223697347')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniela', 'Rodriguez', '3228261440')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Luciana', 'Silva', '3229781886')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samantha', 'Castillo', '3224573925')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Romina', 'Sanchez', '3222729729')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valentina', 'Gutierrez', '3228401806')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Isabella', 'Mendoza', '3228236403')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ximena', 'Silva', '3228239732')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Laura', 'Torres', '3226814635')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernanda', 'Silva', '3225487074')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniela', 'Cruz', '3222903860')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniela', 'Silva', '3227561268')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ximena', 'Mendoza', '3225668955')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Laura', 'Martinez', '3222953610')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Natalia', 'Sanchez', '3227423525')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Elena', 'Ortiz', '3222783819')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valeria', 'Gonzalez', '3223501440')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Regina', 'Fernandez', '3227134201')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ana', 'Diaz', '3223993612')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Ana', 'Gomez', '3224348347')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Daniela', 'Sanchez', '3221553200')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Fernanda', 'Castillo', '3228847986')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Natalia', 'Castillo', '3228755197')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Romina', 'Castillo', '3229919853')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Laura', 'Rivera', '3222688968')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Samantha', 'Diaz', '3222563217')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valeria', 'Soto', '3226284193')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Sofia', 'Gutierrez', '3226041898')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Natalia', 'Ruiz', '3227071274')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Valentina', 'Castillo', '3222711607')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Paula', 'Garcia', '3223874592')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Romina', 'Perez', '3225338949')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Regina', 'Martinez', '3223392997')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;
    INSERT INTO players (first_name, last_name, phone)
    VALUES ('Elena', 'Mendoza', '3221763389')
    ON CONFLICT (first_name, last_name, phone) DO NOTHING;

    -- INSERT REGISTRATIONS
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Roberto' AND last_name = 'Castillo' AND phone = '3222575133'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Emilio' AND last_name = 'Lopez' AND phone = '3227718243'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Joaquin' AND last_name = 'Cruz' AND phone = '3222105239'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Soto' AND phone = '3223905166'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Santiago' AND last_name = 'Ramirez' AND phone = '3226478091'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Rodriguez' AND phone = '3225617414'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Luis' AND last_name = 'Rivera' AND phone = '3226424035'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Pablo' AND last_name = 'Rivera' AND phone = '3229304944'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Santiago' AND last_name = 'Soto' AND phone = '3227833606'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Pablo' AND last_name = 'Rodriguez' AND phone = '3227136671'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Tomas' AND last_name = 'Morales' AND phone = '3224909630'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Fernando' AND last_name = 'Torres' AND phone = '3225449317'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Carlos' AND last_name = 'Manzano' AND phone = '3226905324'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Alejandro' AND last_name = 'Rodriguez' AND phone = '3227121403'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Fernando' AND last_name = 'Gomez' AND phone = '3226233071'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Hugo' AND last_name = 'Aguirre' AND phone = '3227963126'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Pablo' AND last_name = 'Diaz' AND phone = '3225362365'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Roberto' AND last_name = 'Sanchez' AND phone = '3224351661'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Alejandro' AND last_name = 'Morales' AND phone = '3228569627'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Emilio' AND last_name = 'Martinez' AND phone = '3224596399'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Daniel' AND last_name = 'Fernandez' AND phone = '3229038833'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Gabriel' AND last_name = 'Lopez' AND phone = '3224846844'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Diego' AND last_name = 'Mendoza' AND phone = '3226385278'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Pablo' AND last_name = 'Silva' AND phone = '3224657766'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Eduardo' AND last_name = 'Silva' AND phone = '3222556725'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Luis' AND last_name = 'Ruiz' AND phone = '3223958705'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Diego' AND last_name = 'Manzano' AND phone = '3224631128'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Martin' AND last_name = 'Ortiz' AND phone = '3228489991'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Mateo' AND last_name = 'Martinez' AND phone = '3228848512'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Carlos' AND last_name = 'Morales' AND phone = '3226757806'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Diego' AND last_name = 'Flores' AND phone = '3226375909'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Carlos' AND last_name = 'Rodriguez' AND phone = '3221179399'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Luis' AND last_name = 'Ramirez' AND phone = '3225711587'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Julian' AND last_name = 'Rodriguez' AND phone = '3221934550'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Mateo' AND last_name = 'Ortiz' AND phone = '3226948033'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Sebastian' AND last_name = 'Mendoza' AND phone = '3226997085'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Santiago' AND last_name = 'Ortiz' AND phone = '3222203074'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Morales' AND phone = '3224229924'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Andres' AND last_name = 'Mendoza' AND phone = '3225906061'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Eduardo' AND last_name = 'Hernandez' AND phone = '3226687649'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Pablo' AND last_name = 'Sanchez' AND phone = '3222934321'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Jorge' AND last_name = 'Garcia' AND phone = '3227894186'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Gabriel' AND last_name = 'Diaz' AND phone = '3223306288'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Roberto' AND last_name = 'Hernandez' AND phone = '3228962749'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Pablo' AND last_name = 'Flores' AND phone = '3228125760'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Diego' AND last_name = 'Silva' AND phone = '3223186388'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Morales' AND phone = '3225055264'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Sebastian' AND last_name = 'Castillo' AND phone = '3225744775'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Ruiz' AND phone = '3229043721'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Carlos' AND last_name = 'Martinez' AND phone = '3222017949'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Sanchez' AND phone = '3224619481'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Soto' AND phone = '3229075966'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'David' AND last_name = 'Sanchez' AND phone = '3222489484'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Emilio' AND last_name = 'Ramirez' AND phone = '3228782462'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Sebastian' AND last_name = 'Hernandez' AND phone = '3224178519'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Daniel' AND last_name = 'Chavez' AND phone = '3229751770'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'David' AND last_name = 'Fernandez' AND phone = '3228565171'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Julian' AND last_name = 'Reyes' AND phone = '3226757608'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Jorge' AND last_name = 'Ruiz' AND phone = '3221219797'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Gabriel' AND last_name = 'Reyes' AND phone = '3223081406'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Julian' AND last_name = 'Soto' AND phone = '3224096222'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Manzano' AND phone = '3229526502'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Tomas' AND last_name = 'Diaz' AND phone = '3227796802'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Leonardo' AND last_name = 'Cruz' AND phone = '3224426640'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Emilio' AND last_name = 'Gutierrez' AND phone = '3228657431'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Ruiz' AND phone = '3229702116'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Roberto' AND last_name = 'Gonzalez' AND phone = '3225666060'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Joaquin' AND last_name = 'Rivera' AND phone = '3228208309'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Ramirez' AND phone = '3229312651'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'David' AND last_name = 'Hernandez' AND phone = '3221513510'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Martin' AND last_name = 'Gutierrez' AND phone = '3226317148'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Alejandro' AND last_name = 'Gomez' AND phone = '3223673606'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Eduardo' AND last_name = 'Gutierrez' AND phone = '3229634458'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Julian' AND last_name = 'Rivera' AND phone = '3221692675'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Daniel' AND last_name = 'Martinez' AND phone = '3221943419'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Carlos' AND last_name = 'Soto' AND phone = '3225061147'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Emilio' AND last_name = 'Rodriguez' AND phone = '3223145534'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Pablo' AND last_name = 'Perez' AND phone = '3229533402'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Roberto' AND last_name = 'Chavez' AND phone = '3226058836'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Diego' AND last_name = 'Diaz' AND phone = '3224665679'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Pablo' AND last_name = 'Fernandez' AND phone = '3225906962'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Garcia' AND phone = '3225798956'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Leonardo' AND last_name = 'Ramirez' AND phone = '3223255431'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Mateo' AND last_name = 'Soto' AND phone = '3222784293'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Roberto' AND last_name = 'Rodriguez' AND phone = '3223016823'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Roberto' AND last_name = 'Mendoza' AND phone = '3228996615'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Gabriel' AND last_name = 'Garcia' AND phone = '3227194160'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'David' AND last_name = 'Flores' AND phone = '3224293534'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Silva' AND phone = '3228867914'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Julian' AND last_name = 'Mendoza' AND phone = '3224693545'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Hugo' AND last_name = 'Fernandez' AND phone = '3224925572'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Fernando' AND last_name = 'Cruz' AND phone = '3225674402'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Joaquin' AND last_name = 'Mendoza' AND phone = '3223953345'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Santiago' AND last_name = 'Chavez' AND phone = '3229732872'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Tomas' AND last_name = 'Sanchez' AND phone = '3228601270'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Martinez' AND phone = '3228371662'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Joaquin' AND last_name = 'Lopez' AND phone = '3224664378'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Alejandro' AND last_name = 'Sanchez' AND phone = '3222158467'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Joaquin' AND last_name = 'Soto' AND phone = '3222383286'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Luis' AND last_name = 'Soto' AND phone = '3224911286'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Fernando' AND last_name = 'Ramirez' AND phone = '3225828965'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Leonardo' AND last_name = 'Mendoza' AND phone = '3229166152'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Sebastian' AND last_name = 'Morales' AND phone = '3221097474'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Tomas' AND last_name = 'Garcia' AND phone = '3224385006'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Emilio' AND last_name = 'Aguirre' AND phone = '3221251280'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Miguel' AND last_name = 'Gutierrez' AND phone = '3225231799'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Luis' AND last_name = 'Perez' AND phone = '3228334896'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Gabriel' AND last_name = 'Soto' AND phone = '3226377556'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Mateo' AND last_name = 'Gonzalez' AND phone = '3229443615'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Flores' AND phone = '3229948184'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Martin' AND last_name = 'Sanchez' AND phone = '3229314972'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM players WHERE first_name = 'Emilio' AND last_name = 'Cruz' AND phone = '3223683160'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Tomas' AND last_name = 'Rivera' AND phone = '3224893239'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM players WHERE first_name = 'Leonardo' AND last_name = 'Ruiz' AND phone = '3225246129'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM players WHERE first_name = 'Luis' AND last_name = 'Silva' AND phone = '3222261371'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, true, 'Pagado'
    FROM players WHERE first_name = 'Julian' AND last_name = 'Morales' AND phone = '3221399473'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM players WHERE first_name = 'Santiago' AND last_name = 'Gomez' AND phone = '3225425331'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Diego' AND last_name = 'Gonzalez' AND phone = '3227561261'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM players WHERE first_name = 'Julian' AND last_name = 'Castillo' AND phone = '3229325995'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_Mini_Tenis, true, false, 'Pagado'
    FROM players WHERE first_name = 'Carlos' AND last_name = 'Gutierrez' AND phone = '3223794537'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Ramirez' AND phone = '3226047720'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Martinez' AND phone = '3223738836'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM players WHERE first_name = 'Samuel' AND last_name = 'Gutierrez' AND phone = '3229175801'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, true, 'Pagado'
    FROM players WHERE first_name = 'Emilio' AND last_name = 'Torres' AND phone = '3229396773'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Santiago' AND last_name = 'Morales' AND phone = '3226427514'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Mateo' AND last_name = 'Morales' AND phone = '3222678346'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Luis' AND last_name = 'Martinez' AND phone = '3221066513'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Mateo' AND last_name = 'Rivera' AND phone = '3228002458'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Varonil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Carlos' AND last_name = 'Perez' AND phone = '3221839753'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Elena' AND last_name = 'Cruz' AND phone = '3226443339'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Sofia' AND last_name = 'Hernandez' AND phone = '3223536602'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Romina' AND last_name = 'Ruiz' AND phone = '3224344944'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Julia' AND last_name = 'Castillo' AND phone = '3222783713'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Renata' AND last_name = 'Flores' AND phone = '3228164998'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Julia' AND last_name = 'Martinez' AND phone = '3227549209'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Isabella' AND last_name = 'Lopez' AND phone = '3223108738'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, true, 'Pagado'
    FROM players WHERE first_name = 'Natalia' AND last_name = 'Rivera' AND phone = '3226805475'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Elena' AND last_name = 'Soto' AND phone = '3229607784'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Carmen' AND last_name = 'Diaz' AND phone = '3225228937'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Regina' AND last_name = 'Ruiz' AND phone = '3223628430'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Romina' AND last_name = 'Rivera' AND phone = '3222735146'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Luciana' AND last_name = 'Chavez' AND phone = '3226912711'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Fernanda' AND last_name = 'Gomez' AND phone = '3224975393'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_AA, true, false, 'Pagado'
    FROM players WHERE first_name = 'Paula' AND last_name = 'Rodriguez' AND phone = '3224134727'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Fernanda' AND last_name = 'Ruiz' AND phone = '3223671457'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Andrea' AND last_name = 'Chavez' AND phone = '3224211342'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Valeria' AND last_name = 'Chavez' AND phone = '3228708929'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Natalia' AND last_name = 'Mendoza' AND phone = '3227344354'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Luciana' AND last_name = 'Flores' AND phone = '3222764624'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Renata' AND last_name = 'Ortiz' AND phone = '3228478257'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Luciana' AND last_name = 'Manzano' AND phone = '3225641713'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Valentina' AND last_name = 'Ramirez' AND phone = '3226317444'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Valeria' AND last_name = 'Sanchez' AND phone = '3227838168'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, true, 'Pagado'
    FROM players WHERE first_name = 'Romina' AND last_name = 'Rodriguez' AND phone = '3227298165'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Ana' AND last_name = 'Silva' AND phone = '3227091393'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Daniela' AND last_name = 'Hernandez' AND phone = '3227345067'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Valentina' AND last_name = 'Soto' AND phone = '3225151694'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Julia' AND last_name = 'Ruiz' AND phone = '3227634114'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Isabella' AND last_name = 'Perez' AND phone = '3227291243'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Andrea' AND last_name = 'Ortiz' AND phone = '3226145264'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Julia' AND last_name = 'Soto' AND phone = '3228921176'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pagado'
    FROM players WHERE first_name = 'Ximena' AND last_name = 'Hernandez' AND phone = '3222416661'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_A, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Valeria' AND last_name = 'Rodriguez' AND phone = '3224765398'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Samantha' AND last_name = 'Torres' AND phone = '3227104401'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Laura' AND last_name = 'Manzano' AND phone = '3228562961'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Ana' AND last_name = 'Manzano' AND phone = '3225062871'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Romina' AND last_name = 'Martinez' AND phone = '3226131958'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Luciana' AND last_name = 'Reyes' AND phone = '3222966883'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Ana' AND last_name = 'Rodriguez' AND phone = '3222074163'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Paula' AND last_name = 'Chavez' AND phone = '3227112255'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, true, 'Pagado'
    FROM players WHERE first_name = 'Daniela' AND last_name = 'Rivera' AND phone = '3222579645'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Maria' AND last_name = 'Gutierrez' AND phone = '3229721310'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Fernanda' AND last_name = 'Flores' AND phone = '3225751793'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Andrea' AND last_name = 'Garcia' AND phone = '3224948691'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Victoria' AND last_name = 'Ortiz' AND phone = '3224458621'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Ximena' AND last_name = 'Torres' AND phone = '3221983358'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_B, true, false, 'Pagado'
    FROM players WHERE first_name = 'Camila' AND last_name = 'Ortiz' AND phone = '3229019794'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Carmen' AND last_name = 'Reyes' AND phone = '3222241522'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Elena' AND last_name = 'Garcia' AND phone = '3229312104'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Carmen' AND last_name = 'Manzano' AND phone = '3227349812'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Andrea' AND last_name = 'Gonzalez' AND phone = '3221638206'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Julia' AND last_name = 'Sanchez' AND phone = '3225626072'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Ximena' AND last_name = 'Gonzalez' AND phone = '3221239649'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Fernanda' AND last_name = 'Gonzalez' AND phone = '3222659826'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Valeria' AND last_name = 'Ortiz' AND phone = '3224702859'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Ximena' AND last_name = 'Ramirez' AND phone = '3225836926'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, true, 'Pagado'
    FROM players WHERE first_name = 'Natalia' AND last_name = 'Gonzalez' AND phone = '3223697347'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Daniela' AND last_name = 'Rodriguez' AND phone = '3228261440'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Luciana' AND last_name = 'Silva' AND phone = '3229781886'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Samantha' AND last_name = 'Castillo' AND phone = '3224573925'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Romina' AND last_name = 'Sanchez' AND phone = '3222729729'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Valentina' AND last_name = 'Gutierrez' AND phone = '3228401806'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Isabella' AND last_name = 'Mendoza' AND phone = '3228236403'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Ximena' AND last_name = 'Silva' AND phone = '3228239732'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_C, true, false, 'Pagado'
    FROM players WHERE first_name = 'Laura' AND last_name = 'Torres' AND phone = '3226814635'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Fernanda' AND last_name = 'Silva' AND phone = '3225487074'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Daniela' AND last_name = 'Cruz' AND phone = '3222903860'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Daniela' AND last_name = 'Silva' AND phone = '3227561268'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Ximena' AND last_name = 'Mendoza' AND phone = '3225668955'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pendiente'
    FROM players WHERE first_name = 'Laura' AND last_name = 'Martinez' AND phone = '3222953610'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Natalia' AND last_name = 'Sanchez' AND phone = '3227423525'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Elena' AND last_name = 'Ortiz' AND phone = '3222783819'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, true, 'Pagado'
    FROM players WHERE first_name = 'Valeria' AND last_name = 'Gonzalez' AND phone = '3223501440'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Regina' AND last_name = 'Fernandez' AND phone = '3227134201'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Ana' AND last_name = 'Diaz' AND phone = '3223993612'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Ana' AND last_name = 'Gomez' AND phone = '3224348347'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Daniela' AND last_name = 'Sanchez' AND phone = '3221553200'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pagado'
    FROM players WHERE first_name = 'Fernanda' AND last_name = 'Castillo' AND phone = '3228847986'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_D, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Natalia' AND last_name = 'Castillo' AND phone = '3228755197'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM players WHERE first_name = 'Romina' AND last_name = 'Castillo' AND phone = '3229919853'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, true, 'Pagado'
    FROM players WHERE first_name = 'Laura' AND last_name = 'Rivera' AND phone = '3222688968'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pendiente'
    FROM players WHERE first_name = 'Samantha' AND last_name = 'Diaz' AND phone = '3222563217'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM players WHERE first_name = 'Valeria' AND last_name = 'Soto' AND phone = '3226284193'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_Mini_Tenis, true, false, 'Pagado'
    FROM players WHERE first_name = 'Sofia' AND last_name = 'Gutierrez' AND phone = '3226041898'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM players WHERE first_name = 'Natalia' AND last_name = 'Ruiz' AND phone = '3227071274'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, true, 'Pagado'
    FROM players WHERE first_name = 'Valentina' AND last_name = 'Castillo' AND phone = '3222711607'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Paula' AND last_name = 'Garcia' AND phone = '3223874592'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Romina' AND last_name = 'Perez' AND phone = '3225338949'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Regina' AND last_name = 'Martinez' AND phone = '3223392997'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;
    INSERT INTO tournament_registrations (tournament_id, player_id, category_id, subcategory_id, is_singles, is_doubles, payment_status)
    SELECT t_id, id, c_Femenil, s_8_10_años, true, false, 'Pagado'
    FROM players WHERE first_name = 'Elena' AND last_name = 'Mendoza' AND phone = '3221763389'
    ON CONFLICT (tournament_id, player_id) DO UPDATE SET 
      category_id = EXCLUDED.category_id,
      subcategory_id = EXCLUDED.subcategory_id,
      is_singles = EXCLUDED.is_singles,
      is_doubles = EXCLUDED.is_doubles,
      payment_status = EXCLUDED.payment_status;

    -- UPDATE DOUBLES PARTNERS
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Emilio Lopez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Roberto' AND last_name = 'Castillo' AND phone = '3222575133'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Roberto Castillo' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Emilio' AND last_name = 'Lopez' AND phone = '3227718243'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Samuel Soto' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Joaquin' AND last_name = 'Cruz' AND phone = '3222105239'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Joaquin Cruz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Samuel' AND last_name = 'Soto' AND phone = '3223905166'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Samuel Rodriguez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Santiago' AND last_name = 'Ramirez' AND phone = '3226478091'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Santiago Ramirez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Samuel' AND last_name = 'Rodriguez' AND phone = '3225617414'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Pablo Rivera' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Luis' AND last_name = 'Rivera' AND phone = '3226424035'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Luis Rivera' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Pablo' AND last_name = 'Rivera' AND phone = '3229304944'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Pablo Rodriguez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Santiago' AND last_name = 'Soto' AND phone = '3227833606'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Santiago Soto' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Pablo' AND last_name = 'Rodriguez' AND phone = '3227136671'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Fernando Torres' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Tomas' AND last_name = 'Morales' AND phone = '3224909630'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Tomas Morales' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Fernando' AND last_name = 'Torres' AND phone = '3225449317'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Alejandro Rodriguez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Carlos' AND last_name = 'Manzano' AND phone = '3226905324'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Carlos Manzano' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Alejandro' AND last_name = 'Rodriguez' AND phone = '3227121403'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Martin Ortiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Diego' AND last_name = 'Manzano' AND phone = '3224631128'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Diego Manzano' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Martin' AND last_name = 'Ortiz' AND phone = '3228489991'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Carlos Morales' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Mateo' AND last_name = 'Martinez' AND phone = '3228848512'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Mateo Martinez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Carlos' AND last_name = 'Morales' AND phone = '3226757806'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Carlos Rodriguez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Diego' AND last_name = 'Flores' AND phone = '3226375909'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Diego Flores' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Carlos' AND last_name = 'Rodriguez' AND phone = '3221179399'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Julian Rodriguez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Luis' AND last_name = 'Ramirez' AND phone = '3225711587'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Luis Ramirez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Julian' AND last_name = 'Rodriguez' AND phone = '3221934550'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Sebastian Mendoza' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Mateo' AND last_name = 'Ortiz' AND phone = '3226948033'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Mateo Ortiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Sebastian' AND last_name = 'Mendoza' AND phone = '3226997085'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Samuel Morales' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Santiago' AND last_name = 'Ortiz' AND phone = '3222203074'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Santiago Ortiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Samuel' AND last_name = 'Morales' AND phone = '3224229924'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Miguel Ruiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Sebastian' AND last_name = 'Castillo' AND phone = '3225744775'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Sebastian Castillo' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Miguel' AND last_name = 'Ruiz' AND phone = '3229043721'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Miguel Sanchez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Carlos' AND last_name = 'Martinez' AND phone = '3222017949'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Carlos Martinez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Miguel' AND last_name = 'Sanchez' AND phone = '3224619481'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'David Sanchez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Miguel' AND last_name = 'Soto' AND phone = '3229075966'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Miguel Soto' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'David' AND last_name = 'Sanchez' AND phone = '3222489484'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Sebastian Hernandez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Emilio' AND last_name = 'Ramirez' AND phone = '3228782462'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Emilio Ramirez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Sebastian' AND last_name = 'Hernandez' AND phone = '3224178519'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'David Fernandez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Daniel' AND last_name = 'Chavez' AND phone = '3229751770'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Daniel Chavez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'David' AND last_name = 'Fernandez' AND phone = '3228565171'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Roberto Gonzalez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Samuel' AND last_name = 'Ruiz' AND phone = '3229702116'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Samuel Ruiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Roberto' AND last_name = 'Gonzalez' AND phone = '3225666060'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Miguel Ramirez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Joaquin' AND last_name = 'Rivera' AND phone = '3228208309'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Joaquin Rivera' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Miguel' AND last_name = 'Ramirez' AND phone = '3229312651'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Martin Gutierrez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'David' AND last_name = 'Hernandez' AND phone = '3221513510'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'David Hernandez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Martin' AND last_name = 'Gutierrez' AND phone = '3226317148'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Eduardo Gutierrez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Alejandro' AND last_name = 'Gomez' AND phone = '3223673606'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Alejandro Gomez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Eduardo' AND last_name = 'Gutierrez' AND phone = '3229634458'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Daniel Martinez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Julian' AND last_name = 'Rivera' AND phone = '3221692675'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Julian Rivera' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Daniel' AND last_name = 'Martinez' AND phone = '3221943419'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Emilio Rodriguez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Carlos' AND last_name = 'Soto' AND phone = '3225061147'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Carlos Soto' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Emilio' AND last_name = 'Rodriguez' AND phone = '3223145534'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Gabriel Garcia' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Roberto' AND last_name = 'Mendoza' AND phone = '3228996615'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Roberto Mendoza' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Gabriel' AND last_name = 'Garcia' AND phone = '3227194160'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Miguel Silva' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'David' AND last_name = 'Flores' AND phone = '3224293534'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'David Flores' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Miguel' AND last_name = 'Silva' AND phone = '3228867914'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Hugo Fernandez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Julian' AND last_name = 'Mendoza' AND phone = '3224693545'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Julian Mendoza' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Hugo' AND last_name = 'Fernandez' AND phone = '3224925572'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Joaquin Mendoza' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Fernando' AND last_name = 'Cruz' AND phone = '3225674402'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Fernando Cruz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Joaquin' AND last_name = 'Mendoza' AND phone = '3223953345'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Tomas Sanchez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Santiago' AND last_name = 'Chavez' AND phone = '3229732872'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Santiago Chavez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Tomas' AND last_name = 'Sanchez' AND phone = '3228601270'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Joaquin Lopez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Miguel' AND last_name = 'Martinez' AND phone = '3228371662'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Miguel Martinez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Joaquin' AND last_name = 'Lopez' AND phone = '3224664378'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Joaquin Soto' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Alejandro' AND last_name = 'Sanchez' AND phone = '3222158467'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Alejandro Sanchez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Joaquin' AND last_name = 'Soto' AND phone = '3222383286'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Emilio Cruz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Martin' AND last_name = 'Sanchez' AND phone = '3229314972'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Martin Sanchez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Emilio' AND last_name = 'Cruz' AND phone = '3223683160'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Leonardo Ruiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Tomas' AND last_name = 'Rivera' AND phone = '3224893239'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Tomas Rivera' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Leonardo' AND last_name = 'Ruiz' AND phone = '3225246129'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Julian Morales' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Luis' AND last_name = 'Silva' AND phone = '3222261371'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Luis Silva' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Julian' AND last_name = 'Morales' AND phone = '3221399473'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Samuel Martinez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Samuel' AND last_name = 'Ramirez' AND phone = '3226047720'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Samuel Ramirez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Samuel' AND last_name = 'Martinez' AND phone = '3223738836'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Emilio Torres' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Samuel' AND last_name = 'Gutierrez' AND phone = '3229175801'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Samuel Gutierrez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Emilio' AND last_name = 'Torres' AND phone = '3229396773'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Sofia Hernandez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Elena' AND last_name = 'Cruz' AND phone = '3226443339'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Elena Cruz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Sofia' AND last_name = 'Hernandez' AND phone = '3223536602'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Julia Castillo' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Romina' AND last_name = 'Ruiz' AND phone = '3224344944'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Romina Ruiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Julia' AND last_name = 'Castillo' AND phone = '3222783713'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Julia Martinez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Renata' AND last_name = 'Flores' AND phone = '3228164998'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Renata Flores' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Julia' AND last_name = 'Martinez' AND phone = '3227549209'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Natalia Rivera' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Isabella' AND last_name = 'Lopez' AND phone = '3223108738'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Isabella Lopez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Natalia' AND last_name = 'Rivera' AND phone = '3226805475'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Andrea Chavez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Fernanda' AND last_name = 'Ruiz' AND phone = '3223671457'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Fernanda Ruiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Andrea' AND last_name = 'Chavez' AND phone = '3224211342'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Natalia Mendoza' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Valeria' AND last_name = 'Chavez' AND phone = '3228708929'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Valeria Chavez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Natalia' AND last_name = 'Mendoza' AND phone = '3227344354'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Renata Ortiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Luciana' AND last_name = 'Flores' AND phone = '3222764624'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Luciana Flores' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Renata' AND last_name = 'Ortiz' AND phone = '3228478257'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Valentina Ramirez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Luciana' AND last_name = 'Manzano' AND phone = '3225641713'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Luciana Manzano' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Valentina' AND last_name = 'Ramirez' AND phone = '3226317444'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Romina Rodriguez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Valeria' AND last_name = 'Sanchez' AND phone = '3227838168'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Valeria Sanchez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Romina' AND last_name = 'Rodriguez' AND phone = '3227298165'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Laura Manzano' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Samantha' AND last_name = 'Torres' AND phone = '3227104401'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Samantha Torres' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Laura' AND last_name = 'Manzano' AND phone = '3228562961'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Romina Martinez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Ana' AND last_name = 'Manzano' AND phone = '3225062871'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Ana Manzano' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Romina' AND last_name = 'Martinez' AND phone = '3226131958'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Ana Rodriguez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Luciana' AND last_name = 'Reyes' AND phone = '3222966883'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Luciana Reyes' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Ana' AND last_name = 'Rodriguez' AND phone = '3222074163'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Daniela Rivera' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Paula' AND last_name = 'Chavez' AND phone = '3227112255'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Paula Chavez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Daniela' AND last_name = 'Rivera' AND phone = '3222579645'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Elena Garcia' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Carmen' AND last_name = 'Reyes' AND phone = '3222241522'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Carmen Reyes' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Elena' AND last_name = 'Garcia' AND phone = '3229312104'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Andrea Gonzalez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Carmen' AND last_name = 'Manzano' AND phone = '3227349812'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Carmen Manzano' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Andrea' AND last_name = 'Gonzalez' AND phone = '3221638206'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Ximena Gonzalez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Julia' AND last_name = 'Sanchez' AND phone = '3225626072'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Julia Sanchez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Ximena' AND last_name = 'Gonzalez' AND phone = '3221239649'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Valeria Ortiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Fernanda' AND last_name = 'Gonzalez' AND phone = '3222659826'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Fernanda Gonzalez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Valeria' AND last_name = 'Ortiz' AND phone = '3224702859'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Natalia Gonzalez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Ximena' AND last_name = 'Ramirez' AND phone = '3225836926'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Ximena Ramirez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Natalia' AND last_name = 'Gonzalez' AND phone = '3223697347'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Daniela Cruz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Fernanda' AND last_name = 'Silva' AND phone = '3225487074'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Fernanda Silva' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Daniela' AND last_name = 'Cruz' AND phone = '3222903860'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Ximena Mendoza' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Daniela' AND last_name = 'Silva' AND phone = '3227561268'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Daniela Silva' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Ximena' AND last_name = 'Mendoza' AND phone = '3225668955'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Natalia Sanchez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Laura' AND last_name = 'Martinez' AND phone = '3222953610'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Laura Martinez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Natalia' AND last_name = 'Sanchez' AND phone = '3227423525'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Valeria Gonzalez' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Elena' AND last_name = 'Ortiz' AND phone = '3222783819'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Elena Ortiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Valeria' AND last_name = 'Gonzalez' AND phone = '3223501440'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Laura Rivera' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Romina' AND last_name = 'Castillo' AND phone = '3229919853'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Romina Castillo' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Laura' AND last_name = 'Rivera' AND phone = '3222688968'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Valentina Castillo' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Natalia' AND last_name = 'Ruiz' AND phone = '3227071274'
    );
    UPDATE tournament_registrations SET partner_id = (
        SELECT id FROM players WHERE first_name || ' ' || last_name = 'Natalia Ruiz' LIMIT 1
    ) WHERE tournament_id = t_id AND player_id = (
        SELECT id FROM players WHERE first_name = 'Valentina' AND last_name = 'Castillo' AND phone = '3222711607'
    );
END $$;
