USE inventory;

CREATE VIEW IF NOT EXISTS vw_stock_by_warehouse AS
SELECT
    w.id AS warehouse_id,
    w.name AS warehouse_name,
    p.id AS product_id,
    p.sku,
    p.name AS product_name,
    pv.name AS variant_name,
    COALESCE(SUM(s.quantity), 0) AS total_stock,
    p.min_stock,
    p.reorder_point,
    CASE
        WHEN COALESCE(SUM(s.quantity), 0) <= p.reorder_point THEN 'reorder'
        WHEN COALESCE(SUM(s.quantity), 0) <= p.min_stock THEN 'low'
        ELSE 'ok'
    END AS stock_status
FROM warehouses w
CROSS JOIN products p
LEFT JOIN product_variants pv ON pv.product_id = p.id
LEFT JOIN warehouse_bins wb ON wb.zone_id IN (SELECT id FROM warehouse_zones WHERE warehouse_id = w.id)
LEFT JOIN inventory_stock s ON s.product_id = p.id AND (s.variant_id = pv.id OR (s.variant_id IS NULL AND pv.id IS NULL)) AND s.bin_id = wb.id
WHERE p.is_active = 1
GROUP BY w.id, p.id, pv.id;
