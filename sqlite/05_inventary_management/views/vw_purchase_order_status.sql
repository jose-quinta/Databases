USE inventory;

CREATE VIEW IF NOT EXISTS vw_purchase_order_status AS
SELECT
    po.id AS po_id,
    po.po_number,
    po.order_date,
    po.expected_date,
    po.status,
    s.company_name AS supplier,
    w.name AS warehouse,
    COUNT(poi.id) AS total_items,
    SUM(poi.quantity_ordered) AS total_ordered,
    SUM(poi.quantity_received) AS total_received,
    po.total AS amount,
    CASE
        WHEN SUM(poi.quantity_ordered) = 0 THEN 0
        ELSE ROUND(SUM(poi.quantity_received) / SUM(poi.quantity_ordered) * 100, 2)
    END AS receipt_pct
FROM purchase_orders po
JOIN suppliers s ON s.id = po.supplier_id
JOIN warehouses w ON w.id = po.warehouse_id
LEFT JOIN purchase_order_items poi ON poi.po_id = po.id
GROUP BY po.id;
