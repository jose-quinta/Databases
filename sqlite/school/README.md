# School Database — SQLite

Base de datos relacional para un sistema de gestión escolar construida en SQLite, aplicando **1FN, 2FN, 3FN**, atomicidad, integridad referencial y soft delete.

## Estructura del proyecto

```
school/
  index.sql              # Entry point: ejecuta todo en orden
  tables/                # Definición de tablas (30)
  triggers/              # Triggers de negocio y timestamps (15)
  views/                 # Vistas de consulta (6)
  transactions/          # Transacciones parametrizadas (5)
  UDFs/                  # User Defined Functions — SQLite 3.44+ (4)
  configurations/        # Seed data inicial
```

## Requisitos

- SQLite 3.44+ (para soporte completo de `CREATE FUNCTION`)
- SQLite 3.x para el resto del schema

## Instalación

```bash
sqlite3 school.db < index.sql
```

## Modelo de datos

### Diagrama de relaciones (ER)

```
                    ┌──────────┐
                    │   roles  │
                    └────┬─────┘
                         │
           ┌─────────────┼──────────────────┐
           │             │                  │
    ┌──────┴──────┐    ┌─┴──────────┐    ┌──┴───────────┐
    │ permissions │    │    users   │    │ announcements│
    └──────┬──────┘    └┬─┬──┬──┬───┘    └──────────────┘
           │            │ │  │  │
  ┌────────┴────────┐   │ │  │  └──────────┐
  │ role_permission │   │ │  │             │
  └─────────────────┘   │ │  │       ┌─────┴──────┐
                        │ │  │       │  documents  │
                        │ │  │       └────────────┘
          ┌─────────────┘ │  └──────────────┐
          │               │                 │
    ┌─────┴──────┐  ┌────┴──────┐   ┌──────┴───────┐
    │  teachers  │  │ students  │   │   parents    │
    └─────┬──────┘  └┬──┬──┬────┘   └──────┬───────┘
          │          │  │  │               │
   ┌──────┴──────┐   │  │  │     ┌─────────┴──────────┐
   │ departments │   │  │  │     │  student_parents   │
   └──────┬──────┘   │  │  │     └────────────────────┘
          │          │  │  │
    ┌─────┴─────┐    │  │  └───────────────────┐
    │ programs  │    │  │                      │
    └─────┬─────┘    │  │                 ┌────┴─────┐
          │          │  │                 │invoices  │
    ┌─────┴─────┐    │  │                 └┬──┬──────┘
    │  courses  │    │  │                  │  │
    └─────┬─────┘    │  │            ┌─────┘  └──────┐
          │          │  │            │               │
    ┌─────┴──────────┘  │     ┌──────┴──────┐  ┌────┴───────┐
    │course_prereqs     │     │  payments   │  │tuition_fees│
    └───────────────────┘     └─────────────┘  └────────────┘

    students ──< enrollments >── sections ──< section_schedule >── time_slots
                                      │                              │
                                      │                         ┌────┴──────┐
                                      │                         │classrooms │
                                      │                         └───────────┘
                                 ┌────┴──────┐
                                 │grade_items│
                                 └────┬──────┘
                                      │
                                 ┌────┴──────┐
                                 │   grades  │
                                 └───────────┘

    enrollments ──< attendance

    students ──< student_scholarships >── scholarships
    users ──< events
```

### Tablas

#### RBAC

##### roles
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(50) | NOT NULL |

##### permissions
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(50) | NOT NULL |

##### role_permission
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| role_id | INTEGER | PK, FK → roles(id) ON DELETE CASCADE |
| permission_id | INTEGER | PK, FK → permissions(id) ON DELETE CASCADE |

#### Estructura académica

##### departments
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(100) | NOT NULL |
| code | VARCHAR(10) | NOT NULL, UNIQUE |
| description | TEXT | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

##### programs
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| department_id | INTEGER | NOT NULL, FK → departments(id) |
| name | VARCHAR(150) | NOT NULL |
| code | VARCHAR(20) | NOT NULL, UNIQUE |
| duration_years | INTEGER | NOT NULL |
| description | TEXT | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

##### academic_years
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(20) | NOT NULL |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| is_current | BOOLEAN | DEFAULT FALSE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### periods
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| academic_year_id | INTEGER | NOT NULL, FK → academic_years(id) ON DELETE CASCADE |
| name | VARCHAR(50) | NOT NULL |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### courses
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| department_id | INTEGER | NOT NULL, FK → departments(id) |
| code | VARCHAR(20) | NOT NULL, UNIQUE |
| name | VARCHAR(150) | NOT NULL |
| credits | INTEGER | NOT NULL, DEFAULT 0 |
| description | TEXT | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

##### course_prerequisites
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| course_id | INTEGER | PK, FK → courses(id) ON DELETE CASCADE |
| prerequisite_id | INTEGER | PK, FK → courses(id) |

##### classrooms
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| code | VARCHAR(20) | NOT NULL, UNIQUE |
| building | VARCHAR(100) | |
| capacity | INTEGER | NOT NULL |
| type | VARCHAR(50) | DEFAULT 'classroom' |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### time_slots
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| day | VARCHAR(15) | NOT NULL, CHECK('Monday'..'Saturday') |
| start_time | TIME | NOT NULL |
| end_time | TIME | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### Personas

##### users
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| role_id | INTEGER | NOT NULL, FK → roles(id) |
| username | VARCHAR(50) | NOT NULL, UNIQUE |
| password_hash | VARCHAR(255) | NOT NULL |
| email | VARCHAR(100) | NOT NULL, UNIQUE |
| first_name | VARCHAR(50) | NOT NULL |
| last_name | VARCHAR(50) | NOT NULL |
| phone | VARCHAR(20) | |
| address | TEXT | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

##### teachers
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| user_id | INTEGER | NOT NULL, UNIQUE, FK → users(id) ON DELETE CASCADE |
| employee_code | VARCHAR(20) | NOT NULL, UNIQUE |
| department_id | INTEGER | NOT NULL, FK → departments(id) |
| specialization | VARCHAR(150) | |
| hire_date | DATE | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### students
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| user_id | INTEGER | NOT NULL, UNIQUE, FK → users(id) ON DELETE CASCADE |
| student_code | VARCHAR(20) | NOT NULL, UNIQUE |
| program_id | INTEGER | NOT NULL, FK → programs(id) |
| enrollment_date | DATE | NOT NULL |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'active', CHECK('active','graduated','suspended','withdrawn') |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### parents
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| user_id | INTEGER | NOT NULL, UNIQUE, FK → users(id) ON DELETE CASCADE |
| occupation | VARCHAR(100) | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### student_parents
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| student_id | INTEGER | PK, FK → students(id) ON DELETE CASCADE |
| parent_id | INTEGER | PK, FK → parents(id) ON DELETE CASCADE |
| relationship | VARCHAR(50) | NOT NULL |
| is_primary_contact | BOOLEAN | DEFAULT FALSE |
| is_emergency_contact | BOOLEAN | DEFAULT FALSE |

#### Académico (secciones, inscripciones, notas)

##### sections
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| course_id | INTEGER | NOT NULL, FK → courses(id) |
| teacher_id | INTEGER | NOT NULL, FK → teachers(id) |
| period_id | INTEGER | NOT NULL, FK → periods(id) |
| name | VARCHAR(50) | NOT NULL |
| capacity | INTEGER | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### section_schedule
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| section_id | INTEGER | NOT NULL, FK → sections(id) ON DELETE CASCADE |
| time_slot_id | INTEGER | NOT NULL, FK → time_slots(id) |
| classroom_id | INTEGER | NOT NULL, FK → classrooms(id) |

##### enrollments
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| student_id | INTEGER | NOT NULL, FK → students(id) ON DELETE CASCADE |
| section_id | INTEGER | NOT NULL, FK → sections(id) |
| enrollment_date | DATE | NOT NULL, DEFAULT TODAY |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'active', CHECK('active','dropped','completed') |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### grade_items
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| section_id | INTEGER | NOT NULL, FK → sections(id) ON DELETE CASCADE |
| name | VARCHAR(100) | NOT NULL |
| weight | DECIMAL(5,2) | NOT NULL, CHECK(> 0 and <= 100) |
| max_score | DECIMAL(10,2) | NOT NULL |
| due_date | DATE | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### grades
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| enrollment_id | INTEGER | NOT NULL, FK → enrollments(id) ON DELETE CASCADE |
| grade_item_id | INTEGER | NOT NULL, FK → grade_items(id) |
| score | DECIMAL(10,2) | |
| submitted_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### attendance
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| enrollment_id | INTEGER | NOT NULL, FK → enrollments(id) ON DELETE CASCADE |
| date | DATE | NOT NULL |
| status | VARCHAR(20) | NOT NULL, CHECK('present','absent','late','excused') |
| remarks | TEXT | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### Financiero

##### tuition_fees
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| program_id | INTEGER | NOT NULL, FK → programs(id) |
| period_id | INTEGER | NOT NULL, FK → periods(id) |
| amount | DECIMAL(12,2) | NOT NULL |
| description | TEXT | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| | | UNIQUE(program_id, period_id) |

##### invoices
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| student_id | INTEGER | NOT NULL, FK → students(id) |
| period_id | INTEGER | NOT NULL, FK → periods(id) |
| total | DECIMAL(12,2) | NOT NULL |
| due_date | DATE | NOT NULL |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'pending', CHECK('pending','paid','overdue','cancelled') |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### payments
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| invoice_id | INTEGER | NOT NULL, FK → invoices(id) |
| amount | DECIMAL(12,2) | NOT NULL |
| method | VARCHAR(50) | NOT NULL |
| transaction_id | VARCHAR(100) | |
| paid_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### scholarships
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(100) | NOT NULL |
| discount_percentage | DECIMAL(5,2) | NOT NULL, CHECK(0–100) |
| criteria | TEXT | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### student_scholarships
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| student_id | INTEGER | NOT NULL, FK → students(id) ON DELETE CASCADE |
| scholarship_id | INTEGER | NOT NULL, FK → scholarships(id) |
| period_id | INTEGER | NOT NULL, FK → periods(id) |
| approved_by | INTEGER | NOT NULL, FK → users(id) |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### Comunicación

##### announcements
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| title | VARCHAR(200) | NOT NULL |
| body | TEXT | NOT NULL |
| target_role_id | INTEGER | FK → roles(id) (NULL = todos) |
| created_by | INTEGER | NOT NULL, FK → users(id) |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### events
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| title | VARCHAR(200) | NOT NULL |
| description | TEXT | |
| location | VARCHAR(150) | |
| start_datetime | TIMESTAMP | NOT NULL |
| end_datetime | TIMESTAMP | NOT NULL |
| created_by | INTEGER | NOT NULL, FK → users(id) |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

##### documents
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| uploader_id | INTEGER | NOT NULL, FK → users(id) |
| filename | VARCHAR(255) | NOT NULL |
| file_path | VARCHAR(500) | NOT NULL |
| type | VARCHAR(50) | |
| size | INTEGER | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

## Triggers

### Actualización de timestamps (12)
Cada tabla con `updated_at` tiene un trigger `AFTER UPDATE`:
- `trg_departments_updated_at`
- `trg_programs_updated_at`
- `trg_courses_updated_at`
- `trg_users_updated_at`
- `trg_teachers_updated_at`
- `trg_students_updated_at`
- `trg_sections_updated_at`
- `trg_grades_updated_at`
- `trg_invoices_updated_at`
- `trg_scholarships_updated_at`
- `trg_tuition_fees_updated_at`
- `trg_announcements_updated_at`

### Triggers de negocio (3)

| Trigger | Evento | Acción |
|---------|--------|--------|
| `trg_check_section_capacity` | `BEFORE INSERT ON enrollments` | Rechaza inscripción si la sección está llena |
| `trg_check_schedule_conflict` | `BEFORE INSERT ON section_schedule` | Rechaza si el profesor o el aula ya tienen clase en ese horario |
| `trg_update_invoice_status` | `AFTER INSERT ON payments` | Marca la factura como `paid` cuando los pagos cubren el total |

## Vistas

| Vista | Propósito |
|-------|-----------|
| `vw_student_transcript` | Historial académico completo con nota final y letra (A–F) por curso |
| `vw_teacher_schedule` | Horario semanal del profesor con aula y curso |
| `vw_section_roster` | Lista de estudiantes por sección con calificaciones por ítem |
| `vw_attendance_summary` | % de asistencia (presente, ausente, tarde, justificado) por estudiante y curso |
| `vw_financial_status` | Balance de facturación vs pagos por estudiante |
| `vw_overdue_invoices` | Facturas vencidas con días de mora y monto pendiente |

## Transacciones

Archivos SQL parametrizados con bloques `BEGIN/COMMIT`.

| Archivo | Operación |
|---------|-----------|
| `tx_register_student.sql` | Crea usuario + perfil estudiante |
| `tx_enroll_student.sql` | Inscribe estudiante en una sección (evita duplicados activos) |
| `tx_record_grades.sql` | Inserta o actualiza calificación (`ON CONFLICT DO UPDATE`) |
| `tx_record_attendance.sql` | Inserta o actualiza asistencia por fecha |
| `tx_process_payment.sql` | Registra pago (el trigger actualiza la factura automáticamente) |

## UDFs (User Defined Functions)

Requiere SQLite 3.44+ con soporte de `CREATE FUNCTION`. Cada archivo incluye la expresión SQL equivalente para versiones anteriores.

| Función | Firma | Descripción |
|---------|-------|-------------|
| `fn_calculate_gpa` | `(student_id, period_id) → REAL` | GPA ponderado escala 0.0–4.0 |
| `fn_attendance_pct` | `(student_id, section_id) → REAL` | % de asistencia (presente, tarde o justificado cuentan) |
| `fn_remaining_balance` | `(student_id) → REAL` | Suma de saldos pendientes en todas las facturas |
| `fn_has_prerequisites` | `(student_id, course_id) → INTEGER` | 1 si aprobó todos los prerrequisitos (score ≥ 60%) |

## Seed data

`configurations/seed_data.sql` inserta datos iniciales:

- **Roles:** Admin, Teacher, Student, Staff, Parent
- **Permisos:** manage_users, manage_courses, manage_sections, manage_enrollments, manage_grades, manage_attendance, manage_finances, view_reports, manage_announcements, view_own_grades
- **Role-permission:** Admin → todos; Teacher → grades, attendance, reports; Student → own_grades; Staff → enrollments, finances, reports; Parent → own_grades
- **Departamentos:** Mathematics, Science, Humanities, Engineering, Arts
- **Programas:** BS-MATH, BS-CS, BS-BIO, BA-LIT, BS-CE, BS-SE, BA-GD
- **Años académicos:** 2024-2025, 2025-2026 (actual)
- **Períodos:** Fall 2024, Spring 2025, Fall 2025, Spring 2026
- **Aulas:** 6 espacios (classrooms, laboratories, workshop, studio)
- **Horarios:** 19 time slots (Lun–Vie, 7:00–14:30)
- **Admin demo:** user `admin`
- **Becas:** Academic Excellence (50%), Sports (30%), Financial Aid (75%)

## Compatibilidad

| Característica | SQLite mínimo |
|----------------|---------------|
| Tablas, vistas, triggers | 3.x |
| `CREATE FUNCTION` | 3.44+ |
| `ON CONFLICT DO UPDATE` | 3.24+ |
| `PRAGMA foreign_keys` | 3.x |

Para cargar todo el schema:

```bash
sqlite3 school.db < index.sql
```
