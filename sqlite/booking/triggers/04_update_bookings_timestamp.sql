USE booking;

CREATE TRIGGER IF NOT EXISTS trg_bookings_updated_at
    AFTER UPDATE ON bookings
    FOR EACH ROW
BEGIN
    UPDATE bookings SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
