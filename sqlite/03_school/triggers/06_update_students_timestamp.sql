USE school;

CREATE TRIGGER IF NOT EXISTS trg_students_updated_at
    AFTER UPDATE ON students
    FOR EACH ROW
BEGIN
    UPDATE students SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
