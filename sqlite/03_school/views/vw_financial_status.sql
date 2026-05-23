USE school;

CREATE VIEW IF NOT EXISTS vw_financial_status AS
SELECT
    st.id AS student_id,
    u.first_name || ' ' || u.last_name AS student_name,
    st.student_code,
    i.id AS invoice_id,
    i.total AS invoice_total,
    COALESCE(SUM(p.amount), 0) AS total_paid,
    i.total - COALESCE(SUM(p.amount), 0) AS balance_due,
    i.due_date,
    i.status AS invoice_status,
    pe.name AS period_name
FROM students st
JOIN users u ON u.id = st.user_id
JOIN invoices i ON i.student_id = st.id
JOIN periods pe ON pe.id = i.period_id
LEFT JOIN payments p ON p.invoice_id = i.id
GROUP BY i.id;
