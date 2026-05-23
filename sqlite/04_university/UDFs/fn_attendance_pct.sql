USE university;

-- fn_attendance_pct(student_id, offering_id)
-- Returns attendance percentage (0.0 - 100.0) for a student in a course offering.

CREATE FUNCTION IF NOT EXISTS fn_attendance_pct(student_id INTEGER, offering_id INTEGER)
RETURNS REAL
AS ROUND(
    COALESCE(
        (SELECT
            CAST(SUM(CASE WHEN a.status IN ('present','late','excused') THEN 1 ELSE 0 END) AS REAL)
            / COUNT(a.id) * 100
        FROM attendance a
        JOIN enrollments e ON e.id = a.enrollment_id
        WHERE e.student_id = fn_attendance_pct.student_id
          AND e.offering_id = fn_attendance_pct.offering_id),
        0
    ), 2
);
