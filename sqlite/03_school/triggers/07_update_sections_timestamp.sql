USE school;

CREATE TRIGGER IF NOT EXISTS trg_sections_updated_at
    AFTER UPDATE ON sections
    FOR EACH ROW
BEGIN
    UPDATE sections SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
