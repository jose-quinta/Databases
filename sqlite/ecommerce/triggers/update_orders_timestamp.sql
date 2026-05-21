USE ecommerce;

CREATE TRIGGER IF NOT EXISTS trg_orders_updated_at
    AFTER UPDATE ON orders
    FOR EACH ROW
BEGIN
    UPDATE orders SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
