USE booking;

CREATE VIEW IF NOT EXISTS vw_available_rooms AS
SELECT
    r.id AS room_id,
    r.room_number,
    r.floor,
    rt.name AS room_type_name,
    rt.max_guests,
    rt.bed_type,
    rt.size_sqm,
    rt.base_price,
    p.id AS property_id,
    p.name AS property_name,
    p.city,
    p.country
FROM rooms r
JOIN room_types rt ON rt.id = r.room_type_id
JOIN properties p ON p.id = rt.property_id
WHERE r.is_available = 1
  AND p.is_active = 1
  AND r.id NOT IN (
    SELECT br.room_id FROM booking_rooms br
    JOIN bookings b ON b.id = br.booking_id
    WHERE b.status NOT IN ('cancelled', 'checked_out')
);
