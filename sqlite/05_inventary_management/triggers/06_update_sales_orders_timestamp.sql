USE inventory;

CREATE TRIGGER IF NOT EXISTS trg_sales_orders_updated_at
    AFTER UPDATE ON sales_orders
    FOR EACH ROW
BEGIN
    UPDATE sales_orders SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
