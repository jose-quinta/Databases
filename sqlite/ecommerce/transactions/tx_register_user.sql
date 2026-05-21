USE ecommerce;

-- Registers a new user with customer role, profile and empty cart
-- Parameters: $name, $email, $password_hash, $phone
-- Run within application transaction context.

BEGIN TRANSACTION;

    INSERT INTO users (role_id, name, email, password_hash, phone)
    VALUES (2, $name, $email, $password_hash, $phone);

    INSERT INTO customers (user_id)
    VALUES (last_insert_rowid());

    INSERT INTO carts (user_id)
    VALUES (last_insert_rowid());

COMMIT;
