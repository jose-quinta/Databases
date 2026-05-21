USE booking;

-- fn_room_available(room_id, start_date, end_date)
-- Returns 1 if the room is available for the full date range, 0 otherwise.
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- Equivalent SQL expression:
--   SELECT CASE WHEN NOT EXISTS (
--       SELECT 1 FROM booking_rooms br
--       JOIN bookings b ON b.id = br.booking_id
--       WHERE br.room_id = ?
--         AND b.status NOT IN ('cancelled','checked_out')
--         AND ? < br.check_out AND ? > br.check_in
--   ) AND EXISTS (SELECT 1 FROM rooms WHERE id = ? AND is_available = 1) THEN 1 ELSE 0 END;

CREATE FUNCTION IF NOT EXISTS fn_room_available(room_id INTEGER, start_date TEXT, end_date TEXT)
RETURNS INTEGER
AS CASE
    WHEN NOT EXISTS (
        SELECT 1 FROM booking_rooms br
        JOIN bookings b ON b.id = br.booking_id
        WHERE br.room_id = fn_room_available.room_id
          AND b.status NOT IN ('cancelled', 'checked_out')
          AND fn_room_available.start_date < br.check_out
          AND fn_room_available.end_date > br.check_in
    ) AND EXISTS (
        SELECT 1 FROM rooms WHERE id = fn_room_available.room_id AND is_available = 1
    ) THEN 1 ELSE 0
END;
