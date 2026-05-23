# University Database — SQLite

Base de datos relacional para la gestión universitaria construida en SQLite, aplicando **1FN, 2FN, 3FN**, atomicidad e integridad referencial.

## Estructura del proyecto

```
04_university/
  index.sql              # Entry point
  tables/                # 28 tablas
  triggers/              # 14 triggers
  views/                 # 6 vistas
  transactions/          # 5 transacciones parametrizadas
  UDFs/                  # 4 User Defined Functions
  configurations/        # Seed data
```

## Instalación

```bash
sqlite3 university.db < index.sql
```

## Modelo de datos

### Tablas (28)

#### RBAC

| Tabla | Descripción |
|-------|-------------|
| `roles` | Admin, Professor, Student, Staff |
| `permissions` | manage_faculties, manage_programs, manage_courses, manage_offerings, manage_enrollments, manage_grades, manage_finances, manage_research, view_reports, view_own_grades |
| `role_permission` | M:N role ↔ permission |

#### Estructura académica

| Tabla | Atributos clave |
|-------|-----------------|
| `faculties` | id, name, code (UNIQUE), dean_name, building, deleted_at |
| `departments` | id, faculty_id (FK), name, code (UNIQUE), head_name, office_location, deleted_at |
| `programs` | id, department_id (FK), name, code (UNIQUE), level (associate/bachelor/master/doctorate/diploma/specialization), duration_terms, credits_required |
| `academic_terms` | id, name, code (UNIQUE), start_date, end_date, enrollment_start, enrollment_end, is_current |
| `courses` | id, department_id (FK), code (UNIQUE), name, credits, hours_lecture, hours_lab |
| `course_versions` | id, course_id (FK), version, syllabus, objectives, bibliography, min_grade, effective_from, effective_to, UNIQUE(course_id, version) |
| `course_prerequisites` | course_id, prerequisite_id (FKs), min_grade |
| `classrooms` | id, code (UNIQUE), building, floor, capacity, type (classroom/laboratory/auditorium/seminar/studio), has_projector, has_computers |
| `time_slots` | id, day, start_time, end_time |

#### Personas

| Tabla | Atributos clave |
|-------|-----------------|
| `users` | id, role_id (FK), username, password_hash, email, first_name, last_name, phone, is_active, deleted_at |
| `professors` | id, user_id (FK, UNIQUE), employee_code (UNIQUE), department_id (FK), title (lecturer/assistant_professor/associate_professor/full_professor/emeritus), specialization, office_location, hire_date, is_tenured, max_courses_per_term |
| `students` | id, user_id (FK, UNIQUE), student_code (UNIQUE), program_id (FK), enrollment_date, status (active/probation/suspended/graduated/withdrawn), current_term, academic_advisor_id (FK → professors), gpa, credits_earned |
| `staff` | id, user_id (FK, UNIQUE), employee_code (UNIQUE), department_id (FK), position, hire_date, office_location |

#### Académico (oferta, inscripción, evaluación)

| Tabla | Atributos clave |
|-------|-----------------|
| `course_offerings` | id, course_id (FK), professor_id (FK), term_id (FK), section, max_enrollment, current_enrollment, language, modality (in_person/online/hybrid), UNIQUE(course_id, term_id, section) |
| `offering_schedule` | id, offering_id (FK), time_slot_id (FK), classroom_id (FK) |
| `enrollments` | id, student_id (FK), offering_id (FK), enrollment_date, status (enrolled/dropped/completed/failed), final_grade, letter_grade, UNIQUE(student_id, offering_id) |
| `grade_components` | id, offering_id (FK), name, weight (0-100), max_score, due_date |
| `grades` | id, enrollment_id (FK), component_id (FK), score |
| `attendance` | id, enrollment_id (FK), date, status (present/absent/late/excused), remarks |

#### Financiero

| Tabla | Atributos clave |
|-------|-----------------|
| `tuition_fees` | id, program_id (FK), term_id (FK), amount, credits_included, extra_credit_fee, UNIQUE(program_id, term_id) |
| `invoices` | id, student_id (FK), term_id (FK), total, due_date, status (pending/paid/overdue/cancelled/refunded) |
| `payments` | id, invoice_id (FK), amount, method, transaction_id, paid_at |
| `scholarships` | id, name, type (merit/need/sports/cultural/research), discount_percentage (0-100), criteria |
| `student_scholarships` | id, student_id (FK), scholarship_id (FK), term_id (FK), approved_by (FK → users) |

#### Investigación

| Tabla | Atributos clave |
|-------|-----------------|
| `research_projects` | id, title, code (UNIQUE), start_date, end_date, funding_amount, funding_source, status (active/completed/cancelled/pending), lead_professor_id (FK), department_id (FK) |

## Triggers

### Actualización de timestamps (12)
- `trg_faculties_updated_at`, `trg_departments_updated_at`, `trg_programs_updated_at`, `trg_courses_updated_at`, `trg_users_updated_at`, `trg_professors_updated_at`, `trg_students_updated_at`, `trg_staff_updated_at`, `trg_grades_updated_at`, `trg_invoices_updated_at`, `trg_scholarships_updated_at`, `trg_research_projects_updated_at`

### Triggers de negocio (2)

| Trigger | Evento | Acción |
|---------|--------|--------|
| `trg_check_offering_capacity` | `BEFORE INSERT ON enrollments` | Rechaza si el cupo está lleno |
| `trg_check_schedule_conflict` | `BEFORE INSERT ON offering_schedule` | Rechaza choque de horario (profesor y aula) |

## Vistas

| Vista | Propósito |
|-------|-----------|
| `vw_student_transcript` | Historial académico completo con notas finales |
| `vw_professor_schedule` | Horario semanal del profesor |
| `vw_offering_roster` | Lista de estudiantes por sección con notas por componente |
| `vw_attendance_summary` | % de asistencia por estudiante y curso |
| `vw_financial_status` | Balance de facturación vs pagos por estudiante |
| `vw_research_overview` | Proyectos de investigación con líder y departamento |

## Transacciones

| Archivo | Operación |
|---------|-----------|
| `tx_enroll_student` | Inscribe estudiante (evita duplicados) |
| `tx_record_grade` | Inserta o actualiza nota (`ON CONFLICT DO UPDATE`) |
| `tx_finalize_grades` | Calcula nota final y cambia status a completed |
| `tx_process_payment` | Registra pago |
| `tx_create_offering` | Crea una nueva sección de curso |

## UDFs (User Defined Functions)

| Función | Firma | Descripción |
|---------|-------|-------------|
| `fn_calculate_gpa` | `(student_id) → REAL` | GPA ponderado escala 0.000–4.000 |
| `fn_credits_completed` | `(student_id) → INTEGER` | Total de créditos aprobados (nota ≥ 60) |
| `fn_attendance_pct` | `(student_id, offering_id) → REAL` | % de asistencia |
| `fn_remaining_balance` | `(student_id) → REAL` | Saldo pendiente total |

## Seed data

- **Roles:** Admin, Professor, Student, Staff
- **Permisos:** 10 permisos con asignaciones por rol
- **Facultades:** Engineering, Sciences, Humanities, Business, Health Sciences
- **Departamentos:** 10 departamentos
- **Programas:** BS-CS, MS-DS, BS-MATH, BS-BA, PHD-CS
- **Términos:** Fall 2025, Spring 2026 (actual), Summer 2026
- **Cursos:** 8 cursos con prerrequisitos
- **Aulas:** 4 espacios (classrooms, laboratory, auditorium)
- **Horarios:** 19 time slots (Lun–Vie 8:00–15:30)
- **Becas:** Academic Excellence, Sports, Financial Aid, Research Assistant
- **Admin demo:** user `admin`

## Diferencias con `school`

| Característica | school | 04_university |
|----------------|--------|---------------|
| Estructura | departments → programs | faculties → departments → programs |
| Niveles | generic | bachelor, master, doctorate, etc. |
| Cursos | estáticos | course_versions con syllabus histórico |
| Profesores | simple | título académico, tenure, max_courses |
| Investigación | no | research_projects |
| GPA | no | escala 0.000–4.000 con letter grade |
| Horarios | section_schedule | offering_schedule con time_slots separada |
