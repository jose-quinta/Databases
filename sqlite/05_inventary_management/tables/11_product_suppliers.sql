USE inventory;

CREATE TABLE IF NOT EXISTS product_suppliers (
    product_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    supplier_sku VARCHAR(50),
    price DECIMAL(12,4) NOT NULL,
    lead_time_days INTEGER DEFAULT 1,
    min_order_qty DECIMAL(12,4) DEFAULT 1,
    is_preferred BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (product_id, supplier_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
);
