USE school;

CREATE VIEW IF NOT EXISTS vw_teacher_schedule AS
SELECT
    t.id AS teacher_id,
    u.first_name || ' ' || u.last_name AS teacher_name,
    ts.day,
    ts.start_time,
    ts.end_time,
    c.code AS course_code,
    c.name AS course_name,
    s.name AS section_name,
    cl.code AS classroom_code,
    cl.building
FROM teachers t
JOIN users u ON u.id = t.user_id
JOIN sections s ON s.teacher_id = t.id
JOIN courses c ON c.id = s.course_id
JOIN section_schedule ss ON ss.section_id = s.id
JOIN time_slots ts ON ts.id = ss.time_slot_id
JOIN classrooms cl ON cl.id = ss.classroom_id
ORDER BY ts.day, ts.start_time;
