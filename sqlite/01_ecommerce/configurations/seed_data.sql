USE ecommerce;

-- Seed roles
INSERT OR IGNORE INTO roles (id, name) VALUES (1, 'Admin');
INSERT OR IGNORE INTO roles (id, name) VALUES (2, 'Customer');

-- Seed permissions
INSERT OR IGNORE INTO permissions (id, name) VALUES (1, 'manage_products');
INSERT OR IGNORE INTO permissions (id, name) VALUES (2, 'manage_orders');
INSERT OR IGNORE INTO permissions (id, name) VALUES (3, 'manage_users');
INSERT OR IGNORE INTO permissions (id, name) VALUES (4, 'manage_categories');
INSERT OR IGNORE INTO permissions (id, name) VALUES (5, 'view_products');
INSERT OR IGNORE INTO permissions (id, name) VALUES (6, 'place_orders');
INSERT OR IGNORE INTO permissions (id, name) VALUES (7, 'write_reviews');

-- Assign permissions to Admin role
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 1);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 2);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 3);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 4);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 5);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 6);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (1, 7);

-- Assign permissions to Customer role
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 5);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 6);
INSERT OR IGNORE INTO role_permission (role_id, permission_id) VALUES (2, 7);

-- Seed categories
INSERT OR IGNORE INTO categories (id, name, description) VALUES (1, 'Electronics', 'Electronic devices and accessories');
INSERT OR IGNORE INTO categories (id, name, description) VALUES (2, 'Clothing', 'Apparel and fashion items');
INSERT OR IGNORE INTO categories (id, name, description) VALUES (3, 'Home & Garden', 'Home improvement and garden supplies');
INSERT OR IGNORE INTO categories (id, name, description) VALUES (4, 'Sports', 'Sports equipment and outdoor gear');
INSERT OR IGNORE INTO categories (id, name, description) VALUES (5, 'Books', 'Books and educational materials');
