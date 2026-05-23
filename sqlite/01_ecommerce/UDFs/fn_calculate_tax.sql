USE ecommerce;

-- fn_calculate_tax(amount, tax_rate)
-- Returns the tax for a given amount at the specified rate (percentage).
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- For older versions, use the equivalent SQL expression inline:
--
--   ROUND(amount * tax_rate / 100.0, 2)

CREATE FUNCTION IF NOT EXISTS fn_calculate_tax(
    amount REAL,
    tax_rate REAL
)
RETURNS REAL
AS ROUND(amount * tax_rate / 100.0, 2);
