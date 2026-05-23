USE school;

-- Records attendance for multiple students in a section on a given date
-- Parameters: $enrollment_id, $date, $status
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO attendance (enrollment_id, date, status)
    VALUES ($enrollment_id, $date, $status)
    ON CONFLICT(enrollment_id, date) DO UPDATE SET
        status = $status;

COMMIT;
