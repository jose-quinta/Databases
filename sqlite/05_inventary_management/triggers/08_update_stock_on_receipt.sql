USE inventory;

CREATE TRIGGER IF NOT EXISTS trg_update_stock_on_receipt
    AFTER INSERT ON goods_receipt_items
    FOR EACH ROW
BEGIN
    INSERT INTO inventory_stock (product_id, variant_id, bin_id, quantity, lot_number, expiry_date)
    VALUES (NEW.product_id, NEW.variant_id, NEW.bin_id, NEW.quantity_received, NEW.lot_number, NEW.expiry_date)
    ON CONFLICT(product_id, variant_id, bin_id, lot_number) DO UPDATE SET
        quantity = quantity + NEW.quantity_received,
        updated_at = CURRENT_TIMESTAMP;

    INSERT INTO stock_movements (product_id, variant_id, to_bin_id, quantity, movement_type, reference_type, reference_id, lot_number)
    VALUES (NEW.product_id, NEW.variant_id, NEW.bin_id, NEW.quantity_received, 'purchase_receipt', 'goods_receipt', NEW.receipt_id, NEW.lot_number);

    UPDATE purchase_order_items
    SET quantity_received = quantity_received + NEW.quantity_received
    WHERE id = NEW.po_item_id;
END;
