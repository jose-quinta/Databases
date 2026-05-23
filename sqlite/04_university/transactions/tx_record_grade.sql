USE university;

-- Records or updates a grade for a student on a grade component
-- Parameters: $enrollment_id, $component_id, $score
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO grades (enrollment_id, component_id, score)
    VALUES ($enrollment_id, $component_id, $score)
    ON CONFLICT(enrollment_id, component_id) DO UPDATE SET
        score = $score,
        updated_at = CURRENT_TIMESTAMP;

COMMIT;
