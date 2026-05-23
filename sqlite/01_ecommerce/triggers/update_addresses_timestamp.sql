USE ecommerce;

CREATE TRIGGER IF NOT EXISTS trg_addresses_updated_at
    AFTER UPDATE ON addresses
    FOR EACH ROW
BEGIN
    UPDATE addresses SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
