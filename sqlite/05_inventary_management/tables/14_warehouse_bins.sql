USE inventory;

CREATE TABLE IF NOT EXISTS warehouse_bins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    zone_id INTEGER NOT NULL,
    code VARCHAR(30) NOT NULL,
    aisle VARCHAR(20),
    rack VARCHAR(20),
    level VARCHAR(10),
    max_weight DECIMAL(10,2),
    max_volume DECIMAL(10,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (zone_id) REFERENCES warehouse_zones(id) ON DELETE CASCADE,
    UNIQUE(zone_id, code)
);
