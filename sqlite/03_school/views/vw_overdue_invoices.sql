USE school;

CREATE VIEW IF NOT EXISTS vw_overdue_invoices AS
SELECT
    i.id AS invoice_id,
    i.total,
    COALESCE(SUM(p.amount), 0) AS total_paid,
    i.total - COALESCE(SUM(p.amount), 0) AS outstanding,
    i.due_date,
    JULIANDAY(DATE('now')) - JULIANDAY(i.due_date) AS days_overdue,
    u.first_name || ' ' || u.last_name AS student_name,
    st.student_code,
    pe.name AS period_name
FROM invoices i
JOIN students st ON st.id = i.student_id
JOIN users u ON u.id = st.user_id
JOIN periods pe ON pe.id = i.period_id
LEFT JOIN payments p ON p.invoice_id = i.id
WHERE i.status IN ('pending', 'overdue')
AND i.due_date < DATE('now')
GROUP BY i.id
HAVING outstanding > 0
ORDER BY days_overdue DESC;
