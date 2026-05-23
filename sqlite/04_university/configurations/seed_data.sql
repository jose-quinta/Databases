USE university;

-- ============================================================
-- ROLES
-- ============================================================
INSERT OR IGNORE INTO roles (id, name) VALUES (1, 'Admin');
INSERT OR IGNORE INTO roles (id, name) VALUES (2, 'Professor');
INSERT OR IGNORE INTO roles (id, name) VALUES (3, 'Student');
INSERT OR IGNORE INTO roles (id, name) VALUES (4, 'Staff');

-- ============================================================
-- PERMISSIONS
-- ============================================================
INSERT OR IGNORE INTO permissions (id, name) VALUES (1, 'manage_faculties');
INSERT OR IGNORE INTO permissions (id, name) VALUES (2, 'manage_programs');
INSERT OR IGNORE INTO permissions (id, name) VALUES (3, 'manage_courses');
INSERT OR IGNORE INTO permissions (id, name) VALUES (4, 'manage_offerings');
INSERT OR IGNORE INTO permissions (id, name) VALUES (5, 'manage_enrollments');
INSERT OR IGNORE INTO permissions (id, name) VALUES (6, 'manage_grades');
INSERT OR IGNORE INTO permissions (id, name) VALUES (7, 'manage_finances');
INSERT OR IGNORE INTO permissions (id, name) VALUES (8, 'manage_research');
INSERT OR IGNORE INTO permissions (id, name) VALUES (9, 'view_reports');
INSERT OR IGNORE INTO permissions (id, name) VALUES (10, 'view_own_grades');

-- ============================================================
-- ROLE-PERMISSION ASSIGNMENTS
-- ============================================================
INSERT OR IGNORE INTO role_permission (role_id, permission_id)
SELECT 1, id FROM permissions;

INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 6);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 8);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 9);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 10);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (3, 10);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (4, 5);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (4, 7);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (4, 9);

-- ============================================================
-- FACULTIES
-- ============================================================
INSERT OR IGNORE INTO faculties (id, name, code, description) VALUES
    (1, 'Faculty of Engineering', 'ENG', 'Engineering and technology programs'),
    (2, 'Faculty of Sciences', 'SCI', 'Natural and formal sciences'),
    (3, 'Faculty of Humanities', 'HUM', 'Humanities and social sciences'),
    (4, 'Faculty of Business', 'BUS', 'Business and economics'),
    (5, 'Faculty of Health Sciences', 'HLT', 'Medicine and health sciences');

-- ============================================================
-- DEPARTMENTS
-- ============================================================
INSERT OR IGNORE INTO departments (id, faculty_id, name, code) VALUES
    (1, 1, 'Computer Science', 'CS'),
    (2, 1, 'Electrical Engineering', 'EE'),
    (3, 1, 'Mechanical Engineering', 'ME'),
    (4, 2, 'Mathematics', 'MATH'),
    (5, 2, 'Physics', 'PHY'),
    (6, 2, 'Biology', 'BIO'),
    (7, 3, 'Philosophy', 'PHIL'),
    (8, 3, 'Literature', 'LIT'),
    (9, 4, 'Business Administration', 'BA'),
    (10, 4, 'Accounting', 'ACC');

-- ============================================================
-- PROGRAMS
-- ============================================================
INSERT OR IGNORE INTO programs (id, department_id, name, code, level, duration_terms, credits_required) VALUES
    (1, 1, 'BS Computer Science', 'BS-CS', 'bachelor', 8, 180),
    (2, 1, 'MS Data Science', 'MS-DS', 'master', 4, 60),
    (3, 4, 'BS Mathematics', 'BS-MATH', 'bachelor', 8, 180),
    (4, 9, 'BS Business Administration', 'BS-BA', 'bachelor', 8, 170),
    (5, 1, 'PhD Computer Science', 'PHD-CS', 'doctorate', 6, 90);

-- ============================================================
-- ACADEMIC TERMS
-- ============================================================
INSERT OR IGNORE INTO academic_terms (id, name, code, start_date, end_date, is_current) VALUES
    (1, 'Fall 2025', '2025-1', '2025-09-01', '2025-12-20', 0),
    (2, 'Spring 2026', '2026-1', '2026-01-12', '2026-05-22', 1),
    (3, 'Summer 2026', '2026-2', '2026-06-01', '2026-08-15', 0);

-- ============================================================
-- COURSES
-- ============================================================
INSERT OR IGNORE INTO courses (id, department_id, code, name, credits, hours_lecture, hours_lab) VALUES
    (1, 1, 'CS101', 'Introduction to Programming', 4, 3, 2),
    (2, 1, 'CS201', 'Data Structures', 4, 3, 2),
    (3, 1, 'CS301', 'Database Systems', 4, 3, 2),
    (4, 1, 'CS401', 'Artificial Intelligence', 4, 3, 2),
    (5, 4, 'MATH101', 'Calculus I', 4, 4, 0),
    (6, 4, 'MATH201', 'Linear Algebra', 3, 3, 0),
    (7, 9, 'BA101', 'Introduction to Business', 3, 3, 0),
    (8, 9, 'BA201', 'Marketing', 3, 3, 0);

-- ============================================================
-- PREREQUISITES
-- ============================================================
INSERT OR IGNORE INTO course_prerequisites (course_id, prerequisite_id) VALUES
    (2, 1),
    (3, 2),
    (4, 3),
    (4, 6),
    (6, 5);

-- ============================================================
-- CLASSROOMS
-- ============================================================
INSERT OR IGNORE INTO classrooms (id, code, building, capacity, type) VALUES
    (1, 'A101', 'Main Building', 40, 'classroom'),
    (2, 'A102', 'Main Building', 30, 'classroom'),
    (3, 'LAB01', 'Science Wing', 25, 'laboratory'),
    (4, 'AUD01', 'Main Building', 120, 'auditorium');

-- ============================================================
-- TIME SLOTS
-- ============================================================
INSERT OR IGNORE INTO time_slots (id, day, start_time, end_time) VALUES
    (1,  'Monday',    '08:00', '09:30'),
    (2,  'Monday',    '09:45', '11:15'),
    (3,  'Monday',    '11:30', '13:00'),
    (4,  'Monday',    '14:00', '15:30'),
    (5,  'Tuesday',   '08:00', '09:30'),
    (6,  'Tuesday',   '09:45', '11:15'),
    (7,  'Tuesday',   '11:30', '13:00'),
    (8,  'Tuesday',   '14:00', '15:30'),
    (9,  'Wednesday', '08:00', '09:30'),
    (10, 'Wednesday', '09:45', '11:15'),
    (11, 'Wednesday', '11:30', '13:00'),
    (12, 'Wednesday', '14:00', '15:30'),
    (13, 'Thursday',  '08:00', '09:30'),
    (14, 'Thursday',  '09:45', '11:15'),
    (15, 'Thursday',  '11:30', '13:00'),
    (16, 'Thursday',  '14:00', '15:30'),
    (17, 'Friday',    '08:00', '09:30'),
    (18, 'Friday',    '09:45', '11:15'),
    (19, 'Friday',    '11:30', '13:00');

-- ============================================================
-- SCHOLARSHIPS
-- ============================================================
INSERT OR IGNORE INTO scholarships (id, name, type, discount_percentage, criteria) VALUES
    (1, 'Academic Excellence', 'merit', 50.00, 'GPA >= 3.8'),
    (2, 'Sports Scholarship', 'sports', 30.00, 'Outstanding athletes'),
    (3, 'Financial Aid', 'need', 75.00, 'Low-income students'),
    (4, 'Research Assistant', 'research', 100.00, 'Active research projects');

-- ============================================================
-- ADMIN USER (password: admin123)
-- ============================================================
INSERT OR IGNORE INTO users (id, role_id, username, password_hash, email, first_name, last_name, phone)
VALUES (1, 1, 'admin', '$2y$10$dummyhashforadmin', 'admin@university.edu', 'System', 'Admin', '555-0001');
