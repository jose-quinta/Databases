USE school;

-- fn_calculate_gpa(student_id, period_id)
-- Returns weighted GPA for a student in a given period (0.0 - 4.0 scale).
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- For older versions, use the equivalent SQL expression inline:
--
--   SELECT ROUND(
--       SUM(CASE
--           WHEN gi.weight > 0 THEN (g.score / gi.max_score) * gi.weight
--           ELSE 0
--       END) / NULLIF(SUM(gi.weight), 0) * 4.0, 2
--   )
--   FROM grades g
--   JOIN grade_items gi ON gi.id = g.grade_item_id
--   JOIN enrollments e ON e.id = g.enrollment_id
--   JOIN sections s ON s.id = e.section_id
--   WHERE e.student_id = ? AND s.period_id = ?;

CREATE FUNCTION IF NOT EXISTS fn_calculate_gpa(student_id INTEGER, period_id INTEGER)
RETURNS REAL
AS ROUND(
    COALESCE(
        (SELECT SUM(CASE
            WHEN gi.weight > 0 THEN (g.score / gi.max_score) * gi.weight
            ELSE 0
        END) / NULLIF(SUM(gi.weight), 0) * 4.0
        FROM grades g
        JOIN grade_items gi ON gi.id = g.grade_item_id
        JOIN enrollments e ON e.id = g.enrollment_id
        JOIN sections s ON s.id = e.section_id
        WHERE e.student_id = fn_calculate_gpa.student_id
          AND s.period_id = fn_calculate_gpa.period_id),
        0
    ), 2
);
