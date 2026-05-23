USE university;

CREATE TRIGGER IF NOT EXISTS trg_staff_updated_at
    AFTER UPDATE ON staff
    FOR EACH ROW
BEGIN
    UPDATE staff SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
