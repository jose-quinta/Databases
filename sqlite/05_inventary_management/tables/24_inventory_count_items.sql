USE inventory;

CREATE TABLE IF NOT EXISTS inventory_count_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    count_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    variant_id INTEGER,
    bin_id INTEGER NOT NULL,
    expected_quantity DECIMAL(12,4) NOT NULL,
    counted_quantity DECIMAL(12,4) NOT NULL DEFAULT 0,
    discrepancy DECIMAL(12,4) GENERATED ALWAYS AS (counted_quantity - expected_quantity) STORED,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (count_id) REFERENCES inventory_counts(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id),
    FOREIGN KEY (bin_id) REFERENCES warehouse_bins(id)
);
