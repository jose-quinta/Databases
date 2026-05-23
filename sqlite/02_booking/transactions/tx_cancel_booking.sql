USE booking;

-- Cancels a booking: updates status, triggers recalculates anything needed
-- Parameters: $booking_id, $reason
-- Run within application transaction context.

BEGIN TRANSACTION;

    UPDATE bookings
    SET status = 'cancelled',
        special_requests = CASE
            WHEN special_requests IS NULL THEN $reason
            ELSE special_requests || ' | Cancelled: ' || $reason
        END
    WHERE id = $booking_id AND status IN ('pending', 'confirmed');

    UPDATE invoices
    SET status = 'cancelled'
    WHERE booking_id = $booking_id;

COMMIT;
