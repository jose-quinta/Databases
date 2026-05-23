USE school;

-- fn_attendance_pct(student_id, section_id)
-- Returns attendance percentage (0.0 - 100.0) for a student in a section.
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- For older versions, use the equivalent SQL expression inline:
--
--   SELECT ROUND(
--       CAST(SUM(CASE WHEN a.status IN ('present','late','excused') THEN 1 ELSE 0 END) AS REAL)
--       / COUNT(a.id) * 100, 2
--   )
--   FROM attendance a
--   JOIN enrollments e ON e.id = a.enrollment_id
--   WHERE e.student_id = ? AND e.section_id = ?;

CREATE FUNCTION IF NOT EXISTS fn_attendance_pct(student_id INTEGER, section_id INTEGER)
RETURNS REAL
AS ROUND(
    COALESCE(
        (SELECT
            CAST(SUM(CASE WHEN a.status IN ('present','late','excused') THEN 1 ELSE 0 END) AS REAL)
            / COUNT(a.id) * 100
        FROM attendance a
        JOIN enrollments e ON e.id = a.enrollment_id
        WHERE e.student_id = fn_attendance_pct.student_id
          AND e.section_id = fn_attendance_pct.section_id),
        0
    ), 2
);
