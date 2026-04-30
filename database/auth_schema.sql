-- ============================================================
-- Club Nayar Campestre: Authentication & RLS Migration
-- Run this ONCE in the Supabase SQL Editor (Dashboard → SQL)
-- ============================================================

-- 1. COACH PROFILES (linked to Supabase auth.users)
CREATE TABLE IF NOT EXISTS public.coach_profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    display_name TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'coach',  -- 'admin' or 'coach'
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. ENABLE ROW LEVEL SECURITY ON ALL SENSITIVE TABLES
ALTER TABLE tournaments ENABLE ROW LEVEL SECURITY;
ALTER TABLE tournament_registrations ENABLE ROW LEVEL SECURITY;
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE coach_profiles ENABLE ROW LEVEL SECURITY;

-- Conditionally enable RLS on tables that may or may not exist yet
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'matches') THEN
        EXECUTE 'ALTER TABLE matches ENABLE ROW LEVEL SECURITY';
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'tournament_draws') THEN
        EXECUTE 'ALTER TABLE tournament_draws ENABLE ROW LEVEL SECURITY';
    END IF;
END $$;

-- 3. RLS POLICIES: Authenticated users only
-- Tournaments
CREATE POLICY "auth_select_tournaments" ON tournaments
    FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_all_tournaments" ON tournaments
    FOR ALL USING (auth.uid() IS NOT NULL);

-- Tournament Registrations
CREATE POLICY "auth_select_registrations" ON tournament_registrations
    FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_all_registrations" ON tournament_registrations
    FOR ALL USING (auth.uid() IS NOT NULL);

-- Players
CREATE POLICY "auth_select_players" ON players
    FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_all_players" ON players
    FOR ALL USING (auth.uid() IS NOT NULL);

-- Coach Profiles
CREATE POLICY "auth_select_coaches" ON coach_profiles
    FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "auth_all_coaches" ON coach_profiles
    FOR ALL USING (auth.uid() IS NOT NULL);

-- Matches (conditional)
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'matches') THEN
        EXECUTE 'CREATE POLICY "auth_select_matches" ON matches FOR SELECT USING (auth.uid() IS NOT NULL)';
        EXECUTE 'CREATE POLICY "auth_all_matches" ON matches FOR ALL USING (auth.uid() IS NOT NULL)';
    END IF;
END $$;

-- Tournament Draws (conditional)
DO $$ BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'tournament_draws') THEN
        EXECUTE 'CREATE POLICY "auth_select_draws" ON tournament_draws FOR SELECT USING (auth.uid() IS NOT NULL)';
        EXECUTE 'CREATE POLICY "auth_all_draws" ON tournament_draws FOR ALL USING (auth.uid() IS NOT NULL)';
    END IF;
END $$;

-- 4. LOOKUP TABLES: No RLS (public, non-sensitive)
-- categories and subcategories remain open.

-- ============================================================
-- DONE. Now create your first admin user in the Supabase
-- Dashboard under Authentication → Users → "Add User".
-- Then INSERT a coach_profiles row for that user:
--
--   INSERT INTO public.coach_profiles (id, display_name, role)
--   VALUES ('<your-auth-user-uuid>', 'Hugo Aguirre', 'admin');
-- ============================================================
