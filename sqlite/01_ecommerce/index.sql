-- ============================================================
-- Ecommerce Database - SQLite
-- ============================================================
-- Run with: sqlite3 ecommerce.db < index.sql
-- ============================================================

-- Enable foreign key enforcement
PRAGMA foreign_keys = ON;

-- ============================================================
-- TABLES (order respects foreign key dependencies)
-- ============================================================

.read tables/01_roles.sql
.read tables/02_permissions.sql
.read tables/03_categories.sql
.read tables/04_coupons.sql
.read tables/05_role_permission.sql
.read tables/06_users.sql
.read tables/07_products.sql
.read tables/08_customers.sql
.read tables/09_addresses.sql
.read tables/10_carts.sql
.read tables/11_product_images.sql
.read tables/12_cart_items.sql
.read tables/13_reviews.sql
.read tables/14_orders.sql
.read tables/15_order_items.sql
.read tables/16_payments.sql
.read tables/17_coupon_usages.sql

-- ============================================================
-- TRIGGERS
-- ============================================================
.read triggers/update_categories_timestamp.sql
.read triggers/update_users_timestamp.sql
.read triggers/update_products_timestamp.sql
.read triggers/update_orders_timestamp.sql
.read triggers/update_customers_timestamp.sql
.read triggers/update_addresses_timestamp.sql
.read triggers/update_carts_timestamp.sql
.read triggers/update_reviews_timestamp.sql
.read triggers/update_payments_timestamp.sql
.read triggers/update_coupons_timestamp.sql
.read triggers/decrease_stock_on_order.sql
.read triggers/restore_stock_on_cancel.sql

-- ============================================================
-- VIEWS
-- ============================================================
.read views/vw_product_catalog.sql
.read views/vw_order_summary.sql
.read views/vw_user_cart.sql
.read views/vw_top_sellers.sql

-- ============================================================
-- SEED DATA
-- ============================================================
.read configurations/seed_data.sql

-- ============================================================
-- UDFs (User Defined Functions - SQLite 3.44+)
-- ============================================================
.read UDFs/fn_calculate_discount.sql
.read UDFs/fn_calculate_tax.sql
.read UDFs/fn_order_subtotal.sql
.read UDFs/fn_is_coupon_valid.sql

-- ============================================================
-- TRANSACTIONS (parameterized business logic templates)
-- ============================================================
.read transactions/tx_register_user.sql
.read transactions/tx_add_to_cart.sql
.read transactions/tx_place_order.sql
.read transactions/tx_process_payment.sql
.read transactions/tx_cancel_order.sql

-- ============================================================
-- PROCEDURES (reference documentation)
-- ============================================================
-- .read procedures/sp_place_order.sql
-- .read procedures/sp_apply_coupon.sql
