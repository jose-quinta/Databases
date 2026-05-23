USE ecommerce;

-- Apply coupon: validates and calculates discount
-- Usage: called from application layer

-- SELECT
--     id,
--     discount_type,
--     discount_value,
--     min_amount,
--     CASE
--         WHEN valid_from IS NOT NULL AND valid_from > CURRENT_TIMESTAMP THEN 0
--         WHEN valid_to IS NOT NULL AND valid_to < CURRENT_TIMESTAMP THEN 0
--         WHEN max_uses IS NOT NULL AND used_count >= max_uses THEN 0
--         WHEN is_active = 0 THEN 0
--         ELSE 1
--     END AS is_valid
-- FROM coupons
-- WHERE code = $code;
