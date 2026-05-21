USE ecommerce;

-- Cancels an order: updates status, restores stock
-- Parameters: $order_id
-- Run within application transaction context.

BEGIN TRANSACTION;

    UPDATE orders
    SET
        status = 'cancelled',
        cancelled_at = CURRENT_TIMESTAMP
    WHERE id = $order_id AND status NOT IN ('cancelled', 'refunded', 'delivered');

    UPDATE products
    SET stock = stock + (
        SELECT COALESCE(SUM(quantity), 0)
        FROM order_items
        WHERE order_id = $order_id AND product_id = products.id
    )
    WHERE id IN (
        SELECT product_id FROM order_items WHERE order_id = $order_id
    );

COMMIT;
