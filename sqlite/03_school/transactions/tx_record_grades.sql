USE school;

-- Records or updates grades for a student on a grade item
-- Parameters: $enrollment_id, $grade_item_id, $score
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO grades (enrollment_id, grade_item_id, score)
    VALUES ($enrollment_id, $grade_item_id, $score)
    ON CONFLICT(enrollment_id, grade_item_id) DO UPDATE SET
        score = $score,
        updated_at = CURRENT_TIMESTAMP;

COMMIT;
