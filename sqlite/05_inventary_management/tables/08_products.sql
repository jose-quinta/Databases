USE inventory;

CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL,
    brand_id INTEGER,
    uom_id INTEGER NOT NULL,
    sku VARCHAR(50) NOT NULL UNIQUE,
    barcode VARCHAR(100),
    name VARCHAR(150) NOT NULL,
    description TEXT,
    purchase_price DECIMAL(12,4) DEFAULT 0.0000,
    selling_price DECIMAL(12,4) DEFAULT 0.0000,
    weight DECIMAL(10,4),
    volume DECIMAL(10,4),
    min_stock DECIMAL(12,4) DEFAULT 0,
    max_stock DECIMAL(12,4) DEFAULT 0,
    reorder_point DECIMAL(12,4) DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (brand_id) REFERENCES brands(id),
    FOREIGN KEY (uom_id) REFERENCES units_of_measure(id)
);
