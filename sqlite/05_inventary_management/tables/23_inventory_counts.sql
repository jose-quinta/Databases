USE inventory;

CREATE TABLE IF NOT EXISTS inventory_counts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    warehouse_id INTEGER NOT NULL,
    zone_id INTEGER,
    count_date DATE NOT NULL DEFAULT (DATE('now')),
    status VARCHAR(20) NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','in_progress','completed','approved')),
    notes TEXT,
    created_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(id),
    FOREIGN KEY (zone_id) REFERENCES warehouse_zones(id)
);
