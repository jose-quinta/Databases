USE inventory;

CREATE VIEW IF NOT EXISTS vw_count_discrepancies AS
SELECT
    ic.id AS count_id,
    ic.count_date,
    ic.status AS count_status,
    w.name AS warehouse_name,
    p.sku,
    p.name AS product_name,
    pv.name AS variant_name,
    wb.code AS bin_code,
    ici.expected_quantity,
    ici.counted_quantity,
    ici.discrepancy,
    ici.notes
FROM inventory_counts ic
JOIN warehouses w ON w.id = ic.warehouse_id
JOIN inventory_count_items ici ON ici.count_id = ic.id
JOIN products p ON p.id = ici.product_id
LEFT JOIN product_variants pv ON pv.id = ici.variant_id
JOIN warehouse_bins wb ON wb.id = ici.bin_id
WHERE ici.discrepancy != 0
ORDER BY ABS(ici.discrepancy) DESC;
