USE university;

-- Registers a payment
-- Parameters: $invoice_id, $amount, $method, $transaction_id
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO payments (invoice_id, amount, method, transaction_id)
    VALUES ($invoice_id, $amount, $method, $transaction_id);

COMMIT;
