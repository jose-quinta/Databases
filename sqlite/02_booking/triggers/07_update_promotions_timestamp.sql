USE booking;

CREATE TRIGGER IF NOT EXISTS trg_promotions_updated_at
    AFTER UPDATE ON promotions
    FOR EACH ROW
BEGIN
    UPDATE promotions SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
