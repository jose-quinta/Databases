USE booking;

-- fn_occupancy_rate(property_id, start_date, end_date)
-- Returns the occupancy rate (0.0 - 100.0) for a property in a date range.
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- Equivalent SQL expression:
--   SELECT ROUND(
--       CAST(COUNT(DISTINCT br.room_id) AS REAL) / NULLIF(COUNT(DISTINCT r.id), 0) * 100, 2
--   )
--   FROM rooms r
--   JOIN room_types rt ON rt.id = r.room_type_id
--   LEFT JOIN booking_rooms br ON br.room_id = r.id
--   LEFT JOIN bookings b ON b.id = br.booking_id AND b.status IN ('confirmed','checked_in')
--   WHERE rt.property_id = ? AND r.is_available = 1;

CREATE FUNCTION IF NOT EXISTS fn_occupancy_rate(property_id INTEGER, start_date TEXT, end_date TEXT)
RETURNS REAL
AS ROUND(
    COALESCE(
        (SELECT
            CAST(COUNT(DISTINCT br.room_id) AS REAL) / NULLIF(COUNT(DISTINCT r.id), 0) * 100
        FROM rooms r
        JOIN room_types rt ON rt.id = r.room_type_id
        LEFT JOIN booking_rooms br ON br.room_id = r.id
        LEFT JOIN bookings b ON b.id = br.booking_id
            AND b.status IN ('confirmed', 'checked_in')
            AND fn_occupancy_rate.start_date < br.check_out
            AND fn_occupancy_rate.end_date > br.check_in
        WHERE rt.property_id = fn_occupancy_rate.property_id
          AND r.is_available = 1),
        0
    ), 2
);
