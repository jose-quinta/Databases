USE school;

CREATE TRIGGER IF NOT EXISTS trg_programs_updated_at
    AFTER UPDATE ON programs
    FOR EACH ROW
BEGIN
    UPDATE programs SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
