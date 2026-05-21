USE school;

CREATE TRIGGER IF NOT EXISTS trg_check_section_capacity
    BEFORE INSERT ON enrollments
    FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Section is at full capacity')
    WHERE (
        SELECT COUNT(*) FROM enrollments
        WHERE section_id = NEW.section_id AND status = 'active'
    ) >= (SELECT capacity FROM sections WHERE id = NEW.section_id);
END;
