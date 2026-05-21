USE booking;

CREATE VIEW IF NOT EXISTS vw_revenue_summary AS
SELECT
    p.id AS property_id,
    p.name AS property_name,
    p.city,
    COUNT(b.id) AS total_bookings,
    SUM(b.total) AS gross_revenue,
    SUM(b.discount) AS total_discounts,
    SUM(b.total) - SUM(b.discount) AS net_revenue,
    COALESCE(AVG(r.rating), 0) AS avg_rating,
    strftime('%Y-%m', b.created_at) AS month
FROM properties p
LEFT JOIN bookings b ON b.property_id = p.id AND b.status NOT IN ('cancelled')
LEFT JOIN reviews r ON r.booking_id = b.id
WHERE p.is_active = 1
GROUP BY p.id, month
ORDER BY month DESC, net_revenue DESC;
