USE school;

CREATE VIEW IF NOT EXISTS vw_student_transcript AS
SELECT
    st.id AS student_id,
    u.first_name || ' ' || u.last_name AS student_name,
    st.student_code,
    p.name AS program_name,
    ac.name AS academic_year,
    pe.name AS period,
    c.code AS course_code,
    c.name AS course_name,
    c.credits,
    ROUND(AVG(g.score), 2) AS final_grade,
    CASE
        WHEN AVG(g.score) >= 90 THEN 'A'
        WHEN AVG(g.score) >= 80 THEN 'B'
        WHEN AVG(g.score) >= 70 THEN 'C'
        WHEN AVG(g.score) >= 60 THEN 'D'
        ELSE 'F'
    END AS letter_grade,
    e.status AS enrollment_status
FROM students st
JOIN users u ON u.id = st.user_id
JOIN programs p ON p.id = st.program_id
JOIN enrollments e ON e.student_id = st.id
JOIN sections s ON s.id = e.section_id
JOIN courses c ON c.id = s.course_id
JOIN periods pe ON pe.id = s.period_id
JOIN academic_years ac ON ac.id = pe.academic_year_id
JOIN grade_items gi ON gi.section_id = s.id
JOIN grades g ON g.enrollment_id = e.id AND g.grade_item_id = gi.id
GROUP BY st.id, s.id;
