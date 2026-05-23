USE inventory;

CREATE TRIGGER IF NOT EXISTS trg_update_stock_on_sale
    AFTER INSERT ON sales_order_items
    FOR EACH ROW
BEGIN
    UPDATE inventory_stock
    SET quantity = quantity - NEW.quantity,
        updated_at = CURRENT_TIMESTAMP
    WHERE product_id = NEW.product_id
      AND (variant_id = NEW.variant_id OR (variant_id IS NULL AND NEW.variant_id IS NULL))
      AND (bin_id = NEW.bin_id OR (bin_id IS NULL AND NEW.bin_id IS NULL))
      AND quantity >= NEW.quantity;

    INSERT INTO stock_movements (product_id, variant_id, from_bin_id, quantity, movement_type, reference_type, reference_id)
    VALUES (NEW.product_id, NEW.variant_id, NEW.bin_id, NEW.quantity, 'sales_issuance', 'sales_order', NEW.so_id);
END;
