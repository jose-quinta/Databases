USE inventory;

-- Adjusts stock for a product in a bin (positive adds, negative subtracts)
-- Parameters: $product_id, $variant_id, $bin_id, $quantity, $reason
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO inventory_stock (product_id, variant_id, bin_id, quantity)
    VALUES ($product_id, $variant_id, $bin_id, $quantity)
    ON CONFLICT(product_id, variant_id, bin_id, lot_number) DO UPDATE SET
        quantity = CASE
            WHEN inventory_stock.quantity + $quantity >= 0 THEN inventory_stock.quantity + $quantity
            ELSE 0
        END,
        updated_at = CURRENT_TIMESTAMP;

    INSERT INTO stock_movements (product_id, variant_id, to_bin_id, quantity, movement_type, notes)
    VALUES ($product_id, $variant_id, $bin_id, ABS($quantity),
            CASE WHEN $quantity >= 0 THEN 'adjustment_add' ELSE 'adjustment_subtract' END,
            $reason);

COMMIT;
