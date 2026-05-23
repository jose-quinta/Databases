USE ecommerce;

CREATE TRIGGER IF NOT EXISTS trg_customers_updated_at
    AFTER UPDATE ON customers
    FOR EACH ROW
BEGIN
    UPDATE customers SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
