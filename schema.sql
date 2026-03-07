-- Table for players
CREATE TABLE players (
  id uuid DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  category TEXT NOT NULL, -- AA, A, B, C, D, Infantil
  modality TEXT NOT NULL, -- Singles, Doubles
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Table for tournament branding
CREATE TABLE config (
  id INT PRIMARY KEY,
  name TEXT,
  l_logo TEXT,
  r_logo TEXT
);
