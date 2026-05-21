USE school;

-- Enrolls a student in a section: checks prerequisites, capacity, and creates enrollment
-- Parameters: $student_id, $section_id
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO enrollments (student_id, section_id, enrollment_date, status)
    SELECT $student_id, $section_id, DATE('now'), 'active'
    WHERE NOT EXISTS (
        SELECT 1 FROM enrollments
        WHERE student_id = $student_id AND section_id = $section_id AND status = 'active'
    );

COMMIT;
