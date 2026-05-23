USE ecommerce;

CREATE TRIGGER IF NOT EXISTS trg_restore_stock_on_cancel
    AFTER UPDATE ON orders
    FOR EACH ROW
    WHEN NEW.status IN ('cancelled', 'refunded') AND OLD.status NOT IN ('cancelled', 'refunded')
BEGIN
    UPDATE products
    SET stock = stock + (SELECT SUM(quantity) FROM order_items WHERE order_id = NEW.id AND product_id = products.id)
    WHERE id IN (SELECT product_id FROM order_items WHERE order_id = NEW.id);
END;
