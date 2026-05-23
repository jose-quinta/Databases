USE university;

-- Finalizes a student's enrollment: calculates final grade and letter grade
-- Parameters: $enrollment_id
-- Run at end of term within application transaction context.

BEGIN TRANSACTION;

    UPDATE enrollments
    SET
        final_grade = ROUND(
            (SELECT SUM(g.score * gc.weight / gc.max_score) / SUM(gc.weight) * 100
             FROM grades g
             JOIN grade_components gc ON gc.id = g.component_id
             WHERE g.enrollment_id = $enrollment_id) / 100.0 * 100, 2
        ),
        status = 'completed'
    WHERE id = $enrollment_id;

COMMIT;
