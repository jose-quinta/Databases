USE booking;

CREATE TABLE IF NOT EXISTS rooms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    room_type_id INTEGER NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    floor INTEGER,
    is_available BOOLEAN DEFAULT TRUE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE CASCADE,
    UNIQUE(room_type_id, room_number)
);
