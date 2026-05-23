USE university;

-- fn_calculate_gpa(student_id)
-- Returns weighted GPA (0.000 - 4.000) based on all completed enrollments.
--
-- Requires SQLite 3.44+ with CREATE FUNCTION support.
-- Grade scale: 90-100=A(4.0), 80-89=B(3.0), 70-79=C(2.0), 60-69=D(1.0), <60=F(0.0)

CREATE FUNCTION IF NOT EXISTS fn_calculate_gpa(student_id INTEGER)
RETURNS REAL
AS ROUND(
    COALESCE(
        (SELECT SUM(
            CASE
                WHEN e.final_grade >= 90 THEN 4.0 * c.credits
                WHEN e.final_grade >= 80 THEN 3.0 * c.credits
                WHEN e.final_grade >= 70 THEN 2.0 * c.credits
                WHEN e.final_grade >= 60 THEN 1.0 * c.credits
                ELSE 0.0
            END
        ) / NULLIF(SUM(c.credits), 0)
        FROM enrollments e
        JOIN course_offerings co ON co.id = e.offering_id
        JOIN courses c ON c.id = co.course_id
        WHERE e.student_id = fn_calculate_gpa.student_id
          AND e.status = 'completed'
        ),
        0
    ), 3
);
