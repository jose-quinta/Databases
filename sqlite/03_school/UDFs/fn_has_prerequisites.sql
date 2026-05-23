USE school;

-- fn_has_prerequisites(student_id, course_id)
-- Returns 1 if the student has passed all prerequisites for the course.
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- For older versions, use the equivalent SQL expression inline:
--
--   SELECT CASE
--       WHEN NOT EXISTS (
--           SELECT 1 FROM course_prerequisites cp
--           WHERE cp.course_id = ?
--           AND NOT EXISTS (
--               SELECT 1 FROM enrollments e
--               JOIN grades g ON g.enrollment_id = e.id
--               JOIN grade_items gi ON gi.id = g.grade_item_id
--               WHERE e.student_id = ?
--               AND e.section_id IN (
--                   SELECT s2.id FROM sections s2 WHERE s2.course_id = cp.prerequisite_id
--               )
--               AND g.score >= gi.max_score * 0.6
--           )
--       ) THEN 1 ELSE 0
--   END;

CREATE FUNCTION IF NOT EXISTS fn_has_prerequisites(student_id INTEGER, course_id INTEGER)
RETURNS INTEGER
AS CASE
    WHEN NOT EXISTS (
        SELECT 1 FROM course_prerequisites cp
        WHERE cp.course_id = fn_has_prerequisites.course_id
        AND NOT EXISTS (
            SELECT 1 FROM enrollments e
            JOIN grades g ON g.enrollment_id = e.id
            JOIN grade_items gi ON gi.id = g.grade_item_id
            WHERE e.student_id = fn_has_prerequisites.student_id
            AND e.section_id IN (
                SELECT s2.id FROM sections s2 WHERE s2.course_id = cp.prerequisite_id
            )
            AND g.score >= gi.max_score * 0.6
        )
    ) THEN 1 ELSE 0
END;
