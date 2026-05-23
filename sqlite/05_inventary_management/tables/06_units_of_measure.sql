USE inventory;

CREATE TABLE IF NOT EXISTS units_of_measure (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50) NOT NULL,
    abbreviation VARCHAR(10) NOT NULL,
    type VARCHAR(20) NOT NULL CHECK(type IN ('unit','weight','volume','length','area')),
    is_active BOOLEAN DEFAULT TRUE
);
