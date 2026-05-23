USE inventory;

-- Transfers stock between bins (within or between warehouses)
-- Parameters: $product_id, $variant_id, $from_bin_id, $to_bin_id, $quantity
-- Run within application transaction context.

BEGIN TRANSACTION;

    UPDATE inventory_stock
    SET quantity = quantity - $quantity,
        updated_at = CURRENT_TIMESTAMP
    WHERE product_id = $product_id
      AND (variant_id = $variant_id OR (variant_id IS NULL AND $variant_id IS NULL))
      AND bin_id = $from_bin_id
      AND quantity >= $quantity;

    INSERT INTO inventory_stock (product_id, variant_id, bin_id, quantity)
    VALUES ($product_id, $variant_id, $to_bin_id, $quantity)
    ON CONFLICT(product_id, variant_id, bin_id, lot_number) DO UPDATE SET
        quantity = quantity + $quantity,
        updated_at = CURRENT_TIMESTAMP;

    INSERT INTO stock_movements (product_id, variant_id, from_bin_id, to_bin_id, quantity, movement_type)
    VALUES ($product_id, $variant_id, $from_bin_id, $to_bin_id, $quantity, 'transfer_out');

COMMIT;
