USE booking;

-- ============================================================
-- ROLES
-- ============================================================
INSERT OR IGNORE INTO roles (id, name) VALUES (1, 'Admin');
INSERT OR IGNORE INTO roles (id, name) VALUES (2, 'Manager');
INSERT OR IGNORE INTO roles (id, name) VALUES (3, 'Receptionist');
INSERT OR IGNORE INTO roles (id, name) VALUES (4, 'Customer');

-- ============================================================
-- PERMISSIONS
-- ============================================================
INSERT OR IGNORE INTO permissions (id, name) VALUES (1, 'manage_properties');
INSERT OR IGNORE INTO permissions (id, name) VALUES (2, 'manage_bookings');
INSERT OR IGNORE INTO permissions (id, name) VALUES (3, 'manage_payments');
INSERT OR IGNORE INTO permissions (id, name) VALUES (4, 'view_reports');
INSERT OR IGNORE INTO permissions (id, name) VALUES (5, 'manage_users');
INSERT OR IGNORE INTO permissions (id, name) VALUES (6, 'manage_rates');
INSERT OR IGNORE INTO permissions (id, name) VALUES (7, 'view_own_bookings');

-- ============================================================
-- ROLE-PERMISSION ASSIGNMENTS
-- ============================================================
-- Admin: all
INSERT OR IGNORE INTO role_permission (role_id, permission_id)
SELECT 1, id FROM permissions;

-- Manager: manage_bookings, manage_payments, view_reports, manage_rates
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 2);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 3);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 4);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 6);

-- Receptionist: manage_bookings, manage_payments
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (3, 2);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (3, 3);

-- Customer: view_own_bookings
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (4, 7);

-- ============================================================
-- AMENITIES
-- ============================================================
INSERT OR IGNORE INTO amenities (id, name, icon) VALUES
    (1, 'Free WiFi', 'wifi'),
    (2, 'Swimming Pool', 'pool'),
    (3, 'Gym', 'gym'),
    (4, 'Restaurant', 'restaurant'),
    (5, 'Parking', 'parking'),
    (6, 'Airport Shuttle', 'shuttle'),
    (7, 'Air Conditioning', 'ac'),
    (8, 'Pet Friendly', 'pets'),
    (9, 'Breakfast Included', 'coffee'),
    (10, 'Room Service', 'service');

-- ============================================================
-- SAMPLE PROPERTIES
-- ============================================================
INSERT OR IGNORE INTO properties (id, name, slug, property_type, address, city, country, stars, currency, description)
VALUES
    (1, 'Grand Palace Hotel', 'grand-palace-hotel', 'hotel', '123 Main Street', 'New York', 'USA', 5, 'USD', 'Luxury hotel in the heart of Manhattan'),
    (2, 'Seaside Resort', 'seaside-resort', 'resort', '456 Ocean Drive', 'Miami', 'USA', 4, 'USD', 'Beachfront resort with stunning views'),
    (3, 'Mountain Cabin Retreat', 'mountain-cabin', 'cabin', '789 Pine Road', 'Aspen', 'USA', 3, 'USD', 'Cozy cabin surrounded by nature');

-- ============================================================
-- ROOM TYPES
-- ============================================================
INSERT OR IGNORE INTO room_types (id, property_id, name, max_guests, bed_type, base_price, total_rooms) VALUES
    (1, 1, 'Standard Room', 2, 'queen', 150.00, 20),
    (2, 1, 'Deluxe Room', 3, 'king', 250.00, 10),
    (3, 1, 'Suite', 4, 'king', 400.00, 5),
    (4, 2, 'Ocean View Room', 2, 'queen', 200.00, 15),
    (5, 2, 'Beach Bungalow', 4, 'king', 350.00, 8),
    (6, 3, 'Rustic Cabin', 2, 'double', 120.00, 5),
    (7, 3, 'Family Cabin', 6, 'queen', 220.00, 3);

-- ============================================================
-- ROOMS (auto-generate)
-- ============================================================
INSERT OR IGNORE INTO rooms (id, room_type_id, room_number, floor) VALUES
    (1,  1, '101', 1), (2,  1, '102', 1), (3,  1, '103', 1), (4,  1, '104', 1), (5,  1, '105', 1),
    (6,  1, '201', 2), (7,  1, '202', 2), (8,  1, '203', 2), (9,  1, '204', 2), (10, 1, '205', 2),
    (11, 2, '301', 3), (12, 2, '302', 3), (13, 2, '303', 3), (14, 2, '304', 3), (15, 2, '305', 3),
    (16, 3, '401', 4), (17, 3, '402', 4), (18, 3, '403', 4), (19, 3, '404', 4), (20, 3, '405', 4),
    (21, 4, 'S101', 1), (22, 4, 'S102', 1), (23, 4, 'S103', 1), (24, 4, 'S104', 1), (25, 4, 'S105', 1),
    (26, 5, 'B101', 1), (27, 5, 'B102', 1), (28, 5, 'B103', 1), (29, 5, 'B201', 2), (30, 5, 'B202', 2),
    (31, 6, 'C1', 1), (32, 6, 'C2', 1), (33, 6, 'C3', 1),
    (34, 7, 'F1', 1), (35, 7, 'F2', 1), (36, 7, 'F3', 1);

-- ============================================================
-- PROPERTY AMENITIES
-- ============================================================
INSERT OR IGNORE INTO property_amenities (property_id, amenity_id) VALUES
    (1, 1), (1, 3), (1, 4), (1, 5), (1, 7), (1, 9), (1, 10),
    (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 8),
    (3, 1), (3, 5), (3, 7), (3, 8);

-- ============================================================
-- SERVICES
-- ============================================================
INSERT OR IGNORE INTO services (id, property_id, name, description, price, charge_type) VALUES
    (1, 1, 'Breakfast Buffet', 'Full breakfast buffet', 25.00, 'per_person'),
    (2, 1, 'Airport Transfer', 'One-way airport transfer', 50.00, 'per_unit'),
    (3, 1, 'Spa Session', '60-minute spa treatment', 80.00, 'per_unit'),
    (4, 2, 'Breakfast Buffet', 'Continental breakfast', 20.00, 'per_person'),
    (5, 2, 'Jet Ski Rental', '1 hour jet ski rental', 60.00, 'per_unit'),
    (6, 3, 'Firewood Bundle', 'Bundle of firewood', 15.00, 'per_unit');

-- ============================================================
-- PROMOTIONS
-- ============================================================
INSERT OR IGNORE INTO promotions (id, code, description, discount_type, discount_value, min_nights, valid_from, valid_to) VALUES
    (1, 'WELCOME10', '10% off your first booking', 'percentage', 10.00, 1, '2025-01-01', '2026-12-31'),
    (2, 'STAY5', 'Stay 5 nights get $100 off', 'fixed', 100.00, 5, '2025-01-01', '2026-12-31'),
    (3, 'SUMMER20', '20% off summer bookings', 'percentage', 20.00, 2, '2025-06-01', '2025-08-31');

-- ============================================================
-- ADMIN USER (password: admin123)
-- ============================================================
INSERT OR IGNORE INTO users (id, role_id, username, password_hash, email, first_name, last_name, phone)
VALUES (1, 1, 'admin', '$2y$10$dummyhashforadmin', 'admin@booking.com', 'System', 'Admin', '555-0001');
