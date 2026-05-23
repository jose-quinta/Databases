USE ecommerce;

CREATE TRIGGER IF NOT EXISTS trg_carts_updated_at
    AFTER UPDATE ON carts
    FOR EACH ROW
BEGIN
    UPDATE carts SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
