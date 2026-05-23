USE inventory;

CREATE TRIGGER IF NOT EXISTS trg_suppliers_updated_at
    AFTER UPDATE ON suppliers
    FOR EACH ROW
BEGIN
    UPDATE suppliers SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
