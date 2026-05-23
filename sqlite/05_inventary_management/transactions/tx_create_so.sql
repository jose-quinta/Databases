USE inventory;

-- Creates a sales order with items
-- Parameters: $order_number, $customer_name, $warehouse_id, $notes
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO sales_orders (order_number, customer_name, warehouse_id, status, notes)
    VALUES ($order_number, $customer_name, $warehouse_id, 'draft', $notes);

COMMIT;
