USE university;

CREATE TABLE IF NOT EXISTS classrooms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    code VARCHAR(20) NOT NULL UNIQUE,
    building VARCHAR(100),
    floor INTEGER,
    capacity INTEGER NOT NULL,
    type VARCHAR(50) DEFAULT 'classroom' CHECK(type IN ('classroom','laboratory','auditorium','seminar','studio')),
    has_projector BOOLEAN DEFAULT FALSE,
    has_computers BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
