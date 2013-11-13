CREATE TABLE IF NOT EXISTS threads (
	id       INTEGER PRIMARY KEY AUTO_INCREMENT,
	title    TEXT,
	content  TEXT,
	created_at DATETIME NOT NULL,
	updated_at DATETIME NOT NULL,
	INDEX updated_at(updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS entries (
	id          VARCHAR(36) PRIMARY KEY,
	thread_id   INTEGER NOT NULL,
	author_name VARCHAR(36),
	content     TEXT,
	created_at  DATETIME NOT NULL,
	updated_at  DATETIME NOT NULL,
	FOREIGN KEY(thread_id) REFERENCES threads(id),
    INDEX created_at(created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
