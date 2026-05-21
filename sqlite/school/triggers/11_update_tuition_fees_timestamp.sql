USE school;

CREATE TRIGGER IF NOT EXISTS trg_tuition_fees_updated_at
    AFTER UPDATE ON tuition_fees
    FOR EACH ROW
BEGIN
    UPDATE tuition_fees SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
