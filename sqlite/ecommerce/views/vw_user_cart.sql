USE ecommerce;

CREATE VIEW IF NOT EXISTS vw_user_cart AS
SELECT
    u.id AS user_id,
    u.name AS user_name,
    c.id AS cart_id,
    ci.id AS cart_item_id,
    ci.product_id,
    p.name AS product_name,
    p.price AS unit_price,
    ci.quantity,
    (ci.quantity * p.price) AS subtotal,
    pi.url AS product_image
FROM users u
JOIN carts c ON c.user_id = u.id
JOIN cart_items ci ON ci.cart_id = c.id
JOIN products p ON p.id = ci.product_id
LEFT JOIN product_images pi ON pi.product_id = p.id AND pi.is_primary = 1
WHERE p.deleted_at IS NULL AND p.is_active = 1;
