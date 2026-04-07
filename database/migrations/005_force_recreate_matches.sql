-- Migration: 005_force_recreate_matches.sql
-- Description: Drops the old legacy `matches` table prototype and forces 
-- the creation of the complete scheduling engine schema, perfectly synced 
-- with the new Python column naming.

-- 1. Wipe the old legacy matches table (this will erase any prototype test matches you had)
DROP TABLE IF EXISTS matches CASCADE;

-- 2. Build the fully featured matches table mapped to the new Python code
CREATE TABLE matches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
    category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
    subcategory_id UUID REFERENCES subcategories(id) ON DELETE CASCADE,
    
    match_type TEXT NOT NULL, 
    stage TEXT NOT NULL, 
    
    -- Using the legacy column names your database historically expects
    player1_id UUID REFERENCES players(id) ON DELETE SET NULL,
    player2_id UUID REFERENCES players(id) ON DELETE SET NULL, 
    team1_partner_id UUID REFERENCES players(id) ON DELETE SET NULL,
    team2_partner_id UUID REFERENCES players(id) ON DELETE SET NULL, 
    
    -- Scheduling Context
    court_id UUID REFERENCES courts(id) ON DELETE SET NULL,
    scheduled_time TIMESTAMPTZ, 
    duration_minutes INT DEFAULT 90,
    
    -- Match Results
    status TEXT DEFAULT 'Scheduled', 
    score_team_a TEXT, 
    score_team_b TEXT,
    winner TEXT 
);
