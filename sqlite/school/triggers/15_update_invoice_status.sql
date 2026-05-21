USE school;

CREATE TRIGGER IF NOT EXISTS trg_update_invoice_status
    AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
    UPDATE invoices
    SET status = 'paid'
    WHERE id = NEW.invoice_id
    AND (
        SELECT COALESCE(SUM(amount), 0) FROM payments WHERE invoice_id = NEW.invoice_id
    ) >= total;
END;
