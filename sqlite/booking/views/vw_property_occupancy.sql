USE booking;

CREATE VIEW IF NOT EXISTS vw_property_occupancy AS
SELECT
    p.id AS property_id,
    p.name AS property_name,
    p.city,
    COUNT(DISTINCT r.id) AS total_rooms,
    COUNT(DISTINCT b.id) AS active_bookings,
    ROUND(CAST(COUNT(DISTINCT br.room_id) AS REAL) / NULLIF(COUNT(DISTINCT r.id), 0) * 100, 2) AS occupancy_pct,
    COALESCE(SUM(b.total), 0) AS total_revenue
FROM properties p
JOIN room_types rt ON rt.property_id = p.id
JOIN rooms r ON r.room_type_id = rt.id
LEFT JOIN bookings b ON b.property_id = p.id AND b.status IN ('confirmed', 'checked_in')
LEFT JOIN booking_rooms br ON br.booking_id = b.id AND br.room_id = r.id
WHERE p.is_active = 1
GROUP BY p.id;
