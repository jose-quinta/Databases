USE university;

CREATE TRIGGER IF NOT EXISTS trg_courses_updated_at
    AFTER UPDATE ON courses
    FOR EACH ROW
BEGIN
    UPDATE courses SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
