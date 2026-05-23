USE university;

CREATE VIEW IF NOT EXISTS vw_professor_schedule AS
SELECT
    p.id AS professor_id,
    u.first_name || ' ' || u.last_name AS professor_name,
    p.title,
    at.name AS term,
    c.code AS course_code,
    c.name AS course_name,
    co.section,
    ts.day,
    ts.start_time,
    ts.end_time,
    cl.code AS classroom_code,
    cl.building
FROM professors p
JOIN users u ON u.id = p.user_id
JOIN course_offerings co ON co.professor_id = p.id
JOIN courses c ON c.id = co.course_id
JOIN academic_terms at ON at.id = co.term_id
JOIN offering_schedule os ON os.offering_id = co.id
JOIN time_slots ts ON ts.id = os.time_slot_id
JOIN classrooms cl ON cl.id = os.classroom_id
ORDER BY ts.day, ts.start_time;
