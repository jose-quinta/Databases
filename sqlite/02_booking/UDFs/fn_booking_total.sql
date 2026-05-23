USE booking;

-- fn_booking_total(booking_id)
-- Returns the total amount for a booking (rooms + services).
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- Equivalent SQL expression:
--   SELECT COALESCE(SUM(subtotal), 0) FROM (
--       SELECT subtotal FROM booking_rooms WHERE booking_id = ?
--       UNION ALL
--       SELECT subtotal FROM booking_services WHERE booking_id = ?
--   );

CREATE FUNCTION IF NOT EXISTS fn_booking_total(booking_id INTEGER)
RETURNS REAL
AS COALESCE(
    (SELECT SUM(subtotal) FROM (
        SELECT subtotal FROM booking_rooms WHERE booking_id = fn_booking_total.booking_id
        UNION ALL
        SELECT subtotal FROM booking_services WHERE booking_id = fn_booking_total.booking_id
    )),
    0
);
