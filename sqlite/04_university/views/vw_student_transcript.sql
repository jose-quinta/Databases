USE university;

CREATE VIEW IF NOT EXISTS vw_student_transcript AS
SELECT
    s.id AS student_id,
    u.first_name || ' ' || u.last_name AS student_name,
    s.student_code,
    p.name AS program_name,
    at.name AS term_name,
    c.code AS course_code,
    c.name AS course_name,
    c.credits,
    e.final_grade,
    e.letter_grade,
    e.status
FROM students s
JOIN users u ON u.id = s.user_id
JOIN programs p ON p.id = s.program_id
JOIN enrollments e ON e.student_id = s.id
JOIN course_offerings co ON co.id = e.offering_id
JOIN courses c ON c.id = co.course_id
JOIN academic_terms at ON at.id = co.term_id
ORDER BY at.start_date DESC, c.code;
