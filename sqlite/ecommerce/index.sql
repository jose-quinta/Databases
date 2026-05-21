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

-- Independent tables
.read tables/roles.sql
.read tables/permissions.sql
.read tables/categories.sql
.read tables/coupons.sql

-- Dependent tables
.read tables/role_permission.sql
.read tables/users.sql
.read tables/products.sql
.read tables/customers.sql
.read tables/addresses.sql
.read tables/carts.sql
.read tables/product_images.sql
.read tables/cart_items.sql
.read tables/reviews.sql
.read tables/orders.sql
.read tables/order_items.sql
.read tables/payments.sql
.read tables/coupon_usages.sql

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
