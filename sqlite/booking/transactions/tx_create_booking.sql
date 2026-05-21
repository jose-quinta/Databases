USE booking;

-- Creates a new booking with rooms
-- Parameters: $customer_id, $property_id, $check_in, $check_out, $adults, $children, $room_ids, $special_requests
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO bookings (customer_id, property_id, status, check_in, check_out, adults, children, total_nights, subtotal, tax, discount, total, special_requests)
    VALUES ($customer_id, $property_id, 'pending', $check_in, $check_out, $adults, $children, 0, 0, 0, 0, 0, $special_requests);

    INSERT INTO invoices (booking_id, subtotal, tax, discount, total, paid, balance, status)
    VALUES (last_insert_rowid(), 0, 0, 0, 0, 0, 0, 'pending');

COMMIT;
