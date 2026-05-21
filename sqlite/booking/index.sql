-- ============================================================
-- Booking Database - SQLite
-- ============================================================
-- Run with: sqlite3 booking.db < index.sql
-- ============================================================

PRAGMA foreign_keys = ON;

-- ============================================================
-- TABLES
-- ============================================================
.read tables/01_roles.sql
.read tables/02_permissions.sql
.read tables/03_role_permission.sql
.read tables/04_users.sql
.read tables/05_customers.sql
.read tables/06_properties.sql
.read tables/07_property_images.sql
.read tables/08_room_types.sql
.read tables/09_rooms.sql
.read tables/10_amenities.sql
.read tables/11_property_amenities.sql
.read tables/12_seasonal_pricing.sql
.read tables/13_bookings.sql
.read tables/14_booking_rooms.sql
.read tables/15_services.sql
.read tables/16_booking_services.sql
.read tables/17_payments.sql
.read tables/18_invoices.sql
.read tables/19_reviews.sql
.read tables/20_promotions.sql
.read tables/21_booking_promotions.sql

-- ============================================================
-- TRIGGERS
-- ============================================================
.read triggers/01_update_users_timestamp.sql
.read triggers/02_update_customers_timestamp.sql
.read triggers/03_update_properties_timestamp.sql
.read triggers/04_update_bookings_timestamp.sql
.read triggers/05_update_invoices_timestamp.sql
.read triggers/06_update_reviews_timestamp.sql
.read triggers/07_update_promotions_timestamp.sql
.read triggers/08_update_room_types_timestamp.sql
.read triggers/09_validate_booking_dates.sql
.read triggers/10_calculate_booking_nights.sql
.read triggers/11_prevent_double_booking.sql
.read triggers/12_update_invoice_on_payment.sql

-- ============================================================
-- VIEWS
-- ============================================================
.read views/vw_available_rooms.sql
.read views/vw_booking_details.sql
.read views/vw_customer_history.sql
.read views/vw_property_occupancy.sql
.read views/vw_revenue_summary.sql

-- ============================================================
-- UDFs (User Defined Functions - SQLite 3.44+)
-- ============================================================
.read UDFs/fn_room_available.sql
.read UDFs/fn_occupancy_rate.sql
.read UDFs/fn_booking_total.sql

-- ============================================================
-- TRANSACTIONS
-- ============================================================
.read transactions/tx_create_booking.sql
.read transactions/tx_cancel_booking.sql
.read transactions/tx_process_payment.sql
.read transactions/tx_check_in_out.sql

-- ============================================================
-- SEED DATA
-- ============================================================
.read configurations/seed_data.sql
