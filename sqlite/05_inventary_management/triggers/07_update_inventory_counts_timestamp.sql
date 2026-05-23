USE inventory;

CREATE TRIGGER IF NOT EXISTS trg_inventory_counts_updated_at
    AFTER UPDATE ON inventory_counts
    FOR EACH ROW
BEGIN
    UPDATE inventory_counts SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
