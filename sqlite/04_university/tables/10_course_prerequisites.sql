USE university;

CREATE TABLE IF NOT EXISTS course_prerequisites (
    course_id INTEGER NOT NULL,
    prerequisite_id INTEGER NOT NULL,
    min_grade DECIMAL(4,2) DEFAULT 60.00,
    PRIMARY KEY (course_id, prerequisite_id),
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_id) REFERENCES courses(id)
);
