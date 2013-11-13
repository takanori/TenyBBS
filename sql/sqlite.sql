CREATE TABLE IF NOT EXISTS thread (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  title      TEXT,
  content    TEXT,
  created_at INTEGER
);

CREATE TABLE IF NOT EXISTS response (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  content    TEXT,
  created_at INTEGER
);

