USE inventory;

CREATE TABLE IF NOT EXISTS product_variants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    sku_suffix VARCHAR(30),
    barcode VARCHAR(100),
    purchase_price DECIMAL(12,4),
    selling_price DECIMAL(12,4),
    weight DECIMAL(10,4),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    UNIQUE(product_id, name)
);
