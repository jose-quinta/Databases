USE university;

-- fn_credits_completed(student_id)
-- Returns total credits earned by a student from completed courses.

CREATE FUNCTION IF NOT EXISTS fn_credits_completed(student_id INTEGER)
RETURNS INTEGER
AS COALESCE(
    (SELECT SUM(c.credits)
     FROM enrollments e
     JOIN course_offerings co ON co.id = e.offering_id
     JOIN courses c ON c.id = co.course_id
     WHERE e.student_id = fn_credits_completed.student_id
       AND e.status = 'completed'
       AND e.final_grade >= 60),
    0
);
