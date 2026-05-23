USE booking;

CREATE TABLE IF NOT EXISTS booking_promotions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER NOT NULL,
    promotion_id INTEGER NOT NULL,
    discount_amount DECIMAL(12,2) NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE,
    FOREIGN KEY (promotion_id) REFERENCES promotions(id)
);
