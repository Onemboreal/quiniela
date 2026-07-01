-- EJECUTA ESTO EN SUPABASE SQL EDITOR

CREATE TABLE IF NOT EXISTS participants (
  id              UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  username        TEXT UNIQUE NOT NULL,
  display_name    TEXT NOT NULL,
  password_hash   TEXT NOT NULL,
  registered_at   TIMESTAMPTZ DEFAULT NOW(),
  paid            BOOLEAN DEFAULT FALSE,
  score           INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS picks (
  id              UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  participant_id  UUID REFERENCES participants(id) ON DELETE CASCADE,
  match_id        TEXT NOT NULL,
  pick_team       TEXT NOT NULL,
  score1          INTEGER,
  score2          INTEGER,
  updated_at      TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(participant_id, match_id)
);

-- Permisos (necesario para que funcione desde el browser)
ALTER TABLE participants ENABLE ROW LEVEL SECURITY;
ALTER TABLE picks ENABLE ROW LEVEL SECURITY;

CREATE POLICY "lectura_publica_participants" ON participants FOR SELECT USING (true);
CREATE POLICY "insertar_participants" ON participants FOR INSERT WITH CHECK (true);
CREATE POLICY "actualizar_participants" ON participants FOR UPDATE USING (true);

CREATE POLICY "lectura_publica_picks" ON picks FOR SELECT USING (true);
CREATE POLICY "insertar_picks" ON picks FOR INSERT WITH CHECK (true);
CREATE POLICY "actualizar_picks" ON picks FOR UPDATE USING (true);
