USE booking;

CREATE TRIGGER IF NOT EXISTS trg_prevent_double_booking
    BEFORE INSERT ON booking_rooms
    FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, 'Room is already booked for the selected dates')
    WHERE EXISTS (
        SELECT 1 FROM booking_rooms br
        JOIN bookings b ON b.id = br.booking_id
        WHERE br.room_id = NEW.room_id
          AND br.id != NEW.id
          AND b.status NOT IN ('cancelled', 'checked_out')
          AND NEW.check_in < br.check_out
          AND NEW.check_out > br.check_in
    );
END;
