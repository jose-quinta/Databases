# Ecommerce Database — SQLite

Base de datos relacional para un sistema de comercio electrónico construida en SQLite.

## Estructura del proyecto

```
ecommerce/
  index.sql              # Entry point: ejecuta todo en orden
  tables/                # Definición de tablas (17)
  triggers/              # Triggers de negocio y timestamps (12)
  views/                 # Vistas de consulta (4)
  transactions/          # Transacciones parametrizadas (5)
  UDFs/                  # User Defined Functions — SQLite 3.44+ (4)
  procedures/            # Documentación de procedimientos (2)
  configurations/        # Seed data inicial (1)
```

## Requisitos

- SQLite 3.44+ (para soporte completo de `CREATE FUNCTION`)
- SQLite 3.x para el resto del schema

## Instalación

```bash
sqlite3 ecommerce.db < index.sql
```

## Modelo de datos

### Tablas

#### roles
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(50) | NOT NULL |

#### permissions
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(50) | NOT NULL |

#### role_permission
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| role_id | INTEGER | PK, FK → roles(id) ON DELETE CASCADE |
| permission_id | INTEGER | PK, FK → permissions(id) ON DELETE CASCADE |

#### categories
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(50) | NOT NULL |
| description | VARCHAR(255) | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

#### users
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| role_id | INTEGER | NOT NULL, FK → roles(id) |
| name | VARCHAR(100) | NOT NULL |
| email | VARCHAR(100) | NOT NULL, UNIQUE |
| password_hash | VARCHAR(255) | NOT NULL |
| phone | VARCHAR(20) | |
| avatar | VARCHAR(255) | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

#### customers
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| user_id | INTEGER | NOT NULL, UNIQUE, FK → users(id) ON DELETE CASCADE |
| birth_date | DATE | |
| gender | VARCHAR(10) | |
| newsletter | BOOLEAN | DEFAULT FALSE |
| total_purchases | DECIMAL(12,2) | DEFAULT 0.00 |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### addresses
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| user_id | INTEGER | NOT NULL, FK → users(id) ON DELETE CASCADE |
| label | VARCHAR(50) | DEFAULT 'Home' |
| street | VARCHAR(255) | NOT NULL |
| street2 | VARCHAR(255) | |
| city | VARCHAR(100) | NOT NULL |
| state | VARCHAR(100) | NOT NULL |
| zip_code | VARCHAR(20) | NOT NULL |
| country | VARCHAR(100) | NOT NULL, DEFAULT 'Mexico' |
| is_default | BOOLEAN | DEFAULT FALSE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### products
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| category_id | INTEGER | NOT NULL, FK → categories(id) |
| name | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| price | DECIMAL(10,2) | NOT NULL |
| stock | INTEGER | NOT NULL, DEFAULT 0 |
| sku | VARCHAR(50) | UNIQUE |
| weight | DECIMAL(8,2) | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

#### product_images
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| product_id | INTEGER | NOT NULL, FK → products(id) ON DELETE CASCADE |
| url | VARCHAR(255) | NOT NULL |
| alt_text | VARCHAR(150) | |
| is_primary | BOOLEAN | DEFAULT FALSE |
| sort_order | INTEGER | DEFAULT 0 |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### carts
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| user_id | INTEGER | NOT NULL, UNIQUE, FK → users(id) ON DELETE CASCADE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### cart_items
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| cart_id | INTEGER | NOT NULL, FK → carts(id) ON DELETE CASCADE |
| product_id | INTEGER | NOT NULL, FK → products(id) |
| quantity | INTEGER | NOT NULL, DEFAULT 1 |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### orders
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| user_id | INTEGER | NOT NULL, FK → users(id) |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'pending' |
| subtotal | DECIMAL(12,2) | NOT NULL |
| shipping_cost | DECIMAL(10,2) | DEFAULT 0.00 |
| tax | DECIMAL(10,2) | DEFAULT 0.00 |
| discount | DECIMAL(10,2) | DEFAULT 0.00 |
| total | DECIMAL(12,2) | NOT NULL |
| shipping_address_id | INTEGER | FK → addresses(id) |
| billing_address_id | INTEGER | FK → addresses(id) |
| coupon_id | INTEGER | FK → coupons(id) |
| notes | TEXT | |
| ordered_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| paid_at | TIMESTAMP | |
| shipped_at | TIMESTAMP | |
| delivered_at | TIMESTAMP | |
| cancelled_at | TIMESTAMP | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

**Estados del pedido:** `pending` → `paid` → `shipped` → `delivered` | `cancelled` | `refunded`

#### order_items
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| order_id | INTEGER | NOT NULL, FK → orders(id) ON DELETE CASCADE |
| product_id | INTEGER | NOT NULL, FK → products(id) |
| product_name | VARCHAR(150) | NOT NULL (congelado al momento de la compra) |
| quantity | INTEGER | NOT NULL |
| unit_price | DECIMAL(10,2) | NOT NULL (congelado al momento de la compra) |
| subtotal | DECIMAL(12,2) | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### payments
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| order_id | INTEGER | NOT NULL, FK → orders(id) |
| method | VARCHAR(50) | NOT NULL |
| transaction_id | VARCHAR(100) | |
| amount | DECIMAL(12,2) | NOT NULL |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'pending' |
| paid_at | TIMESTAMP | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### reviews
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| product_id | INTEGER | NOT NULL, FK → products(id) ON DELETE CASCADE |
| user_id | INTEGER | NOT NULL, FK → users(id) |
| rating | INTEGER | NOT NULL, CHECK(1–5) |
| title | VARCHAR(150) | |
| comment | TEXT | |
| is_approved | BOOLEAN | DEFAULT FALSE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### coupons
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| code | VARCHAR(50) | NOT NULL, UNIQUE |
| description | VARCHAR(255) | |
| discount_type | VARCHAR(10) | NOT NULL, CHECK('percentage', 'fixed') |
| discount_value | DECIMAL(10,2) | NOT NULL |
| min_amount | DECIMAL(10,2) | DEFAULT 0.00 |
| max_uses | INTEGER | |
| used_count | INTEGER | DEFAULT 0 |
| is_active | BOOLEAN | DEFAULT TRUE |
| valid_from | TIMESTAMP | |
| valid_to | TIMESTAMP | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### coupon_usages
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| coupon_id | INTEGER | NOT NULL, FK → coupons(id) |
| order_id | INTEGER | NOT NULL, FK → orders(id) |
| user_id | INTEGER | NOT NULL, FK → users(id) |
| used_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### Diagrama de relaciones (ER)

```
roles ──< users ──< customers
  │                 │
  │                 └── addresses
  │
  └──< role_permission >── permissions

categories ──< products ──< product_images
                │
                ├──< cart_items >── carts ──< users
                │
                ├──< order_items >── orders ──< users
                │                     │
                │                     ├── addresses (shipping)
                │                     ├── addresses (billing)
                │                     ├── coupons
                │                     └──< payments
                │
                └──< reviews ──< users

coupons ──< coupon_usages >── orders
                                │
                                └──< users
```

## Triggers

### Actualización de timestamps (10)
Cada tabla con `updated_at` tiene un trigger `AFTER UPDATE` que sincroniza la columna automáticamente:

- `trg_categories_updated_at`
- `trg_users_updated_at`
- `trg_products_updated_at`
- `trg_orders_updated_at`
- `trg_customers_updated_at`
- `trg_addresses_updated_at`
- `trg_carts_updated_at`
- `trg_reviews_updated_at`
- `trg_payments_updated_at`
- `trg_coupons_updated_at`

### Triggers de negocio (2)

| Trigger | Evento | Acción |
|---------|--------|--------|
| `trg_decrease_stock_on_order` | `AFTER INSERT ON order_items` | Descuenta `stock` en `products` |
| `trg_restore_stock_on_cancel` | `AFTER UPDATE OF status ON orders` | Restaura `stock` cuando la orden se cancela o reembolsa |

## Vistas

| Vista | Propósito |
|-------|-----------|
| `vw_product_catalog` | Catálogo completo con precio, categoría, imagen principal, rating promedio y conteo de reseñas |
| `vw_order_summary` | Resumen de órdenes con datos del usuario, método de pago, total de items |
| `vw_user_cart` | Carrito por usuario con detalle de producto, precio unitario, subtotal e imagen |
| `vw_top_sellers` | Productos más vendidos con unidades, ingresos totales y rating promedio |

## Transacciones

Archivos SQL parametrizados que encapsulan operaciones de negocio completas en bloques `BEGIN/COMMIT`.

| Archivo | Operación |
|---------|-----------|
| `tx_register_user.sql` | Crea usuario (role customer) + perfil `customers` + carrito vacío |
| `tx_add_to_cart.sql` | Agrega producto al carrito o incrementa cantidad si ya existe |
| `tx_place_order.sql` | Crea orden desde carrito: calcula subtotal, migra items, limpia carrito, actualiza uso de cupón |
| `tx_process_payment.sql` | Registra pago y cambia estado de orden a `paid` |
| `tx_cancel_order.sql` | Cambia orden a `cancelled` y restaura el stock |

## UDFs (User Defined Functions)

Requiere SQLite 3.44+ con soporte de `CREATE FUNCTION`. Cada archivo incluye la expresión SQL equivalente para versiones anteriores.

| Función | Firma | Descripción |
|---------|-------|-------------|
| `fn_calculate_discount` | `(price REAL, discount_type TEXT, discount_value REAL) → REAL` | Calcula descuento porcentual o fijo |
| `fn_calculate_tax` | `(amount REAL, tax_rate REAL) → REAL` | Calcula impuesto redondeado a 2 decimales |
| `fn_order_subtotal` | `(order_id INTEGER) → REAL` | Suma los subtotales de `order_items` para una orden |
| `fn_is_coupon_valid` | `(coupon_id INTEGER) → INTEGER` | Valida fechas, usos máximos y estado activo |

## Seed data

`configurations/seed_data.sql` inserta datos iniciales:

- **Roles:** Admin (1), Customer (2)
- **Permisos:** manage_products, manage_orders, manage_users, manage_categories, view_products, place_orders, write_reviews
- **Role-permission:** Admin obtiene todos, Customer solo view_products, place_orders, write_reviews
- **Categorías:** Electronics, Clothing, Home & Garden, Sports, Books

## Procedimientos (referencia)

Los archivos en `procedures/` son plantillas comentadas para ser ejecutadas desde la aplicación:

- `sp_place_order.sql` — Lógica de creación de orden (reemplazada por `tx_place_order`)
- `sp_apply_coupon.sql` — Validación de cupón con `CASE`

## Compatibilidad

| Característica | SQLite mínimo |
|----------------|---------------|
| Tablas, vistas, triggers | 3.x |
| `CREATE FUNCTION` | 3.44+ |
| `ON CONFLICT DO NOTHING` | 3.24+ |
| `PRAGMA foreign_keys` | 3.x |

Para cargar todo el schema:

```bash
sqlite3 ecommerce.db < index.sql
```
