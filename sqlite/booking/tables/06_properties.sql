USE booking;

CREATE TABLE IF NOT EXISTS properties (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(150) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    property_type VARCHAR(50) NOT NULL DEFAULT 'hotel' CHECK(property_type IN ('hotel','hostel','cabin','resort','apartment','bnb')),
    address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL,
    zip_code VARCHAR(20),
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7),
    stars INTEGER DEFAULT 3 CHECK(stars >= 1 AND stars <= 5),
    currency VARCHAR(3) DEFAULT 'USD',
    check_in_time TIME DEFAULT '15:00',
    check_out_time TIME DEFAULT '11:00',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP
);
