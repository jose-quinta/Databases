USE booking;

CREATE TABLE IF NOT EXISTS seasonal_pricing (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    room_type_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    min_nights INTEGER DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (room_type_id) REFERENCES room_types(id) ON DELETE CASCADE
);
