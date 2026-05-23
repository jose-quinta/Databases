USE school;

-- fn_remaining_balance(student_id)
-- Returns the total outstanding balance across all invoices for a student.
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- For older versions, use the equivalent SQL expression inline:
--
--   SELECT COALESCE(SUM(i.total - COALESCE(sub.paid, 0)), 0)
--   FROM invoices i
--   LEFT JOIN (
--       SELECT invoice_id, SUM(amount) AS paid
--       FROM payments GROUP BY invoice_id
--   ) sub ON sub.invoice_id = i.id
--   WHERE i.student_id = ? AND i.status <> 'paid';

CREATE FUNCTION IF NOT EXISTS fn_remaining_balance(student_id INTEGER)
RETURNS REAL
AS COALESCE(
    (SELECT SUM(i.total - COALESCE(sub.paid, 0))
     FROM invoices i
     LEFT JOIN (
         SELECT invoice_id, SUM(amount) AS paid
         FROM payments GROUP BY invoice_id
     ) sub ON sub.invoice_id = i.id
     WHERE i.student_id = fn_remaining_balance.student_id
       AND i.status <> 'paid'),
    0
);
