USE ecommerce;

-- fn_calculate_discount(price, discount_type, discount_value)
-- Returns the discount amount based on type: 'percentage' or 'fixed'
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- For older versions, use the equivalent SQL expression inline:
--
--   CASE WHEN discount_type = 'percentage'
--        THEN price * discount_value / 100.0
--        ELSE discount_value
--   END

CREATE FUNCTION IF NOT EXISTS fn_calculate_discount(
    price REAL,
    discount_type TEXT,
    discount_value REAL
)
RETURNS REAL
AS CASE WHEN discount_type = 'percentage'
        THEN price * discount_value / 100.0
        ELSE discount_value
   END;
