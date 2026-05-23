USE university;

CREATE VIEW IF NOT EXISTS vw_offering_roster AS
SELECT
    co.id AS offering_id,
    c.code || ' - ' || c.name || ' (Section ' || co.section || ')' AS offering_name,
    u.first_name || ' ' || u.last_name AS student_name,
    s.student_code,
    e.enrollment_date,
    e.status AS enrollment_status,
    e.final_grade,
    e.letter_grade,
    gc.name AS component_name,
    gc.weight,
    gc.max_score,
    g.score
FROM course_offerings co
JOIN courses c ON c.id = co.course_id
JOIN enrollments e ON e.offering_id = co.id
JOIN students s ON s.id = e.student_id
JOIN users u ON u.id = s.user_id
LEFT JOIN grade_components gc ON gc.offering_id = co.id
LEFT JOIN grades g ON g.enrollment_id = e.id AND g.component_id = gc.id
ORDER BY co.id, u.last_name, u.first_name, gc.name;
