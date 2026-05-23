USE university;

CREATE TABLE IF NOT EXISTS enrollments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    offering_id INTEGER NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT (DATE('now')),
    status VARCHAR(20) NOT NULL DEFAULT 'enrolled' CHECK(status IN ('enrolled','dropped','completed','failed')),
    final_grade DECIMAL(4,2),
    letter_grade VARCHAR(2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (offering_id) REFERENCES course_offerings(id),
    UNIQUE(student_id, offering_id)
);
