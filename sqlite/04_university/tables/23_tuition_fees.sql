USE university;

CREATE TABLE IF NOT EXISTS tuition_fees (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    program_id INTEGER NOT NULL,
    term_id INTEGER NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    credits_included INTEGER DEFAULT 0,
    extra_credit_fee DECIMAL(10,2) DEFAULT 0.00,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (program_id) REFERENCES programs(id),
    FOREIGN KEY (term_id) REFERENCES academic_terms(id),
    UNIQUE(program_id, term_id)
);
