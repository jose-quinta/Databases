USE inventory;

CREATE VIEW IF NOT EXISTS vw_low_stock_alert AS
SELECT
    p.id AS product_id,
    p.sku,
    p.name AS product_name,
    pv.name AS variant_name,
    COALESCE(SUM(s.quantity), 0) AS current_stock,
    p.min_stock,
    p.reorder_point,
    COALESCE(SUM(s.quantity), 0) - p.reorder_point AS deficit,
    w.name AS warehouse_name
FROM products p
LEFT JOIN product_variants pv ON pv.product_id = p.id
JOIN inventory_stock s ON s.product_id = p.id AND (s.variant_id = pv.id OR (s.variant_id IS NULL AND pv.id IS NULL))
JOIN warehouse_bins wb ON wb.id = s.bin_id
JOIN warehouse_zones wz ON wz.id = wb.zone_id
JOIN warehouses w ON w.id = wz.warehouse_id
WHERE p.is_active = 1
GROUP BY p.id, pv.id, w.id
HAVING COALESCE(SUM(s.quantity), 0) <= p.reorder_point
ORDER BY deficit ASC;
