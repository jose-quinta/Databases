USE booking;

CREATE TRIGGER IF NOT EXISTS trg_invoices_updated_at
    AFTER UPDATE ON invoices
    FOR EACH ROW
BEGIN
    UPDATE invoices SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
