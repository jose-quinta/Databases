USE booking;

CREATE TRIGGER IF NOT EXISTS trg_room_types_updated_at
    AFTER UPDATE ON room_types
    FOR EACH ROW
BEGIN
    UPDATE room_types SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
