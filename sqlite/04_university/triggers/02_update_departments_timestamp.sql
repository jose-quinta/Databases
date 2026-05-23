USE university;

CREATE TRIGGER IF NOT EXISTS trg_departments_updated_at
    AFTER UPDATE ON departments
    FOR EACH ROW
BEGIN
    UPDATE departments SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
