USE inventory;

-- Seed roles
INSERT OR IGNORE INTO roles (id, name) VALUES (1, 'Admin');
INSERT OR IGNORE INTO roles (id, name) VALUES (2, 'Warehouse Manager');
INSERT OR IGNORE INTO roles (id, name) VALUES (3, 'Operator');

-- Seed permissions
INSERT OR IGNORE INTO permissions (id, name) VALUES (1, 'manage_products');
INSERT OR IGNORE INTO permissions (id, name) VALUES (2, 'manage_purchase_orders');
INSERT OR IGNORE INTO permissions (id, name) VALUES (3, 'manage_sales_orders');
INSERT OR IGNORE INTO permissions (id, name) VALUES (4, 'manage_inventory');
INSERT OR IGNORE INTO permissions (id, name) VALUES (5, 'manage_warehouses');
INSERT OR IGNORE INTO permissions (id, name) VALUES (6, 'manage_suppliers');
INSERT OR IGNORE INTO permissions (id, name) VALUES (7, 'view_reports');
INSERT OR IGNORE INTO permissions (id, name) VALUES (8, 'receive_goods');
INSERT OR IGNORE INTO permissions (id, name) VALUES (9, 'pick_orders');
INSERT OR IGNORE INTO permissions (id, name) VALUES (10, 'count_inventory');
INSERT OR IGNORE INTO permissions (id, name) VALUES (11, 'adjust_stock');
INSERT OR IGNORE INTO permissions (id, name) VALUES (12, 'view_products');

-- Assign permissions to Admin (all)
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 1);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 2);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 3);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 4);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 5);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 6);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 7);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 8);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 9);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 10);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 11);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 12);

-- Assign permissions to Warehouse Manager
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 1);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 2);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 4);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 6);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 7);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 8);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 10);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 11);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 12);

-- Assign permissions to Operator
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (3, 8);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (3, 9);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (3, 10);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (3, 12);

-- Seed categories (with hierarchy)
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (1, 'Electronics', 'electronics', 'Electronic devices and components', NULL);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (2, 'Computers', 'computers', 'Desktop and laptop computers', 1);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (3, 'Computer Accessories', 'computer-accessories', 'Peripherals and computer parts', 1);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (4, 'Clothing', 'clothing', 'Apparel and fashion items', NULL);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (5, 'Footwear', 'footwear', 'Shoes and footwear', 4);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (6, 'Home & Garden', 'home-garden', 'Home improvement and garden supplies', NULL);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (7, 'Tools', 'tools', 'Hand and power tools', 6);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (8, 'Cleaning Supplies', 'cleaning-supplies', 'Cleaning products and equipment', 6);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (9, 'Food & Beverage', 'food-beverage', 'Food and drink products', NULL);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (10, 'Packaging', 'packaging', 'Boxes, tape, and shipping materials', NULL);
INSERT OR IGNORE INTO categories (id, name, slug, description, parent_id) VALUES (11, 'Health & Safety', 'health-safety', 'PPE and safety equipment', NULL);

-- Seed brands
INSERT OR IGNORE INTO brands (id, name, description) VALUES (1, 'TechPro', 'Professional technology equipment');
INSERT OR IGNORE INTO brands (id, name, description) VALUES (2, 'HomeStyle', 'Home and lifestyle products');
INSERT OR IGNORE INTO brands (id, name, description) VALUES (3, 'SafeGuard', 'Safety and protection equipment');
INSERT OR IGNORE INTO brands (id, name, description) VALUES (4, 'PackRight', 'Packaging and shipping solutions');
INSERT OR IGNORE INTO brands (id, name, description) VALUES (5, 'FreshChoice', 'Food and beverage products');

-- Seed units of measure
INSERT OR IGNORE INTO units_of_measure (id, name, abbreviation, type) VALUES (1, 'Piece', 'pc', 'unit');
INSERT OR IGNORE INTO units_of_measure (id, name, abbreviation, type) VALUES (2, 'Kilogram', 'kg', 'weight');
INSERT OR IGNORE INTO units_of_measure (id, name, abbreviation, type) VALUES (3, 'Liter', 'L', 'volume');
INSERT OR IGNORE INTO units_of_measure (id, name, abbreviation, type) VALUES (4, 'Meter', 'm', 'length');
INSERT OR IGNORE INTO units_of_measure (id, name, abbreviation, type) VALUES (5, 'Square Meter', 'm2', 'area');
INSERT OR IGNORE INTO units_of_measure (id, name, abbreviation, type) VALUES (6, 'Box', 'box', 'unit');
INSERT OR IGNORE INTO units_of_measure (id, name, abbreviation, type) VALUES (7, 'Pack', 'pk', 'unit');
INSERT OR IGNORE INTO units_of_measure (id, name, abbreviation, type) VALUES (8, 'Gram', 'g', 'weight');

-- Seed suppliers
INSERT OR IGNORE INTO suppliers (id, code, company_name, contact_name, email, phone, city) VALUES (1, 'SUP001', 'TechSource Mexico', 'Carlos Lopez', 'carlos@techsource.mx', '555-0101', 'Mexico City');
INSERT OR IGNORE INTO suppliers (id, code, company_name, contact_name, email, phone, city) VALUES (2, 'SUP002', 'Industrias del Hogar', 'Maria Garcia', 'maria@industriasdelhogar.com', '555-0102', 'Guadalajara');
INSERT OR IGNORE INTO suppliers (id, code, company_name, contact_name, email, phone, city) VALUES (3, 'SUP003', 'SafetyFirst Supplies', 'Juan Martinez', 'juan@safetyfirst.mx', '555-0103', 'Monterrey');
INSERT OR IGNORE INTO suppliers (id, code, company_name, contact_name, email, phone, city) VALUES (4, 'SUP004', 'Empaques del Norte', 'Ana Rodriguez', 'ana@empaquesnorte.mx', '555-0104', 'Chihuahua');
INSERT OR IGNORE INTO suppliers (id, code, company_name, contact_name, email, phone, city) VALUES (5, 'SUP005', 'Alimentos Selectos', 'Pedro Sanchez', 'pedro@alimentosselectos.mx', '555-0105', 'Puebla');

-- Seed warehouses
INSERT OR IGNORE INTO warehouses (id, code, name, city) VALUES (1, 'WH-MTY-01', 'Monterrey Main Warehouse', 'Monterrey');
INSERT OR IGNORE INTO warehouses (id, code, name, city) VALUES (2, 'WH-GDL-01', 'Guadalajara Distribution Center', 'Guadalajara');
INSERT OR IGNORE INTO warehouses (id, code, name, city) VALUES (3, 'WH-CDMX-01', 'Mexico City Central Warehouse', 'Mexico City');

-- Seed warehouse zones
INSERT OR IGNORE INTO warehouse_zones (id, warehouse_id, code, name, zone_type) VALUES (1, 1, 'STR-A', 'Storage Zone A', 'storage');
INSERT OR IGNORE INTO warehouse_zones (id, warehouse_id, code, name, zone_type) VALUES (2, 1, 'PKG-A', 'Picking Zone A', 'picking');
INSERT OR IGNORE INTO warehouse_zones (id, warehouse_id, code, name, zone_type) VALUES (3, 1, 'RECV', 'Receiving Area', 'receiving');
INSERT OR IGNORE INTO warehouse_zones (id, warehouse_id, code, name, zone_type) VALUES (4, 1, 'QUAR', 'Quarantine Zone', 'quarantine');
INSERT OR IGNORE INTO warehouse_zones (id, warehouse_id, code, name, zone_type) VALUES (5, 1, 'SHIP', 'Shipping Zone', 'shipping');
INSERT OR IGNORE INTO warehouse_zones (id, warehouse_id, code, name, zone_type) VALUES (6, 2, 'STR-B', 'Storage Zone B', 'storage');
INSERT OR IGNORE INTO warehouse_zones (id, warehouse_id, code, name, zone_type) VALUES (7, 2, 'PKG-B', 'Picking Zone B', 'picking');
INSERT OR IGNORE INTO warehouse_zones (id, warehouse_id, code, name, zone_type) VALUES (8, 3, 'STR-C', 'Storage Zone C', 'storage');

-- Seed bins
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (1, 1, 'A-01-01', 'A', '01', '1');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (2, 1, 'A-01-02', 'A', '01', '2');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (3, 1, 'A-02-01', 'A', '02', '1');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (4, 1, 'A-02-02', 'A', '02', '2');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (5, 2, 'P-01-01', 'P', '01', '1');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (6, 2, 'P-01-02', 'P', '01', '2');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (7, 3, 'R-01-01', 'R', '01', '1');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (8, 6, 'B-01-01', 'B', '01', '1');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (9, 6, 'B-01-02', 'B', '01', '2');
INSERT OR IGNORE INTO warehouse_bins (id, zone_id, code, aisle, rack, level) VALUES (10, 8, 'C-01-01', 'C', '01', '1');

-- Seed products
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (1, 2, 1, 1, 'LAP-001', '750100000001', 'Pro Laptop 15"', 850.0000, 1299.9900, 2.5000, 5, 10);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (2, 3, 1, 1, 'MOU-001', '750100000002', 'Wireless Mouse', 12.5000, 24.9900, 0.1500, 20, 50);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (3, 3, 1, 1, 'KEY-001', '750100000003', 'Mechanical Keyboard', 35.0000, 69.9900, 0.8000, 10, 25);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (4, 5, 2, 1, 'SHO-001', '750100000004', 'Running Shoes', 28.0000, 59.9900, 0.6000, 15, 30);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (5, 7, 2, 1, 'DRL-001', '750100000005', 'Cordless Drill 18V', 45.0000, 89.9900, 1.8000, 5, 10);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (6, 8, 2, 2, 'CLN-001', '750100000006', 'All-Purpose Cleaner 5L', 8.0000, 18.9900, 5.0000, 10, 20);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (7, 11, 3, 1, 'PPE-001', '750100000007', 'Disposable Gloves Box 100pc', 6.5000, 14.9900, 0.4000, 20, 50);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (8, 11, 3, 1, 'PPE-002', '750100000008', 'Safety Glasses', 3.0000, 7.9900, 0.1000, 15, 30);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (9, 10, 4, 6, 'PKG-001', '750100000009', 'Cardboard Box 40x30x20cm', 1.5000, 3.9900, 0.3000, 30, 100);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (10, 10, 4, 1, 'PKG-002', '750100000010', 'Packing Tape 50m', 0.8000, 2.4900, 0.2000, 20, 50);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (11, 2, 1, 1, 'MON-001', '750100000011', '27" 4K Monitor', 220.0000, 399.9900, 4.5000, 3, 8);
INSERT OR IGNORE INTO products (id, category_id, brand_id, uom_id, sku, barcode, name, purchase_price, selling_price, weight, min_stock, reorder_point) VALUES (12, 9, 5, 2, 'COF-001', '750100000012', 'Premium Coffee Beans 1kg', 10.0000, 24.9900, 1.0000, 15, 40);

-- Seed product variants
INSERT OR IGNORE INTO product_variants (id, product_id, name, sku_suffix, barcode, purchase_price, selling_price) VALUES (1, 4, 'Size 7 US', 'S7', '750100000004-S7', 28.0000, 59.9900);
INSERT OR IGNORE INTO product_variants (id, product_id, name, sku_suffix, barcode, purchase_price, selling_price) VALUES (2, 4, 'Size 8 US', 'S8', '750100000004-S8', 28.0000, 59.9900);
INSERT OR IGNORE INTO product_variants (id, product_id, name, sku_suffix, barcode, purchase_price, selling_price) VALUES (3, 4, 'Size 9 US', 'S9', '750100000004-S9', 28.0000, 59.9900);
INSERT OR IGNORE INTO product_variants (id, product_id, name, sku_suffix, barcode, purchase_price, selling_price) VALUES (4, 12, 'Dark Roast', 'DR', '750100000012-DR', 11.0000, 26.9900);
INSERT OR IGNORE INTO product_variants (id, product_id, name, sku_suffix, barcode, purchase_price, selling_price) VALUES (5, 12, 'Medium Roast', 'MR', '750100000012-MR', 10.0000, 24.9900);

-- Seed product-supplier relationships
INSERT OR IGNORE INTO product_suppliers (product_id, supplier_id, supplier_sku, price, lead_time_days, min_order_qty, is_preferred) VALUES (1, 1, 'TS-LAP-001', 850.0000, 5, 1, TRUE);
INSERT OR IGNORE INTO product_suppliers (product_id, supplier_id, supplier_sku, price, lead_time_days, min_order_qty, is_preferred) VALUES (2, 1, 'TS-MOU-001', 12.5000, 3, 10, TRUE);
INSERT OR IGNORE INTO product_suppliers (product_id, supplier_id, supplier_sku, price, lead_time_days, min_order_qty, is_preferred) VALUES (4, 2, 'IDH-SHO-001', 28.0000, 7, 5, TRUE);
INSERT OR IGNORE INTO product_suppliers (product_id, supplier_id, supplier_sku, price, lead_time_days, min_order_qty, is_preferred) VALUES (7, 3, 'SFS-GLO-001', 6.5000, 4, 20, TRUE);
INSERT OR IGNORE INTO product_suppliers (product_id, supplier_id, supplier_sku, price, lead_time_days, min_order_qty, is_preferred) VALUES (9, 4, 'EDN-BOX-001', 1.5000, 2, 50, TRUE);
INSERT OR IGNORE INTO product_suppliers (product_id, supplier_id, supplier_sku, price, lead_time_days, min_order_qty, is_preferred) VALUES (12, 5, 'AS-COF-001', 10.0000, 3, 10, TRUE);

-- Seed inventory stock (initial stock in Monterrey main warehouse)
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (1, NULL, 1, 25, 'LOT-LAP-001');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (2, NULL, 1, 100, 'LOT-MOU-001');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (3, NULL, 2, 30, 'LOT-KEY-001');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (4, 1, 3, 20, 'LOT-SHO-S7');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (4, 2, 3, 25, 'LOT-SHO-S8');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (4, 3, 3, 15, 'LOT-SHO-S9');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (5, NULL, 4, 12, 'LOT-DRL-001');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (6, NULL, 4, 40, 'LOT-CLN-001');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (7, NULL, 1, 200, 'LOT-PPE-001');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (8, NULL, 1, 150, 'LOT-PPE-002');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (9, NULL, 5, 500, 'LOT-PKG-001');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (10, NULL, 5, 200, 'LOT-PKG-002');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (11, NULL, 2, 8, 'LOT-MON-001');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (12, 4, 3, 30, 'LOT-COF-DR');
INSERT OR IGNORE INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number) VALUES (12, 5, 3, 25, 'LOT-COF-MR');

-- Seed purchase orders
INSERT OR IGNORE INTO purchase_orders (id, supplier_id, warehouse_id, po_number, order_date, expected_date, status, subtotal, total) VALUES (1, 1, 1, 'PO-2025-001', '2025-05-01', '2025-05-08', 'received', 4250.00, 4250.00);
INSERT OR IGNORE INTO purchase_orders (id, supplier_id, warehouse_id, po_number, order_date, expected_date, status, subtotal, total) VALUES (2, 2, 1, 'PO-2025-002', '2025-05-05', '2025-05-15', 'sent', 420.00, 420.00);
INSERT OR IGNORE INTO purchase_orders (id, supplier_id, warehouse_id, po_number, order_date, expected_date, status, subtotal, total) VALUES (3, 3, 1, 'PO-2025-003', '2025-05-10', '2025-05-17', 'confirmed', 325.00, 325.00);

-- Seed purchase order items
INSERT OR IGNORE INTO purchase_order_items (id, po_id, product_id, quantity_ordered, quantity_received, unit_price, subtotal) VALUES (1, 1, 1, 5, 5, 850.0000, 4250.00);
INSERT OR IGNORE INTO purchase_order_items (id, po_id, product_id, quantity_ordered, quantity_received, unit_price, subtotal) VALUES (2, 2, 4, 15, 0, 28.0000, 420.00);
INSERT OR IGNORE INTO purchase_order_items (id, po_id, product_id, quantity_ordered, quantity_received, unit_price, subtotal) VALUES (3, 3, 7, 50, 0, 6.5000, 325.00);

-- Seed goods receipts (for PO-2025-001)
INSERT OR IGNORE INTO goods_receipts (id, po_id, receipt_date, reference_number) VALUES (1, 1, '2025-05-09', 'GR-2025-001');

-- Seed goods receipt items
INSERT OR IGNORE INTO goods_receipt_items (id, receipt_id, po_item_id, product_id, quantity_received, bin_id) VALUES (1, 1, 1, 1, 5, 2);

-- Seed sales orders
INSERT OR IGNORE INTO sales_orders (id, order_number, customer_name, customer_email, order_date, status, warehouse_id, subtotal, total) VALUES (1, 'SO-2025-001', 'Juan Perez', 'juan@email.com', '2025-05-12', 'shipped', 1, 1324.95, 1324.95);
INSERT OR IGNORE INTO sales_orders (id, order_number, customer_name, customer_email, order_date, status, warehouse_id, subtotal, total) VALUES (2, 'SO-2025-002', 'Maria Lopez', 'maria@email.com', '2025-05-13', 'confirmed', 1, 99.97, 99.97);

-- Seed sales order items
INSERT OR IGNORE INTO sales_order_items (id, so_id, product_id, quantity, unit_price, subtotal, bin_id) VALUES (1, 1, 1, 1, 1299.9900, 1299.99, 5);
INSERT OR IGNORE INTO sales_order_items (id, so_id, product_id, quantity, unit_price, subtotal, bin_id) VALUES (2, 1, 2, 1, 24.9900, 24.99, 5);
INSERT OR IGNORE INTO sales_order_items (id, so_id, product_id, quantity, unit_price, subtotal, bin_id) VALUES (3, 2, 2, 2, 24.9900, 49.98, 5);
INSERT OR IGNORE INTO sales_order_items (id, so_id, product_id, quantity, unit_price, subtotal, bin_id) VALUES (4, 2, 10, 2, 2.4900, 4.98, 5);
INSERT OR IGNORE INTO sales_order_items (id, so_id, product_id, quantity, unit_price, subtotal, bin_id) VALUES (5, 2, 12, 1, 24.9900, 24.99, 5);
INSERT OR IGNORE INTO sales_order_items (id, so_id, product_id, quantity, unit_price, subtotal, bin_id) VALUES (6, 2, 12, 2, 24.9900, 49.98, 5);
INSERT OR IGNORE INTO sales_order_items (id, so_id, product_id, quantity, unit_price, subtotal, bin_id) VALUES (7, 2, 11, 1, 399.9900, 399.99, 5);
