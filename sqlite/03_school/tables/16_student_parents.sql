USE school;

CREATE TABLE IF NOT EXISTS student_parents (
    student_id INTEGER NOT NULL,
    parent_id INTEGER NOT NULL,
    relationship VARCHAR(50) NOT NULL,
    is_primary_contact BOOLEAN DEFAULT FALSE,
    is_emergency_contact BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (student_id, parent_id),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES parents(id) ON DELETE CASCADE
);
