USE booking;

CREATE TRIGGER IF NOT EXISTS trg_validate_booking_dates
    BEFORE INSERT ON bookings
    FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'check_out must be after check_in')
    WHERE NEW.check_out <= NEW.check_in;

    SELECT RAISE(ABORT, 'check_in cannot be in the past')
    WHERE NEW.check_in < DATE('now');
END;
