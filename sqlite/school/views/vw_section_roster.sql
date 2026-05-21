USE school;

CREATE VIEW IF NOT EXISTS vw_section_roster AS
SELECT
    s.id AS section_id,
    c.code || ' - ' || s.name AS section_name,
    u.first_name || ' ' || u.last_name AS student_name,
    st.student_code,
    gi.name AS grade_item_name,
    gi.weight,
    gi.max_score,
    g.score,
    e.enrollment_date,
    e.status AS enrollment_status
FROM sections s
JOIN courses c ON c.id = s.course_id
JOIN enrollments e ON e.section_id = s.id
JOIN students st ON st.id = e.student_id
JOIN users u ON u.id = st.user_id
LEFT JOIN grade_items gi ON gi.section_id = s.id
LEFT JOIN grades g ON g.enrollment_id = e.id AND g.grade_item_id = gi.id
ORDER BY s.id, u.last_name, u.first_name, gi.name;
