USE inventory;

CREATE TABLE IF NOT EXISTS stock_movements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    variant_id INTEGER,
    from_bin_id INTEGER,
    to_bin_id INTEGER,
    quantity DECIMAL(12,4) NOT NULL,
    movement_type VARCHAR(30) NOT NULL CHECK(movement_type IN ('purchase_receipt','sales_issuance','transfer_out','transfer_in','adjustment_add','adjustment_subtract','return','count_correction')),
    reference_type VARCHAR(30),
    reference_id INTEGER,
    lot_number VARCHAR(50),
    notes TEXT,
    created_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (variant_id) REFERENCES product_variants(id),
    FOREIGN KEY (from_bin_id) REFERENCES warehouse_bins(id),
    FOREIGN KEY (to_bin_id) REFERENCES warehouse_bins(id)
);
