USE booking;

CREATE TRIGGER IF NOT EXISTS trg_calculate_booking_nights
    AFTER INSERT ON bookings
    FOR EACH ROW
BEGIN
    UPDATE bookings
    SET total_nights = CAST(JULIANDAY(NEW.check_out) - JULIANDAY(NEW.check_in) AS INTEGER)
    WHERE id = NEW.id;
END;
