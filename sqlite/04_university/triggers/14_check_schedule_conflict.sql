USE university;

CREATE TRIGGER IF NOT EXISTS trg_check_schedule_conflict
    BEFORE INSERT ON offering_schedule
    FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Professor already has a class scheduled at this time')
    WHERE EXISTS (
        SELECT 1 FROM offering_schedule os
        JOIN course_offerings co ON co.id = os.offering_id
        WHERE co.professor_id = (
            SELECT professor_id FROM course_offerings WHERE id = NEW.offering_id
        )
        AND os.time_slot_id = NEW.time_slot_id
        AND os.id != NEW.id
    );

    SELECT RAISE(ABORT, 'Classroom is already occupied at this time')
    WHERE EXISTS (
        SELECT 1 FROM offering_schedule os
        WHERE os.classroom_id = NEW.classroom_id
        AND os.time_slot_id = NEW.time_slot_id
        AND os.id != NEW.id
    );
END;
