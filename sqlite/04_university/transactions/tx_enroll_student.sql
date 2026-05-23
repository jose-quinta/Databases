USE university;

-- Enrolls a student in a course offering
-- Parameters: $student_id, $offering_id
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO enrollments (student_id, offering_id, enrollment_date, status)
    SELECT $student_id, $offering_id, DATE('now'), 'enrolled'
    WHERE NOT EXISTS (
        SELECT 1 FROM enrollments
        WHERE student_id = $student_id AND offering_id = $offering_id AND status = 'enrolled'
    );

COMMIT;
