USE university;

CREATE TABLE IF NOT EXISTS course_versions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER NOT NULL,
    version VARCHAR(20) NOT NULL,
    syllabus TEXT,
    objectives TEXT,
    bibliography TEXT,
    min_grade DECIMAL(4,2) DEFAULT 60.00,
    effective_from DATE NOT NULL,
    effective_to DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    UNIQUE(course_id, version)
);
