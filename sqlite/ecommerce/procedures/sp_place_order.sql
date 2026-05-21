USE ecommerce;

-- Place order: moves cart items to order_items and clears the cart
-- Usage: called from application layer as a transaction

-- BEGIN TRANSACTION;
--
-- INSERT INTO orders (user_id, subtotal, shipping_cost, tax, discount, total, shipping_address_id, billing_address_id, coupon_id)
-- VALUES ($user_id, $subtotal, $shipping, $tax, $discount, $total, $shipping_address_id, $billing_address_id, $coupon_id);
--
-- SET @order_id = last_insert_rowid();
--
-- INSERT INTO order_items (order_id, product_id, product_name, quantity, unit_price, subtotal)
-- SELECT @order_id, ci.product_id, p.name, ci.quantity, p.price, (ci.quantity * p.price)
-- FROM cart_items ci
-- JOIN products p ON p.id = ci.product_id
-- JOIN carts c ON c.id = ci.cart_id
-- WHERE c.user_id = $user_id;
--
-- DELETE FROM cart_items WHERE cart_id = (SELECT id FROM carts WHERE user_id = $user_id);
--
-- COMMIT;
