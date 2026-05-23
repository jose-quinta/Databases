USE school;

CREATE VIEW IF NOT EXISTS vw_attendance_summary AS
SELECT
    st.id AS student_id,
    u.first_name || ' ' || u.last_name AS student_name,
    st.student_code,
    c.code AS course_code,
    c.name AS course_name,
    COUNT(a.id) AS total_classes,
    SUM(CASE WHEN a.status = 'present' THEN 1 ELSE 0 END) AS present,
    SUM(CASE WHEN a.status = 'absent' THEN 1 ELSE 0 END) AS absent,
    SUM(CASE WHEN a.status = 'late' THEN 1 ELSE 0 END) AS late,
    SUM(CASE WHEN a.status = 'excused' THEN 1 ELSE 0 END) AS excused,
    ROUND(CAST(SUM(CASE WHEN a.status IN ('present', 'late', 'excused') THEN 1 ELSE 0 END) AS REAL) / COUNT(a.id) * 100, 2) AS attendance_pct
FROM students st
JOIN users u ON u.id = st.user_id
JOIN enrollments e ON e.student_id = st.id
JOIN sections s ON s.id = e.section_id
JOIN courses c ON c.id = s.course_id
JOIN attendance a ON a.enrollment_id = e.id
GROUP BY st.id, s.id;
