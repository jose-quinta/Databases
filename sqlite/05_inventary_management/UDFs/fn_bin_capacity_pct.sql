USE inventory;

-- fn_bin_capacity_pct(bin_id)
-- Returns the % of bin capacity used based on stored product volume/weight.
-- Returns NULL if no capacity limits defined.

CREATE FUNCTION IF NOT EXISTS fn_bin_capacity_pct(bin_id INTEGER)
RETURNS REAL
AS (
    SELECT ROUND(
        CASE
            WHEN wb.max_volume > 0 THEN
                (SELECT COALESCE(SUM(p.volume * s.quantity), 0)
                 FROM inventory_stock s
                 JOIN products p ON p.id = s.product_id
                 WHERE s.bin_id = fn_bin_capacity_pct.bin_id) / wb.max_volume * 100
            WHEN wb.max_weight > 0 THEN
                (SELECT COALESCE(SUM(p.weight * s.quantity), 0)
                 FROM inventory_stock s
                 JOIN products p ON p.id = s.product_id
                 WHERE s.bin_id = fn_bin_capacity_pct.bin_id) / wb.max_weight * 100
            ELSE NULL
        END, 2)
    FROM warehouse_bins wb WHERE wb.id = fn_bin_capacity_pct.bin_id
);
