-- ============================================================
-- School Database - SQLite
-- ============================================================
-- Run with: sqlite3 school.db < index.sql
-- ============================================================

PRAGMA foreign_keys = ON;

-- ============================================================
-- TABLES (order respects foreign key dependencies)
-- ============================================================

-- RBAC (no dependencies)
.read tables/01_roles.sql
.read tables/02_permissions.sql
.read tables/03_role_permission.sql

-- Academic structure
.read tables/04_departments.sql
.read tables/05_programs.sql
.read tables/06_academic_years.sql
.read tables/07_periods.sql
.read tables/08_courses.sql
.read tables/09_course_prerequisites.sql
.read tables/10_classrooms.sql
.read tables/11_time_slots.sql

-- People (depends on roles, departments)
.read tables/12_users.sql
.read tables/13_teachers.sql
.read tables/14_students.sql
.read tables/15_parents.sql
.read tables/16_student_parents.sql

-- Academic operations
.read tables/17_sections.sql
.read tables/18_section_schedule.sql
.read tables/19_enrollments.sql
.read tables/20_grade_items.sql
.read tables/21_grades.sql
.read tables/22_attendance.sql

-- Financial (depends on programs, periods, students)
.read tables/23_tuition_fees.sql
.read tables/24_invoices.sql
.read tables/25_payments.sql
.read tables/26_scholarships.sql
.read tables/27_student_scholarships.sql

-- Communication (depends on roles, users)
.read tables/28_announcements.sql
.read tables/29_events.sql
.read tables/30_documents.sql

-- ============================================================
-- TRIGGERS
-- ============================================================
.read triggers/01_update_departments_timestamp.sql
.read triggers/02_update_programs_timestamp.sql
.read triggers/03_update_courses_timestamp.sql
.read triggers/04_update_users_timestamp.sql
.read triggers/05_update_teachers_timestamp.sql
.read triggers/06_update_students_timestamp.sql
.read triggers/07_update_sections_timestamp.sql
.read triggers/08_update_grades_timestamp.sql
.read triggers/09_update_invoices_timestamp.sql
.read triggers/10_update_scholarships_timestamp.sql
.read triggers/11_update_tuition_fees_timestamp.sql
.read triggers/12_update_announcements_timestamp.sql
.read triggers/13_check_section_capacity.sql
.read triggers/14_check_schedule_conflict.sql
.read triggers/15_update_invoice_status.sql

-- ============================================================
-- VIEWS
-- ============================================================
.read views/vw_student_transcript.sql
.read views/vw_teacher_schedule.sql
.read views/vw_section_roster.sql
.read views/vw_attendance_summary.sql
.read views/vw_financial_status.sql
.read views/vw_overdue_invoices.sql

-- ============================================================
-- UDFs (User Defined Functions - SQLite 3.44+)
-- ============================================================
.read UDFs/fn_calculate_gpa.sql
.read UDFs/fn_attendance_pct.sql
.read UDFs/fn_remaining_balance.sql
.read UDFs/fn_has_prerequisites.sql

-- ============================================================
-- TRANSACTIONS (parameterized business logic templates)
-- ============================================================
.read transactions/tx_register_student.sql
.read transactions/tx_enroll_student.sql
.read transactions/tx_record_grades.sql
.read transactions/tx_record_attendance.sql
.read transactions/tx_process_payment.sql

-- ============================================================
-- SEED DATA
-- ============================================================
.read configurations/seed_data.sql
