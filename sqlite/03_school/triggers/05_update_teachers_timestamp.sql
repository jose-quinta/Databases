USE school;

CREATE TRIGGER IF NOT EXISTS trg_teachers_updated_at
    AFTER UPDATE ON teachers
    FOR EACH ROW
BEGIN
    UPDATE teachers SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
