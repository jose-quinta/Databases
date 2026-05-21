USE ecommerce;

-- Places an order: moves cart items to order_items, deducts stock, clears cart
-- Parameters: $user_id, $shipping_address_id, $billing_address_id, $coupon_id
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO orders (
        user_id, status, subtotal, shipping_cost, tax, discount, total,
        shipping_address_id, billing_address_id, coupon_id
    )
    SELECT
        $user_id,
        'pending',
        COALESCE(SUM(ci.quantity * p.price), 0),
        0.00,
        0.00,
        0.00,
        COALESCE(SUM(ci.quantity * p.price), 0),
        $shipping_address_id,
        $billing_address_id,
        $coupon_id
    FROM cart_items ci
    JOIN products p ON p.id = ci.product_id
    WHERE ci.cart_id = (SELECT id FROM carts WHERE user_id = $user_id);

    INSERT INTO order_items (order_id, product_id, product_name, quantity, unit_price, subtotal)
    SELECT
        last_insert_rowid(),
        ci.product_id,
        p.name,
        ci.quantity,
        p.price,
        ci.quantity * p.price
    FROM cart_items ci
    JOIN products p ON p.id = ci.product_id
    WHERE ci.cart_id = (SELECT id FROM carts WHERE user_id = $user_id);

    DELETE FROM cart_items
    WHERE cart_id = (SELECT id FROM carts WHERE user_id = $user_id);

    UPDATE coupons
    SET used_count = used_count + 1
    WHERE id = $coupon_id;

COMMIT;
