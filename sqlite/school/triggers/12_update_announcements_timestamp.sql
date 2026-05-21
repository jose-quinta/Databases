USE school;

CREATE TRIGGER IF NOT EXISTS trg_announcements_updated_at
    AFTER UPDATE ON announcements
    FOR EACH ROW
BEGIN
    UPDATE announcements SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
