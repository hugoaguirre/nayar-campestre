-- ============================================================
-- Migration: Split weekend schedule into Saturday + Sunday
-- Run this in the Supabase SQL Editor BEFORE deploying code.
-- ============================================================

-- 1. Rename existing weekend columns → Sunday
ALTER TABLE ranking_weeks RENAME COLUMN weekend_first_game TO sunday_first_game;
ALTER TABLE ranking_weeks RENAME COLUMN weekend_last_game  TO sunday_last_game;

-- 2. Add Saturday columns (defaulting to same values as the old weekend config)
ALTER TABLE ranking_weeks
    ADD COLUMN saturday_first_game TIME NOT NULL DEFAULT '10:00',
    ADD COLUMN saturday_last_game  TIME NOT NULL DEFAULT '19:00';

-- 3. Back-fill Saturday columns from existing Sunday values
--    so that previously created weeks retain their original schedule.
UPDATE ranking_weeks
SET saturday_first_game = sunday_first_game,
    saturday_last_game  = sunday_last_game;

-- ============================================================
-- DONE. Existing rows now have identical Saturday/Sunday values
-- matching what was previously the unified "weekend" schedule.
-- New weeks will allow independent configuration.
-- ============================================================
