USE inventory;

-- fn_inventory_value(warehouse_id)
-- Returns total inventory value (quantity * avg purchase price) for a warehouse.

CREATE FUNCTION IF NOT EXISTS fn_inventory_value(warehouse_id INTEGER)
RETURNS REAL
AS COALESCE(
    (SELECT SUM(s.quantity * COALESCE(pv.purchase_price, p.purchase_price))
     FROM inventory_stock s
     JOIN products p ON p.id = s.product_id
     LEFT JOIN product_variants pv ON pv.id = s.variant_id
     JOIN warehouse_bins wb ON wb.id = s.bin_id
     WHERE wb.zone_id IN (SELECT id FROM warehouse_zones WHERE warehouse_id = fn_inventory_value.warehouse_id)),
    0
);
