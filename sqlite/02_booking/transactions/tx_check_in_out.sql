USE booking;

-- Changes booking status to checked_in or checked_out
-- Parameters: $booking_id, $new_status ('checked_in' or 'checked_out')
-- Run within application transaction context.

BEGIN TRANSACTION;

    UPDATE bookings
    SET status = $new_status
    WHERE id = $booking_id
      AND CASE $new_status
          WHEN 'checked_in' THEN status = 'confirmed'
          WHEN 'checked_out' THEN status = 'checked_in'
          ELSE 0
      END;

COMMIT;
