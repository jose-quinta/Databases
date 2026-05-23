USE booking;

CREATE TRIGGER IF NOT EXISTS trg_update_invoice_on_payment
    AFTER INSERT ON payments
    FOR EACH ROW
    WHEN NEW.status = 'completed'
BEGIN
    UPDATE invoices
    SET
        paid = paid + NEW.amount,
        balance = total - (paid + NEW.amount),
        status = CASE
            WHEN (paid + NEW.amount) >= total THEN 'paid'
            ELSE 'partially_paid'
        END,
        paid_at = CASE
            WHEN (paid + NEW.amount) >= total THEN CURRENT_TIMESTAMP
            ELSE paid_at
        END
    WHERE booking_id = NEW.booking_id;
END;
