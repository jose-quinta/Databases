USE inventory;

CREATE TRIGGER IF NOT EXISTS trg_purchase_orders_updated_at
    AFTER UPDATE ON purchase_orders
    FOR EACH ROW
BEGIN
    UPDATE purchase_orders SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
