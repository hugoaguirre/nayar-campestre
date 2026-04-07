-- Migration: 002_category_to_registrations.sql
-- Goal: Decouple categories from players table and move them to tournament registrations.

-- 1. ADD categories and subcategories to the registrations table (if they don't already exist)
ALTER TABLE tournament_registrations 
ADD COLUMN IF NOT EXISTS category_id UUID REFERENCES categories(id),
ADD COLUMN IF NOT EXISTS subcategory_id UUID REFERENCES subcategories(id);

-- 2. REMOVE them from the global players table
ALTER TABLE players DROP COLUMN IF EXISTS category_id;
ALTER TABLE players DROP COLUMN IF EXISTS subcategory_id;

-- 3. Cleanup: Ensure player/partner structure is consistent
-- (This ensures the bi-directional doubles link remains stable)
IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='tournament_registrations' AND column_name='partner_id') THEN
    ALTER TABLE tournament_registrations ADD COLUMN partner_id UUID REFERENCES players(id) ON DELETE SET NULL;
END IF;
