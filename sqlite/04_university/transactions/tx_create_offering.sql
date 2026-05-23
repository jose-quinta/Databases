USE university;

-- Creates a new course offering with schedule
-- Parameters: $course_id, $professor_id, $term_id, $section, $max_enrollment
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO course_offerings (course_id, professor_id, term_id, section, max_enrollment)
    VALUES ($course_id, $professor_id, $term_id, $section, $max_enrollment);

COMMIT;
