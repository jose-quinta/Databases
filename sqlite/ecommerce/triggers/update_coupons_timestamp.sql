USE ecommerce;

CREATE TRIGGER IF NOT EXISTS trg_coupons_updated_at
    AFTER UPDATE ON coupons
    FOR EACH ROW
BEGIN
    UPDATE coupons SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;
