USE university;

CREATE TRIGGER IF NOT EXISTS trg_check_offering_capacity
    BEFORE INSERT ON enrollments
    FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Course offering is at full capacity')
    WHERE (
        SELECT COUNT(*) FROM enrollments
        WHERE offering_id = NEW.offering_id AND status = 'enrolled'
    ) >= (
        SELECT max_enrollment FROM course_offerings WHERE id = NEW.offering_id
    );
END;
