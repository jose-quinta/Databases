USE school;

-- ============================================================
-- ROLES
-- ============================================================
INSERT OR IGNORE INTO roles (id, name) VALUES (1, 'Admin');
INSERT OR IGNORE INTO roles (id, name) VALUES (2, 'Teacher');
INSERT OR IGNORE INTO roles (id, name) VALUES (3, 'Student');
INSERT OR IGNORE INTO roles (id, name) VALUES (4, 'Staff');
INSERT OR IGNORE INTO roles (id, name) VALUES (5, 'Parent');

-- ============================================================
-- PERMISSIONS
-- ============================================================
INSERT OR IGNORE INTO permissions (id, name) VALUES (1, 'manage_users');
INSERT OR IGNORE INTO permissions (id, name) VALUES (2, 'manage_courses');
INSERT OR IGNORE INTO permissions (id, name) VALUES (3, 'manage_sections');
INSERT OR IGNORE INTO permissions (id, name) VALUES (4, 'manage_enrollments');
INSERT OR IGNORE INTO permissions (id, name) VALUES (5, 'manage_grades');
INSERT OR IGNORE INTO permissions (id, name) VALUES (6, 'manage_attendance');
INSERT OR IGNORE INTO permissions (id, name) VALUES (7, 'manage_finances');
INSERT OR IGNORE INTO permissions (id, name) VALUES (8, 'view_reports');
INSERT OR IGNORE INTO permissions (id, name) VALUES (9, 'manage_announcements');
INSERT OR IGNORE INTO permissions (id, name) VALUES (10, 'view_own_grades');

-- ============================================================
-- ROLE-PERMISSION ASSIGNMENTS
-- ============================================================
-- Admin: all permissions
INSERT OR IGNORE INTO role_permission (role_id, permission_id)
SELECT 1, id FROM permissions;

-- Teacher: manage_grades, manage_attendance, view_reports, view_own_grades
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 5);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 6);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 8);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 10);

-- Student: view_own_grades
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (3, 10);

-- Staff: manage_enrollments, manage_finances, view_reports
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (4, 4);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (4, 7);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (4, 8);

-- Parent: view_own_grades (for their children)
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (5, 10);

-- ============================================================
-- DEPARTMENTS
-- ============================================================
INSERT OR IGNORE INTO departments (id, name, code) VALUES (1, 'Mathematics', 'MATH');
INSERT OR IGNORE INTO departments (id, name, code) VALUES (2, 'Science', 'SCI');
INSERT OR IGNORE INTO departments (id, name, code) VALUES (3, 'Humanities', 'HUM');
INSERT OR IGNORE INTO departments (id, name, code) VALUES (4, 'Engineering', 'ENG');
INSERT OR IGNORE INTO departments (id, name, code) VALUES (5, 'Arts', 'ARTS');

-- ============================================================
-- PROGRAMS
-- ============================================================
INSERT OR IGNORE INTO programs (id, department_id, name, code, duration_years) VALUES
    (1, 1, 'Mathematics', 'BS-MATH', 4),
    (2, 2, 'Computer Science', 'BS-CS', 4),
    (3, 2, 'Biology', 'BS-BIO', 4),
    (4, 3, 'Literature', 'BA-LIT', 3),
    (5, 4, 'Civil Engineering', 'BS-CE', 5),
    (6, 4, 'Software Engineering', 'BS-SE', 4),
    (7, 5, 'Graphic Design', 'BA-GD', 3);

-- ============================================================
-- ACADEMIC YEARS
-- ============================================================
INSERT OR IGNORE INTO academic_years (id, name, start_date, end_date, is_current) VALUES
    (1, '2024-2025', '2024-09-01', '2025-08-31', 0),
    (2, '2025-2026', '2025-09-01', '2026-08-31', 1);

-- ============================================================
-- PERIODS
-- ============================================================
INSERT OR IGNORE INTO periods (id, academic_year_id, name, start_date, end_date) VALUES
    (1, 1, 'Fall 2024', '2024-09-01', '2024-12-20'),
    (2, 1, 'Spring 2025', '2025-01-13', '2025-05-23'),
    (3, 2, 'Fall 2025', '2025-09-01', '2025-12-20'),
    (4, 2, 'Spring 2026', '2026-01-12', '2026-05-22');

-- ============================================================
-- CLASSROOMS
-- ============================================================
INSERT OR IGNORE INTO classrooms (id, code, building, capacity, type) VALUES
    (1, 'A101', 'Main Building', 30, 'classroom'),
    (2, 'A102', 'Main Building', 25, 'classroom'),
    (3, 'B201', 'Science Wing', 40, 'laboratory'),
    (4, 'B202', 'Science Wing', 35, 'laboratory'),
    (5, 'C301', 'Engineering Wing', 30, 'workshop'),
    (6, 'D401', 'Arts Wing', 20, 'studio');

-- ============================================================
-- TIME SLOTS
-- ============================================================
INSERT OR IGNORE INTO time_slots (id, day, start_time, end_time) VALUES
    (1,  'Monday',    '07:00', '08:30'),
    (2,  'Monday',    '08:45', '10:15'),
    (3,  'Monday',    '10:30', '12:00'),
    (4,  'Monday',    '13:00', '14:30'),
    (5,  'Tuesday',   '07:00', '08:30'),
    (6,  'Tuesday',   '08:45', '10:15'),
    (7,  'Tuesday',   '10:30', '12:00'),
    (8,  'Tuesday',   '13:00', '14:30'),
    (9,  'Wednesday', '07:00', '08:30'),
    (10, 'Wednesday', '08:45', '10:15'),
    (11, 'Wednesday', '10:30', '12:00'),
    (12, 'Wednesday', '13:00', '14:30'),
    (13, 'Thursday',  '07:00', '08:30'),
    (14, 'Thursday',  '08:45', '10:15'),
    (15, 'Thursday',  '10:30', '12:00'),
    (16, 'Thursday',  '13:00', '14:30'),
    (17, 'Friday',    '07:00', '08:30'),
    (18, 'Friday',    '08:45', '10:15'),
    (19, 'Friday',    '10:30', '12:00');

-- ============================================================
-- ADMIN USER (password: admin123)
-- ============================================================
INSERT OR IGNORE INTO users (id, role_id, username, password_hash, email, first_name, last_name, phone)
VALUES (1, 1, 'admin', '$2y$10$dummyhashforadmin', 'admin@school.edu', 'System', 'Admin', '555-0001');

-- ============================================================
-- SCHOLARSHIPS
-- ============================================================
INSERT OR IGNORE INTO scholarships (id, name, discount_percentage, criteria) VALUES
    (1, 'Academic Excellence', 50.00, 'Students with GPA >= 3.8'),
    (2, 'Sports Scholarship', 30.00, 'Outstanding athletes'),
    (3, 'Financial Aid', 75.00, 'Low-income students');
