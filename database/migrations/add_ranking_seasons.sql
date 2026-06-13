-- ============================================================
-- Migration: Add ranking_seasons archive table
-- Run this in the Supabase SQL Editor (Dashboard → SQL)
-- ============================================================

-- Frozen snapshots of completed ranking periods.
-- JSONB columns store fully self-contained, immutable copies
-- of the ladder and match history so cascading deletes on
-- live tables never corrupt the archive.
CREATE TABLE IF NOT EXISTS public.ranking_seasons (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    category_id UUID NOT NULL REFERENCES categories(id),
    season_name TEXT NOT NULL,               -- e.g. "Temporada Mayo 2026"
    ended_at TIMESTAMPTZ DEFAULT NOW(),
    total_weeks INTEGER NOT NULL DEFAULT 0,
    -- JSON snapshot: [{position, player_id, first_name, last_name, subcategory}, ...]
    final_ladder JSONB NOT NULL DEFAULT '[]',
    -- JSON snapshot: [{week_number, phase, matches: [...]}, ...]
    weekly_results JSONB NOT NULL DEFAULT '[]',
    ended_by UUID REFERENCES auth.users(id)
);

-- RLS
ALTER TABLE ranking_seasons ENABLE ROW LEVEL SECURITY;

-- Public can view past seasons (future Season History Viewer feature)
CREATE POLICY "anon_read_seasons" ON ranking_seasons
    FOR SELECT TO anon USING (true);
CREATE POLICY "auth_read_seasons" ON ranking_seasons
    FOR SELECT TO authenticated USING (true);

-- Only coaches can write
CREATE POLICY "auth_write_seasons" ON ranking_seasons
    FOR INSERT TO authenticated WITH CHECK (auth.uid() IS NOT NULL);

GRANT SELECT ON ranking_seasons TO anon;

-- Done. The ranking_seasons table is ready.
