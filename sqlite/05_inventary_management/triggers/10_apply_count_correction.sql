USE inventory;

CREATE TRIGGER IF NOT EXISTS trg_apply_count_correction
    AFTER UPDATE ON inventory_counts
    FOR EACH ROW
    WHEN NEW.status = 'approved' AND OLD.status = 'completed'
BEGIN
    INSERT INTO stock_movements (product_id, variant_id, from_bin_id, to_bin_id, quantity, movement_type, reference_type, reference_id, notes)
    SELECT
        ici.product_id,
        ici.variant_id,
        ici.bin_id,
        ici.bin_id,
        ABS(ici.discrepancy),
        CASE WHEN ici.discrepancy > 0 THEN 'count_correction' ELSE 'adjustment_subtract' END,
        'inventory_count',
        ici.count_id,
        'Count adjustment: expected ' || ici.expected_quantity || ', counted ' || ici.counted_quantity
    FROM inventory_count_items ici
    WHERE ici.count_id = NEW.id AND ici.discrepancy != 0;

    UPDATE inventory_stock
    SET quantity = ici.counted_quantity,
        last_count_date = CURRENT_TIMESTAMP,
        updated_at = CURRENT_TIMESTAMP
    FROM inventory_count_items ici
    WHERE ici.count_id = NEW.id
      AND inventory_stock.product_id = ici.product_id
      AND (inventory_stock.variant_id = ici.variant_id OR (inventory_stock.variant_id IS NULL AND ici.variant_id IS NULL))
      AND inventory_stock.bin_id = ici.bin_id;
END;
