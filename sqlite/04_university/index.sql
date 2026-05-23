-- ============================================================
-- University Database - SQLite
-- ============================================================
-- Run with: sqlite3 university.db < index.sql
-- ============================================================

PRAGMA foreign_keys = ON;

-- ============================================================
-- TABLES
-- ============================================================
.read tables/01_roles.sql
.read tables/02_permissions.sql
.read tables/03_role_permission.sql
.read tables/04_faculties.sql
.read tables/05_departments.sql
.read tables/06_programs.sql
.read tables/07_academic_terms.sql
.read tables/08_courses.sql
.read tables/09_course_versions.sql
.read tables/10_course_prerequisites.sql
.read tables/11_classrooms.sql
.read tables/12_time_slots.sql
.read tables/13_users.sql
.read tables/14_professors.sql
.read tables/15_students.sql
.read tables/16_staff.sql
.read tables/17_course_offerings.sql
.read tables/18_offering_schedule.sql
.read tables/19_enrollments.sql
.read tables/20_grade_components.sql
.read tables/21_grades.sql
.read tables/22_attendance.sql
.read tables/23_tuition_fees.sql
.read tables/24_invoices.sql
.read tables/25_payments.sql
.read tables/26_scholarships.sql
.read tables/27_student_scholarships.sql
.read tables/28_research_projects.sql

-- ============================================================
-- TRIGGERS
-- ============================================================
.read triggers/01_update_faculties_timestamp.sql
.read triggers/02_update_departments_timestamp.sql
.read triggers/03_update_programs_timestamp.sql
.read triggers/04_update_courses_timestamp.sql
.read triggers/05_update_users_timestamp.sql
.read triggers/06_update_professors_timestamp.sql
.read triggers/07_update_students_timestamp.sql
.read triggers/08_update_staff_timestamp.sql
.read triggers/09_update_grades_timestamp.sql
.read triggers/10_update_invoices_timestamp.sql
.read triggers/11_update_scholarships_timestamp.sql
.read triggers/12_update_research_timestamp.sql
.read triggers/13_check_offering_capacity.sql
.read triggers/14_check_schedule_conflict.sql

-- ============================================================
-- VIEWS
-- ============================================================
.read views/vw_student_transcript.sql
.read views/vw_professor_schedule.sql
.read views/vw_offering_roster.sql
.read views/vw_attendance_summary.sql
.read views/vw_financial_status.sql
.read views/vw_research_overview.sql

-- ============================================================
-- UDFs
-- ============================================================
.read UDFs/fn_calculate_gpa.sql
.read UDFs/fn_credits_completed.sql
.read UDFs/fn_attendance_pct.sql
.read UDFs/fn_remaining_balance.sql

-- ============================================================
-- TRANSACTIONS
-- ============================================================
.read transactions/tx_enroll_student.sql
.read transactions/tx_record_grade.sql
.read transactions/tx_finalize_grades.sql
.read transactions/tx_process_payment.sql
.read transactions/tx_create_offering.sql

-- ============================================================
-- SEED DATA
-- ============================================================
.read configurations/seed_data.sql
