USE inventory;

CREATE VIEW IF NOT EXISTS vw_inventory_movements AS
SELECT
    sm.id AS movement_id,
    sm.movement_type,
    sm.quantity,
    sm.created_at AS movement_date,
    p.sku,
    p.name AS product_name,
    pv.name AS variant_name,
    fb.code AS from_bin,
    tb.code AS to_bin,
    sm.reference_type,
    sm.reference_id,
    sm.notes
FROM stock_movements sm
JOIN products p ON p.id = sm.product_id
LEFT JOIN product_variants pv ON pv.id = sm.variant_id
LEFT JOIN warehouse_bins fb ON fb.id = sm.from_bin_id
LEFT JOIN warehouse_bins tb ON tb.id = sm.to_bin_id
ORDER BY sm.created_at DESC;
