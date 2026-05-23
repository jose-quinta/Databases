USE university;

CREATE TRIGGER IF NOT EXISTS trg_professors_updated_at
    AFTER UPDATE ON professors
    FOR EACH ROW
BEGIN
    UPDATE professors SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
