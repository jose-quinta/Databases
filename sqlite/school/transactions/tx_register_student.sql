USE school;

-- Registers a new student: creates user + student profile
-- Parameters: $username, $password_hash, $email, $first_name, $last_name, $phone, $program_id, $student_code
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO users (role_id, username, password_hash, email, first_name, last_name, phone)
    VALUES (3, $username, $password_hash, $email, $first_name, $last_name, $phone);

    INSERT INTO students (user_id, student_code, program_id, enrollment_date)
    VALUES (last_insert_rowid(), $student_code, $program_id, DATE('now'));

COMMIT;
