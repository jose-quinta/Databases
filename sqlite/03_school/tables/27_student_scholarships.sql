USE school;

CREATE TABLE IF NOT EXISTS student_scholarships (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    scholarship_id INTEGER NOT NULL,
    period_id INTEGER NOT NULL,
    approved_by INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (scholarship_id) REFERENCES scholarships(id),
    FOREIGN KEY (period_id) REFERENCES periods(id),
    FOREIGN KEY (approved_by) REFERENCES users(id)
);
