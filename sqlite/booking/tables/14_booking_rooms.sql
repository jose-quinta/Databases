USE booking;

CREATE TABLE IF NOT EXISTS booking_rooms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    nights INTEGER NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);
