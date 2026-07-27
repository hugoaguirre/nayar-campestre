-- ============================================================
-- Migration: ranking_match_drafts
-- Purpose:   Staging table for match results before bulk commit
-- ============================================================

CREATE TABLE IF NOT EXISTS ranking_match_drafts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    match_id UUID NOT NULL REFERENCES ranking_matches(id) ON DELETE CASCADE,
    set1_defender SMALLINT,
    set1_challenger SMALLINT,
    set2_defender SMALLINT,
    set2_challenger SMALLINT,
    set3_defender SMALLINT,
    set3_challenger SMALLINT,
    winner_id UUID NOT NULL REFERENCES players(id),
    is_forfeit BOOLEAN DEFAULT FALSE,
    entered_by UUID REFERENCES auth.users(id),
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(match_id)  -- Only one draft per match
);

-- ── Row Level Security ──────────────────────────────────────
ALTER TABLE ranking_match_drafts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Coaches can manage drafts"
    ON ranking_match_drafts
    FOR ALL
    USING (auth.role() = 'authenticated')
    WITH CHECK (auth.role() = 'authenticated');

-- ── Auto-update updated_at on UPSERT ────────────────────────
CREATE OR REPLACE FUNCTION update_draft_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_draft_updated_at
    BEFORE UPDATE ON ranking_match_drafts
    FOR EACH ROW
    EXECUTE FUNCTION update_draft_updated_at();
