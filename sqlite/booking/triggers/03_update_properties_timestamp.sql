USE booking;

CREATE TRIGGER IF NOT EXISTS trg_properties_updated_at
    AFTER UPDATE ON properties
    FOR EACH ROW
BEGIN
    UPDATE properties SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
