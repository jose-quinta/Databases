USE ecommerce;

-- fn_is_coupon_valid(coupon_id)
-- Returns 1 if the coupon is active, within valid dates, and under max_uses.
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- For older versions, use the equivalent SQL expression inline:
--
--   SELECT CASE
--       WHEN is_active = 0 THEN 0
--       WHEN valid_from IS NOT NULL AND valid_from > CURRENT_TIMESTAMP THEN 0
--       WHEN valid_to IS NOT NULL AND valid_to < CURRENT_TIMESTAMP THEN 0
--       WHEN max_uses IS NOT NULL AND used_count >= max_uses THEN 0
--       ELSE 1
--   END FROM coupons WHERE id = ?

CREATE FUNCTION IF NOT EXISTS fn_is_coupon_valid(coupon_id INTEGER)
RETURNS INTEGER
AS COALESCE(
    (SELECT CASE
        WHEN c.is_active = 0 THEN 0
        WHEN c.valid_from IS NOT NULL AND c.valid_from > CURRENT_TIMESTAMP THEN 0
        WHEN c.valid_to IS NOT NULL AND c.valid_to < CURRENT_TIMESTAMP THEN 0
        WHEN c.max_uses IS NOT NULL AND c.used_count >= c.max_uses THEN 0
        ELSE 1
    END FROM coupons c WHERE c.id = coupon_id),
    0
);
