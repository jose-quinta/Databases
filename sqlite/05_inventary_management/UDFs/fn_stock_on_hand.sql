USE inventory;

-- fn_stock_on_hand(product_id, warehouse_id)
-- Returns total quantity of a product across all bins in a warehouse.

CREATE FUNCTION IF NOT EXISTS fn_stock_on_hand(product_id INTEGER, warehouse_id INTEGER)
RETURNS REAL
AS COALESCE(
    (SELECT SUM(s.quantity)
     FROM inventory_stock s
     JOIN warehouse_bins wb ON wb.id = s.bin_id
     JOIN warehouse_zones wz ON wz.id = wb.zone_id
     WHERE s.product_id = fn_stock_on_hand.product_id
       AND wz.warehouse_id = fn_stock_on_hand.warehouse_id),
    0
);
