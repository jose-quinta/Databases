USE booking;

CREATE TABLE IF NOT EXISTS customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL UNIQUE,
    passport VARCHAR(50),
    nationality VARCHAR(50),
    birth_date DATE,
    gender VARCHAR(10),
    preferred_language VARCHAR(10) DEFAULT 'en',
    special_needs TEXT,
    total_bookings INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
