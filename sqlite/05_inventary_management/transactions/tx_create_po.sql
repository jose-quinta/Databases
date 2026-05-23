USE inventory;

-- Creates a purchase order with items and calculates totals
-- Parameters: $supplier_id, $warehouse_id, $po_number, $expected_date, $notes
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO purchase_orders (supplier_id, warehouse_id, po_number, expected_date, status, notes)
    VALUES ($supplier_id, $warehouse_id, $po_number, $expected_date, 'draft', $notes);

COMMIT;
