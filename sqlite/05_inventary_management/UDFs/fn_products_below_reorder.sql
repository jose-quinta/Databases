USE inventory;

-- fn_products_below_reorder(warehouse_id)
-- Returns count of products that are at or below their reorder point.

CREATE FUNCTION IF NOT EXISTS fn_products_below_reorder(warehouse_id INTEGER)
RETURNS INTEGER
AS (
    SELECT COUNT(*) FROM (
        SELECT p.id
        FROM products p
        JOIN inventory_stock s ON s.product_id = p.id
        JOIN warehouse_bins wb ON wb.id = s.bin_id
        JOIN warehouse_zones wz ON wz.id = wb.zone_id
        WHERE wz.warehouse_id = fn_products_below_reorder.warehouse_id
          AND p.is_active = 1
        GROUP BY p.id
        HAVING COALESCE(SUM(s.quantity), 0) <= p.reorder_point
    )
);
