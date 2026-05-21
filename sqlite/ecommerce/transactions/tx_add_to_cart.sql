USE ecommerce;

-- Adds a product to cart or increments quantity if already present
-- Parameters: $user_id, $product_id, $quantity
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO cart_items (cart_id, product_id, quantity)
    VALUES (
        (SELECT id FROM carts WHERE user_id = $user_id),
        $product_id,
        $quantity
    )
    ON CONFLICT DO NOTHING;

    UPDATE cart_items
    SET quantity = quantity + $quantity
    WHERE cart_id = (SELECT id FROM carts WHERE user_id = $user_id)
      AND product_id = $product_id;

COMMIT;
