CREATE TABLE IF NOT EXISTS thread (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  title      TEXT,
  content    TEXT,
  created_at INTEGER
);

CREATE TABLE IF NOT EXISTS response (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  thread_id  INTEGER,
  content    TEXT,
  created_at INTEGER
);

