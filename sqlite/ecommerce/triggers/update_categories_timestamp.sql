USE ecommerce;

CREATE TRIGGER IF NOT EXISTS trg_categories_updated_at
    AFTER UPDATE ON categories
    FOR EACH ROW
BEGIN
    UPDATE categories SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
