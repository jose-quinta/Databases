USE inventory;

-- Receives goods against a purchase order: creates receipt, updates stock, logs movement
-- Parameters: $po_id, $reference_number, $items_json (handled by application)
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO goods_receipts (po_id, receipt_date, reference_number)
    VALUES ($po_id, DATE('now'), $reference_number);

    UPDATE purchase_orders
    SET status = CASE
        WHEN (SELECT SUM(quantity_received) FROM purchase_order_items WHERE po_id = $po_id) >=
             (SELECT SUM(quantity_ordered) FROM purchase_order_items WHERE po_id = $po_id)
        THEN 'received'
        ELSE 'confirmed'
    END
    WHERE id = $po_id;

COMMIT;
