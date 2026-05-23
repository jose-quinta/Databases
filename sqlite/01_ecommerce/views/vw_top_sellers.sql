USE ecommerce;

CREATE VIEW IF NOT EXISTS vw_top_sellers AS
SELECT
    p.id AS product_id,
    p.name AS product_name,
    c.name AS category_name,
    COUNT(oi.id) AS times_ordered,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.subtotal) AS total_revenue,
    AVG(r.rating) AS avg_rating
FROM products p
JOIN order_items oi ON oi.product_id = p.id
JOIN orders o ON o.id = oi.order_id
LEFT JOIN categories c ON c.id = p.category_id
LEFT JOIN reviews r ON r.product_id = p.id AND r.is_approved = 1
WHERE o.status NOT IN ('cancelled', 'refunded')
GROUP BY p.id
ORDER BY units_sold DESC;
