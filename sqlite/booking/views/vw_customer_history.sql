USE booking;

CREATE VIEW IF NOT EXISTS vw_customer_history AS
SELECT
    c.id AS customer_id,
    u.first_name || ' ' || u.last_name AS customer_name,
    u.email,
    u.phone,
    c.total_bookings,
    b.id AS booking_id,
    b.status AS booking_status,
    b.check_in,
    b.check_out,
    b.total_nights,
    b.total AS booking_total,
    p.name AS property_name,
    p.city AS property_city,
    r.rating,
    r.comment AS review_comment
FROM customers c
JOIN users u ON u.id = c.user_id
LEFT JOIN bookings b ON b.customer_id = c.id
LEFT JOIN properties p ON p.id = b.property_id
LEFT JOIN reviews r ON r.booking_id = b.id
ORDER BY b.created_at DESC;
