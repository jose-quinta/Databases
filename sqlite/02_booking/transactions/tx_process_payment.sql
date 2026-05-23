USE booking;

-- Registers a payment and updates invoice via trigger
-- Parameters: $booking_id, $amount, $method, $transaction_id
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO payments (booking_id, amount, method, transaction_id, status, paid_at)
    VALUES ($booking_id, $amount, $method, $transaction_id, 'completed', CURRENT_TIMESTAMP);

COMMIT;
