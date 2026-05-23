USE school;

CREATE TRIGGER IF NOT EXISTS trg_check_schedule_conflict
    BEFORE INSERT ON section_schedule
    FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Teacher already has a class scheduled at this time')
    WHERE EXISTS (
        SELECT 1
        FROM section_schedule ss
        JOIN sections s ON s.id = ss.section_id
        WHERE s.teacher_id = (
            SELECT teacher_id FROM sections WHERE id = NEW.section_id
        )
        AND ss.time_slot_id = NEW.time_slot_id
        AND ss.id != NEW.id
    );

    SELECT RAISE(ABORT, 'Classroom is already occupied at this time')
    WHERE EXISTS (
        SELECT 1
        FROM section_schedule ss
        WHERE ss.classroom_id = NEW.classroom_id
        AND ss.time_slot_id = NEW.time_slot_id
        AND ss.id != NEW.id
    );
END;
