USE school;

CREATE TRIGGER IF NOT EXISTS trg_grades_updated_at
    AFTER UPDATE ON grades
    FOR EACH ROW
BEGIN
    UPDATE grades SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
