USE university;

CREATE VIEW IF NOT EXISTS vw_attendance_summary AS
SELECT
    s.id AS student_id,
    u.first_name || ' ' || u.last_name AS student_name,
    s.student_code,
    c.code AS course_code,
    c.name AS course_name,
    COUNT(a.id) AS total_classes,
    SUM(CASE WHEN a.status = 'present' THEN 1 ELSE 0 END) AS present,
    SUM(CASE WHEN a.status = 'absent' THEN 1 ELSE 0 END) AS absent,
    SUM(CASE WHEN a.status = 'late' THEN 1 ELSE 0 END) AS late,
    SUM(CASE WHEN a.status = 'excused' THEN 1 ELSE 0 END) AS excused,
    ROUND(CAST(SUM(CASE WHEN a.status IN ('present','late','excused') THEN 1 ELSE 0 END) AS REAL) / COUNT(a.id) * 100, 2) AS attendance_pct
FROM students s
JOIN users u ON u.id = s.user_id
JOIN enrollments e ON e.student_id = s.id
JOIN course_offerings co ON co.id = e.offering_id
JOIN courses c ON c.id = co.course_id
JOIN attendance a ON a.enrollment_id = e.id
GROUP BY s.id, co.id;
