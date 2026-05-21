USE school;

CREATE TABLE IF NOT EXISTS course_prerequisites (
    course_id INTEGER NOT NULL,
    prerequisite_id INTEGER NOT NULL,
    PRIMARY KEY (course_id, prerequisite_id),
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE,
    FOREIGN KEY (prerequisite_id) REFERENCES courses(id)
);
