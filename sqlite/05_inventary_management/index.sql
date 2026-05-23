-- ============================================================
-- Inventory Management Database - SQLite
-- ============================================================
-- Run with: sqlite3 inventory.db < index.sql
-- ============================================================

-- Enable foreign key enforcement
PRAGMA foreign_keys = ON;

-- ============================================================
-- TABLES (order respects foreign key dependencies)
-- ============================================================

.read tables/01_roles.sql
.read tables/02_permissions.sql
.read tables/03_role_permission.sql
.read tables/04_categories.sql
.read tables/05_brands.sql
.read tables/06_units_of_measure.sql
.read tables/07_suppliers.sql
.read tables/08_products.sql
.read tables/09_product_variants.sql
.read tables/10_product_images.sql
.read tables/11_product_suppliers.sql
.read tables/12_warehouses.sql
.read tables/13_warehouse_zones.sql
.read tables/14_warehouse_bins.sql
.read tables/15_inventory_stock.sql
.read tables/16_stock_movements.sql
.read tables/17_purchase_orders.sql
.read tables/18_purchase_order_items.sql
.read tables/19_goods_receipts.sql
.read tables/20_goods_receipt_items.sql
.read tables/21_sales_orders.sql
.read tables/22_sales_order_items.sql
.read tables/23_inventory_counts.sql
.read tables/24_inventory_count_items.sql

-- ============================================================
-- TRIGGERS
-- ============================================================
.read triggers/01_update_categories_timestamp.sql
.read triggers/02_update_products_timestamp.sql
.read triggers/03_update_suppliers_timestamp.sql
.read triggers/04_update_inventory_stock_timestamp.sql
.read triggers/05_update_purchase_orders_timestamp.sql
.read triggers/06_update_sales_orders_timestamp.sql
.read triggers/07_update_inventory_counts_timestamp.sql
.read triggers/08_update_stock_on_receipt.sql
.read triggers/09_update_stock_on_sale.sql
.read triggers/10_apply_count_correction.sql

-- ============================================================
-- VIEWS
-- ============================================================
.read views/vw_stock_by_warehouse.sql
.read views/vw_inventory_movements.sql
.read views/vw_purchase_order_status.sql
.read views/vw_low_stock_alert.sql
.read views/vw_count_discrepancies.sql

-- ============================================================
-- SEED DATA
-- ============================================================
.read configurations/seed_data.sql

-- ============================================================
-- UDFs (User Defined Functions - SQLite 3.44+)
-- ============================================================
.read UDFs/fn_stock_on_hand.sql
.read UDFs/fn_inventory_value.sql
.read UDFs/fn_products_below_reorder.sql
.read UDFs/fn_bin_capacity_pct.sql

-- ============================================================
-- TRANSACTIONS (parameterized business logic templates)
-- ============================================================
.read transactions/tx_receive_goods.sql
.read transactions/tx_create_po.sql
.read transactions/tx_create_so.sql
.read transactions/tx_adjust_stock.sql
.read transactions/tx_transfer_stock.sql
