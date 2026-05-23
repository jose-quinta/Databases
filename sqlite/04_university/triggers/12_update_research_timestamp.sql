USE university;

CREATE TRIGGER IF NOT EXISTS trg_research_projects_updated_at
    AFTER UPDATE ON research_projects
    FOR EACH ROW
BEGIN
    UPDATE research_projects SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
