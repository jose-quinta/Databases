USE booking;

CREATE VIEW IF NOT EXISTS vw_booking_details AS
SELECT
    b.id AS booking_id,
    b.check_in,
    b.check_out,
    b.total_nights,
    b.status,
    b.total,
    b.special_requests,
    u.first_name || ' ' || u.last_name AS customer_name,
    u.email AS customer_email,
    u.phone AS customer_phone,
    p.name AS property_name,
    p.city AS property_city,
    GROUP_CONCAT(DISTINCT rt.name) AS room_types,
    COUNT(DISTINCT br.id) AS rooms_count,
    GROUP_CONCAT(DISTINCT s.name) AS extra_services,
    COALESCE(SUM(pay.amount), 0) AS total_paid,
    b.total - COALESCE(SUM(pay.amount), 0) AS balance_due,
    i.status AS invoice_status
FROM bookings b
JOIN customers c ON c.id = b.customer_id
JOIN users u ON u.id = c.user_id
JOIN properties p ON p.id = b.property_id
LEFT JOIN booking_rooms br ON br.booking_id = b.id
LEFT JOIN room_types rt ON rt.id = (SELECT room_type_id FROM rooms WHERE id = br.room_id)
LEFT JOIN booking_services bs ON bs.booking_id = b.id
LEFT JOIN services s ON s.id = bs.service_id
LEFT JOIN payments pay ON pay.booking_id = b.id
LEFT JOIN invoices i ON i.booking_id = b.id
GROUP BY b.id;
