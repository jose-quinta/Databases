USE university;

CREATE TABLE IF NOT EXISTS grade_components (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    offering_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    weight DECIMAL(5,2) NOT NULL CHECK(weight > 0 AND weight <= 100),
    max_score DECIMAL(10,2) NOT NULL,
    due_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (offering_id) REFERENCES course_offerings(id) ON DELETE CASCADE
);
