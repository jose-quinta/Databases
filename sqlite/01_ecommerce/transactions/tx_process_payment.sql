USE ecommerce;

-- Processes payment and updates order status
-- Parameters: $order_id, $method, $transaction_id, $amount
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO payments (order_id, method, transaction_id, amount, status, paid_at)
    VALUES ($order_id, $method, $transaction_id, $amount, 'completed', CURRENT_TIMESTAMP);

    UPDATE orders
    SET
        status = 'paid',
        paid_at = CURRENT_TIMESTAMP
    WHERE id = $order_id AND status = 'pending';

COMMIT;
