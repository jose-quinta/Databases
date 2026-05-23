USE university;

CREATE VIEW IF NOT EXISTS vw_research_overview AS
SELECT
    rp.id AS project_id,
    rp.title,
    rp.code,
    rp.status,
    rp.start_date,
    rp.end_date,
    rp.funding_amount,
    rp.funding_source,
    u.first_name || ' ' || u.last_name AS lead_professor,
    p.title AS professor_title,
    d.name AS department_name,
    f.name AS faculty_name
FROM research_projects rp
JOIN professors p ON p.id = rp.lead_professor_id
JOIN users u ON u.id = p.user_id
JOIN departments d ON d.id = rp.department_id
JOIN faculties f ON f.id = d.faculty_id
ORDER BY rp.start_date DESC;
