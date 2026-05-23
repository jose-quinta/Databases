USE university;

CREATE TABLE IF NOT EXISTS professors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL UNIQUE,
    employee_code VARCHAR(20) NOT NULL UNIQUE,
    department_id INTEGER NOT NULL,
    title VARCHAR(50) CHECK(title IN ('lecturer','assistant_professor','associate_professor','full_professor','emeritus')),
    specialization VARCHAR(150),
    office_location VARCHAR(100),
    hire_date DATE NOT NULL,
    is_tenured BOOLEAN DEFAULT FALSE,
    max_courses_per_term INTEGER DEFAULT 4,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);
