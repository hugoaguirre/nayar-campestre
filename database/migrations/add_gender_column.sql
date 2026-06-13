-- ============================================================
-- Migration: Add gender column to players table
-- Run this in the Supabase SQL Editor (Dashboard → SQL)
-- ============================================================

-- 1. Add gender column with CHECK constraint
ALTER TABLE players ADD COLUMN IF NOT EXISTS gender TEXT CHECK (gender IN ('M', 'F'));

-- 2. Backfill existing players from tournament_registrations
-- Players registered in "Varonil" category → 'M'
UPDATE players SET gender = 'M'
WHERE id IN (
    SELECT DISTINCT tr.player_id
    FROM tournament_registrations tr
    JOIN categories c ON tr.category_id = c.id
    WHERE c.name = 'Varonil'
) AND gender IS NULL;

-- Players registered in "Femenil" category → 'F'
UPDATE players SET gender = 'F'
WHERE id IN (
    SELECT DISTINCT tr.player_id
    FROM tournament_registrations tr
    JOIN categories c ON tr.category_id = c.id
    WHERE c.name = 'Femenil'
) AND gender IS NULL;

-- Done. Verify with:
-- SELECT first_name, last_name, gender FROM players ORDER BY first_name;
