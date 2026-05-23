USE university;

CREATE VIEW IF NOT EXISTS vw_financial_status AS
SELECT
    s.id AS student_id,
    u.first_name || ' ' || u.last_name AS student_name,
    s.student_code,
    i.id AS invoice_id,
    i.total AS invoice_total,
    COALESCE(SUM(p.amount), 0) AS total_paid,
    i.total - COALESCE(SUM(p.amount), 0) AS balance_due,
    i.due_date,
    i.status AS invoice_status,
    at.name AS term_name
FROM students s
JOIN users u ON u.id = s.user_id
JOIN invoices i ON i.student_id = s.id
JOIN academic_terms at ON at.id = i.term_id
LEFT JOIN payments p ON p.invoice_id = i.id
GROUP BY i.id;
