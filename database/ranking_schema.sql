-- ============================================================
-- Club Nayar Campestre: Ranking System Schema
-- Run this in the Supabase SQL Editor (Dashboard → SQL)
-- ============================================================
-- Prerequisites: base schema (schema.sql) and auth (auth_schema.sql)
--                must already be applied.
-- ============================================================

-- ═══════════════════════════════════════════════════════════════
-- 1. RANKING LADDERS
-- One row per player per category (Varonil / Femenil).
-- Position determines the player's rank in the ladder.
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.ranking_ladders (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    category_id UUID NOT NULL REFERENCES categories(id),
    player_id UUID NOT NULL REFERENCES players(id) ON DELETE CASCADE,
    position INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    -- Each player appears once per category
    UNIQUE(category_id, player_id),
    -- No two players share a position within a category
    UNIQUE(category_id, position)
);

-- FK indexes (Postgres does NOT auto-index FK columns)
CREATE INDEX idx_ranking_ladders_category ON ranking_ladders(category_id);
CREATE INDEX idx_ranking_ladders_player ON ranking_ladders(player_id);
-- Fast ordered-ladder lookups
CREATE INDEX idx_ranking_ladders_cat_pos ON ranking_ladders(category_id, position);


-- ═══════════════════════════════════════════════════════════════
-- 2. SUB-CATEGORY BOUNDARY RANGES
-- Coach-configured position ranges that define sub-category labels.
-- Example: A = positions 1-27, B+ = positions 28-43, etc.
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.ranking_subcategory_ranges (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    category_id UUID NOT NULL REFERENCES categories(id),
    subcategory_id UUID NOT NULL REFERENCES subcategories(id),
    position_start INTEGER NOT NULL,
    position_end INTEGER NOT NULL,

    UNIQUE(category_id, subcategory_id),
    -- Ensure start <= end
    CHECK (position_start <= position_end)
);

CREATE INDEX idx_ranking_subcat_ranges_category ON ranking_subcategory_ranges(category_id);


-- ═══════════════════════════════════════════════════════════════
-- 3. RANKING WEEKS
-- Weekly challenge/defend rounds. Each week stores its own
-- scheduling configuration (time windows, courts).
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.ranking_weeks (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    category_id UUID NOT NULL REFERENCES categories(id),
    week_number INTEGER NOT NULL,
    phase TEXT NOT NULL CHECK (phase IN ('challenge', 'defend')),

    -- Schedule configuration per week
    weekday_first_game TIME NOT NULL DEFAULT '18:00',
    weekday_last_game TIME NOT NULL DEFAULT '19:30',
    weekend_first_game TIME NOT NULL DEFAULT '10:00',
    weekend_last_game TIME NOT NULL DEFAULT '19:00',
    num_courts INTEGER NOT NULL DEFAULT 6,

    -- The active date range (Tuesday through Sunday)
    week_start_date DATE NOT NULL,
    week_end_date DATE NOT NULL,

    is_completed BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    UNIQUE(category_id, week_number)
);

CREATE INDEX idx_ranking_weeks_category ON ranking_weeks(category_id);
CREATE INDEX idx_ranking_weeks_cat_num ON ranking_weeks(category_id, week_number DESC);


-- ═══════════════════════════════════════════════════════════════
-- 4. RANKING MATCHES
-- Individual games generated each week from ladder pairings.
-- Stores schedule, set scores, and winner determination.
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS public.ranking_matches (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    week_id UUID NOT NULL REFERENCES ranking_weeks(id) ON DELETE CASCADE,

    -- The two competitors (defender = higher ranked)
    defender_id UUID NOT NULL REFERENCES players(id),
    challenger_id UUID NOT NULL REFERENCES players(id),
    defender_position INTEGER NOT NULL,
    challenger_position INTEGER NOT NULL,

    -- Schedule assignment
    scheduled_date DATE,
    scheduled_time TIME,
    court_number INTEGER,

    -- Match results: 2 out of 3 sets
    -- Sets 1 & 2: normal sets
    -- Set 3: super tiebreaker (first to 10, win by 2)
    set1_defender INTEGER,
    set1_challenger INTEGER,
    set2_defender INTEGER,
    set2_challenger INTEGER,
    set3_defender INTEGER,
    set3_challenger INTEGER,

    -- Outcome
    winner_id UUID REFERENCES players(id),
    is_forfeit BOOLEAN DEFAULT false,
    is_completed BOOLEAN DEFAULT false,

    -- Audit
    entered_by UUID REFERENCES auth.users(id),
    completed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- FK indexes for fast JOINs and CASCADE operations
CREATE INDEX idx_ranking_matches_week ON ranking_matches(week_id);
CREATE INDEX idx_ranking_matches_defender ON ranking_matches(defender_id);
CREATE INDEX idx_ranking_matches_challenger ON ranking_matches(challenger_id);
CREATE INDEX idx_ranking_matches_winner ON ranking_matches(winner_id);

-- Composite index for fetching matches by week + completion status
CREATE INDEX idx_ranking_matches_week_status ON ranking_matches(week_id, is_completed);


-- ═══════════════════════════════════════════════════════════════
-- 5. ROW LEVEL SECURITY
-- Dual access: public READ (anon) + coach WRITE (authenticated)
-- ═══════════════════════════════════════════════════════════════

-- Enable RLS on all ranking tables
ALTER TABLE ranking_ladders ENABLE ROW LEVEL SECURITY;
ALTER TABLE ranking_subcategory_ranges ENABLE ROW LEVEL SECURITY;
ALTER TABLE ranking_weeks ENABLE ROW LEVEL SECURITY;
ALTER TABLE ranking_matches ENABLE ROW LEVEL SECURITY;

-- ── PUBLIC READ (anon role) ──────────────────────────────────
-- Anyone can view rankings, match results, and schedules.
-- The public ranking page uses the anon key for these queries.

CREATE POLICY "anon_read_ladders" ON ranking_ladders
    FOR SELECT TO anon USING (true);

CREATE POLICY "anon_read_subcat_ranges" ON ranking_subcategory_ranges
    FOR SELECT TO anon USING (true);

CREATE POLICY "anon_read_weeks" ON ranking_weeks
    FOR SELECT TO anon USING (true);

CREATE POLICY "anon_read_matches" ON ranking_matches
    FOR SELECT TO anon USING (true);

-- ── AUTHENTICATED READ (coaches browsing the admin panel) ────
CREATE POLICY "auth_read_ladders" ON ranking_ladders
    FOR SELECT TO authenticated USING (true);

CREATE POLICY "auth_read_subcat_ranges" ON ranking_subcategory_ranges
    FOR SELECT TO authenticated USING (true);

CREATE POLICY "auth_read_weeks" ON ranking_weeks
    FOR SELECT TO authenticated USING (true);

CREATE POLICY "auth_read_matches" ON ranking_matches
    FOR SELECT TO authenticated USING (true);

-- ── AUTHENTICATED WRITE (only coaches can modify) ────────────
CREATE POLICY "auth_write_ladders" ON ranking_ladders
    FOR INSERT TO authenticated WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "auth_update_ladders" ON ranking_ladders
    FOR UPDATE TO authenticated USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_delete_ladders" ON ranking_ladders
    FOR DELETE TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "auth_write_subcat_ranges" ON ranking_subcategory_ranges
    FOR INSERT TO authenticated WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "auth_update_subcat_ranges" ON ranking_subcategory_ranges
    FOR UPDATE TO authenticated USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_delete_subcat_ranges" ON ranking_subcategory_ranges
    FOR DELETE TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "auth_write_weeks" ON ranking_weeks
    FOR INSERT TO authenticated WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "auth_update_weeks" ON ranking_weeks
    FOR UPDATE TO authenticated USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_delete_weeks" ON ranking_weeks
    FOR DELETE TO authenticated USING (auth.uid() IS NOT NULL);

CREATE POLICY "auth_write_matches" ON ranking_matches
    FOR INSERT TO authenticated WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "auth_update_matches" ON ranking_matches
    FOR UPDATE TO authenticated USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_delete_matches" ON ranking_matches
    FOR DELETE TO authenticated USING (auth.uid() IS NOT NULL);


-- ═══════════════════════════════════════════════════════════════
-- 6. GRANT SELECT TO ANON FOR PUBLIC READS
-- The anon role needs explicit SELECT permission on these tables
-- (RLS policies alone are not sufficient without GRANT).
-- ═══════════════════════════════════════════════════════════════
GRANT SELECT ON ranking_ladders TO anon;
GRANT SELECT ON ranking_subcategory_ranges TO anon;
GRANT SELECT ON ranking_weeks TO anon;
GRANT SELECT ON ranking_matches TO anon;

-- Also grant SELECT on players to anon so the public
-- leaderboard can display player names.
GRANT SELECT ON players TO anon;

-- Add a public read policy for players (needed for leaderboard JOINs)
-- Only if it doesn't already exist
DO $$ BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies
        WHERE tablename = 'players' AND policyname = 'anon_read_players'
    ) THEN
        EXECUTE 'CREATE POLICY "anon_read_players" ON players FOR SELECT TO anon USING (true)';
    END IF;
END $$;


-- ═══════════════════════════════════════════════════════════════
-- DONE. The ranking tables are ready.
-- Next: Run the ranking service to populate ladder data.
-- ═══════════════════════════════════════════════════════════════
