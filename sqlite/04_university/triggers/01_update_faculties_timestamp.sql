USE university;

CREATE TRIGGER IF NOT EXISTS trg_faculties_updated_at
    AFTER UPDATE ON faculties
    FOR EACH ROW
BEGIN
    UPDATE faculties SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
