-- # Navyar Club Tennis: REFINED SCHEMA
-- This file represents the complete current architecture of the database.
-- Use this to rebuild the entire database if needed.

-- 1. UTILS (Enable UUID generation)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. TOURNAMENTS
CREATE TABLE IF NOT EXISTS tournaments (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    start_date DATE,
    end_date DATE,
    status TEXT DEFAULT 'active', -- 'active', 'closed', 'draft'
    is_finalized BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. CATEGORIES (Global lookup)
CREATE TABLE IF NOT EXISTS categories (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL UNIQUE, -- 'Varonil', 'Femenil'
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. SUBCATEGORIES (Global lookup)
CREATE TABLE IF NOT EXISTS subcategories (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT NOT NULL UNIQUE, -- 'A', 'B', 'C', 'D', 'AA'
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. PLAYERS (The Club Member Directory)
CREATE TABLE IF NOT EXISTS players (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    phone TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    -- Categories are OMITTED here as they are per-tournament (See Registrations)
    UNIQUE(first_name, last_name, phone)
);

-- 6. TOURNAMENT REGISTRATIONS (The Participation Map)
-- THIS IS THE SOURCE OF TRUTH FOR TOURNAMENT BRACKETS
CREATE TABLE IF NOT EXISTS tournament_registrations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
    player_id UUID REFERENCES players(id) ON DELETE CASCADE,
    category_id UUID REFERENCES categories(id),
    subcategory_id UUID REFERENCES subcategories(id),
    is_singles BOOLEAN DEFAULT false,
    is_doubles BOOLEAN DEFAULT false,
    partner_id UUID REFERENCES players(id) ON DELETE SET NULL,
    payment_status TEXT DEFAULT 'Pendiente', -- 'Pagado', 'Pendiente'
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(tournament_id, player_id)
);
