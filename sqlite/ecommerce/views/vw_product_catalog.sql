USE ecommerce;

CREATE VIEW IF NOT EXISTS vw_product_catalog AS
SELECT
    p.id,
    p.name,
    p.description,
    p.price,
    p.stock,
    p.sku,
    p.weight,
    c.name AS category_name,
    c.id AS category_id,
    COALESCE(
        (SELECT url FROM product_images WHERE product_id = p.id AND is_primary = 1 LIMIT 1),
        (SELECT url FROM product_images WHERE product_id = p.id LIMIT 1)
    ) AS primary_image,
    COALESCE(AVG(r.rating), 0) AS avg_rating,
    COUNT(DISTINCT r.id) AS review_count
FROM products p
LEFT JOIN categories c ON c.id = p.category_id
LEFT JOIN reviews r ON r.product_id = p.id AND r.is_approved = 1
WHERE p.deleted_at IS NULL AND p.is_active = 1
GROUP BY p.id;
