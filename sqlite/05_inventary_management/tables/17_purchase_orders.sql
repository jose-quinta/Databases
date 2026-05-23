USE inventory;

CREATE TABLE IF NOT EXISTS purchase_orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    supplier_id INTEGER NOT NULL,
    warehouse_id INTEGER NOT NULL,
    po_number VARCHAR(50) NOT NULL UNIQUE,
    order_date DATE NOT NULL DEFAULT (DATE('now')),
    expected_date DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','sent','confirmed','received','cancelled')),
    subtotal DECIMAL(14,2) DEFAULT 0.00,
    tax DECIMAL(14,2) DEFAULT 0.00,
    total DECIMAL(14,2) DEFAULT 0.00,
    notes TEXT,
    created_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(id)
);
