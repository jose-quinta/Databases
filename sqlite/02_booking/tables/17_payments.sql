USE booking;

CREATE TABLE IF NOT EXISTS payments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    method VARCHAR(50) NOT NULL CHECK(method IN ('credit_card','debit_card','cash','transfer','paypal','stripe')),
    transaction_id VARCHAR(100),
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','completed','failed','refunded')),
    paid_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);
