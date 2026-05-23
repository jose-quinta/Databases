USE university;

CREATE TRIGGER IF NOT EXISTS trg_scholarships_updated_at
    AFTER UPDATE ON scholarships
    FOR EACH ROW
BEGIN
    UPDATE scholarships SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
