USE inventory;

CREATE TABLE IF NOT EXISTS sales_orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_number VARCHAR(50) NOT NULL UNIQUE,
    customer_name VARCHAR(150),
    customer_email VARCHAR(100),
    order_date DATE NOT NULL DEFAULT (DATE('now')),
    status VARCHAR(20) NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','confirmed','picking','shipped','delivered','cancelled')),
    warehouse_id INTEGER NOT NULL,
    subtotal DECIMAL(14,2) DEFAULT 0.00,
    tax DECIMAL(14,2) DEFAULT 0.00,
    total DECIMAL(14,2) DEFAULT 0.00,
    notes TEXT,
    created_by INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(id)
);
