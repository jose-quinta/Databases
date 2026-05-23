USE inventory;

CREATE TRIGGER IF NOT EXISTS trg_inventory_stock_updated_at
    AFTER UPDATE ON inventory_stock
    FOR EACH ROW
BEGIN
    UPDATE inventory_stock SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
