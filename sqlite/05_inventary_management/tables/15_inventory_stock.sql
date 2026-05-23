USE inventory;

CREATE TABLE IF NOT EXISTS inventory_stock (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    variant_id INTEGER,
    bin_id INTEGER NOT NULL,
    quantity DECIMAL(12,4) NOT NULL DEFAULT 0,
    lot_number VARCHAR(50),
    expiry_date DATE,
    last_count_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id),
    FOREIGN KEY (bin_id) REFERENCES warehouse_bins(id),
    UNIQUE(product_id, variant_id, bin_id, lot_number)
);
