USE booking;

CREATE TABLE IF NOT EXISTS reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    booking_id INTEGER NOT NULL UNIQUE,
    customer_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
    title VARCHAR(150),
    comment TEXT,
    staff_rating INTEGER CHECK(staff_rating >= 1 AND staff_rating <= 5),
    cleanliness_rating INTEGER CHECK(cleanliness_rating >= 1 AND cleanliness_rating <= 5),
    comfort_rating INTEGER CHECK(comfort_rating >= 1 AND comfort_rating <= 5),
    value_rating INTEGER CHECK(value_rating >= 1 AND value_rating <= 5),
    is_approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (property_id) REFERENCES properties(id)
);
