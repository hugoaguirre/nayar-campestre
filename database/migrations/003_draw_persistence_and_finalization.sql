-- Migration: 003_draw_persistence_and_finalization.sql
-- Goal: Persist groups and allow finalization of tournaments.

-- 1. Create table for tournament draws (Snapshots of groups)
CREATE TABLE IF NOT EXISTS tournament_draws (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
    category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
    subcategory_id UUID REFERENCES subcategories(id) ON DELETE CASCADE,
    format_text TEXT NOT NULL, -- 'Singles' or 'Dobles'
    draw_json JSONB NOT NULL, -- The 'groups' structure
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(tournament_id, category_id, subcategory_id, format_text)
);

-- 2. Add is_finalized flag to tournaments table
ALTER TABLE tournaments ADD COLUMN IF NOT EXISTS is_finalized BOOLEAN DEFAULT false;
