-- Migration: 004_matches_and_courts.sql
-- Description: Adds Courts, Matches scheduling engine, and missing B+ Subcategory
-- Recommended to run manually in the Supabase SQL Editor

-- 1. Insert Missing Category (B+)
-- We use DO NOTHING to prevent errors if it already exists
INSERT INTO subcategories (name) VALUES ('B+') ON CONFLICT (name) DO NOTHING;

-- 2. Courts Table
CREATE TABLE IF NOT EXISTS courts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT true 
);

-- Seed Initial Courts
INSERT INTO courts (name) VALUES 
('Cancha 1'), ('Cancha 2'), ('Cancha 3'), ('Cancha 4'), ('Cancha 5'), ('Cancha 6')
ON CONFLICT (name) DO NOTHING;

-- 3. Matches Table (Scheduling Engine Core)
CREATE TABLE IF NOT EXISTS matches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
    category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
    subcategory_id UUID REFERENCES subcategories(id) ON DELETE CASCADE,
    
    match_type TEXT NOT NULL, -- 'Singles' or 'Doubles'
    stage TEXT NOT NULL, -- 'Grupos', 'Cuartos de Final', 'Semifinal', 'Final'
    
    -- Players 
    -- (We bind to players directly rather than complex composite objects for simplicity)
    team_a_player1_id UUID REFERENCES players(id) ON DELETE SET NULL,
    team_a_player2_id UUID REFERENCES players(id) ON DELETE SET NULL, -- Null if singles
    team_b_player1_id UUID REFERENCES players(id) ON DELETE SET NULL,
    team_b_player2_id UUID REFERENCES players(id) ON DELETE SET NULL, -- Null if singles
    
    -- Scheduling Context
    court_id UUID REFERENCES courts(id) ON DELETE SET NULL,
    scheduled_time TIMESTAMPTZ, 
    duration_minutes INT DEFAULT 90,
    
    -- Match Results
    status TEXT DEFAULT 'Scheduled', -- 'Scheduled', 'In Progress', 'Completed', 'Walkover'
    score_team_a TEXT, 
    score_team_b TEXT,
    winner TEXT -- 'Team A' or 'Team B'
);

-- Note: We intentionally avoid adding a strict UNIQUE(court_id, scheduled_time)
-- to allow the UI to control validation flexibly and permit human overrides.
