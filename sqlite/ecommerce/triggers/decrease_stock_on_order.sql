USE ecommerce;

CREATE TRIGGER IF NOT EXISTS trg_decrease_stock_on_order
    AFTER INSERT ON order_items
    FOR EACH ROW
BEGIN
    UPDATE products
    SET stock = stock - NEW.quantity
    WHERE id = NEW.product_id;
END;
