USE booking;

CREATE TABLE IF NOT EXISTS room_types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    property_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    max_guests INTEGER NOT NULL DEFAULT 2,
    max_adults INTEGER DEFAULT 2,
    max_children INTEGER DEFAULT 0,
    size_sqm DECIMAL(8,2),
    bed_type VARCHAR(50) DEFAULT 'queen',
    base_price DECIMAL(10,2) NOT NULL,
    total_rooms INTEGER NOT NULL DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES properties(id) ON DELETE CASCADE
);
