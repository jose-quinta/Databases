USE university;

CREATE TABLE IF NOT EXISTS course_offerings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_id INTEGER NOT NULL,
    professor_id INTEGER NOT NULL,
    term_id INTEGER NOT NULL,
    section VARCHAR(10) NOT NULL,
    max_enrollment INTEGER NOT NULL,
    current_enrollment INTEGER DEFAULT 0,
    language VARCHAR(20) DEFAULT 'spanish',
    modality VARCHAR(20) DEFAULT 'in_person' CHECK(modality IN ('in_person','online','hybrid')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (professor_id) REFERENCES professors(id),
    FOREIGN KEY (term_id) REFERENCES academic_terms(id),
    UNIQUE(course_id, term_id, section)
);
