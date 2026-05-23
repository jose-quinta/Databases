USE ecommerce;

CREATE VIEW IF NOT EXISTS vw_order_summary AS
SELECT
    o.id AS order_id,
    o.status,
    o.subtotal,
    o.shipping_cost,
    o.tax,
    o.discount,
    o.total,
    o.ordered_at,
    o.paid_at,
    o.shipped_at,
    o.delivered_at,
    u.name AS user_name,
    u.email AS user_email,
    COUNT(oi.id) AS item_count,
    SUM(oi.quantity) AS total_items,
    p.method AS payment_method,
    p.status AS payment_status
FROM orders o
JOIN users u ON u.id = o.user_id
LEFT JOIN order_items oi ON oi.order_id = o.id
LEFT JOIN payments p ON p.order_id = o.id
GROUP BY o.id;
