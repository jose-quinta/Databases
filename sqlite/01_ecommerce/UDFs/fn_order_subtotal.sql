USE ecommerce;

-- fn_order_subtotal(order_id)
-- Returns the sum of all order_items subtotals for the given order.
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- For older versions, use the equivalent SQL expression inline:
--
--   SELECT COALESCE(SUM(subtotal), 0) FROM order_items WHERE order_id = ?

CREATE FUNCTION IF NOT EXISTS fn_order_subtotal(order_id INTEGER)
RETURNS REAL
AS COALESCE(
    (SELECT SUM(subtotal) FROM order_items WHERE order_items.order_id = order_id),
    0
);
