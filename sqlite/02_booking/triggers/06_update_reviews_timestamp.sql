USE booking;

CREATE TRIGGER IF NOT EXISTS trg_reviews_updated_at
    AFTER UPDATE ON reviews
    FOR EACH ROW
BEGIN
    UPDATE reviews SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
