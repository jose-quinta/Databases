USE university;

CREATE TABLE IF NOT EXISTS students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL UNIQUE,
    student_code VARCHAR(20) NOT NULL UNIQUE,
    program_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'active' CHECK(status IN ('active','probation','suspended','graduated','withdrawn')),
    current_term INTEGER DEFAULT 1,
    academic_advisor_id INTEGER,
    gpa DECIMAL(4,3) DEFAULT 0.000,
    credits_earned INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (program_id) REFERENCES programs(id),
    FOREIGN KEY (academic_advisor_id) REFERENCES professors(id)
);
