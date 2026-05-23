# Inventory Management Database &mdash; SQLite

Base de datos relacional para un sistema de gesti&oacute;n de inventario, almacenes y cadena de suministro, construida en SQLite.

## Estructura del proyecto

```
inventary_management/
  index.sql              # Entry point: ejecuta todo en orden
  tables/                # Definici&oacute;n de tablas (24)
  triggers/              # Triggers de negocio y timestamps (10)
  views/                 # Vistas de consulta (5)
  transactions/          # Transacciones parametrizadas (5)
  UDFs/                  # User Defined Functions &mdash; SQLite 3.44+ (4)
  configurations/        # Seed data inicial (1)
```

## Requisitos

- SQLite 3.44+ (para soporte completo de `CREATE FUNCTION`)
- SQLite 3.x para el resto del schema

## Instalaci&oacute;n

```bash
sqlite3 inventory.db < index.sql
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
| role_id | INTEGER | PK, FK &rarr; roles(id) ON DELETE CASCADE |
| permission_id | INTEGER | PK, FK &rarr; permissions(id) ON DELETE CASCADE |

#### categories
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| parent_id | INTEGER | FK &rarr; categories(id) |
| name | VARCHAR(100) | NOT NULL |
| slug | VARCHAR(100) | NOT NULL, UNIQUE |
| description | TEXT | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### brands
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(100) | NOT NULL |
| description | TEXT | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### units_of_measure
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| name | VARCHAR(50) | NOT NULL |
| abbreviation | VARCHAR(10) | NOT NULL |
| type | VARCHAR(20) | NOT NULL, CHECK(unit, weight, volume, length, area) |
| is_active | BOOLEAN | DEFAULT TRUE |

#### suppliers
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| code | VARCHAR(20) | NOT NULL, UNIQUE |
| company_name | VARCHAR(150) | NOT NULL |
| contact_name | VARCHAR(100) | |
| email | VARCHAR(100) | |
| phone | VARCHAR(20) | |
| address | TEXT | |
| city | VARCHAR(100) | |
| country | VARCHAR(100) | DEFAULT 'Mexico' |
| tax_id | VARCHAR(50) | |
| payment_terms | VARCHAR(50) | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

#### products
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| category_id | INTEGER | NOT NULL, FK &rarr; categories(id) |
| brand_id | INTEGER | FK &rarr; brands(id) |
| uom_id | INTEGER | NOT NULL, FK &rarr; units_of_measure(id) |
| sku | VARCHAR(50) | NOT NULL, UNIQUE |
| barcode | VARCHAR(100) | |
| name | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| purchase_price | DECIMAL(12,4) | DEFAULT 0.0000 |
| selling_price | DECIMAL(12,4) | DEFAULT 0.0000 |
| weight | DECIMAL(10,4) | |
| volume | DECIMAL(10,4) | |
| min_stock | DECIMAL(12,4) | DEFAULT 0 |
| max_stock | DECIMAL(12,4) | DEFAULT 0 |
| reorder_point | DECIMAL(12,4) | DEFAULT 0 |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| deleted_at | TIMESTAMP | Soft delete |

#### product_variants
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| product_id | INTEGER | NOT NULL, FK &rarr; products(id) ON DELETE CASCADE |
| name | VARCHAR(100) | NOT NULL |
| sku_suffix | VARCHAR(30) | |
| barcode | VARCHAR(100) | |
| purchase_price | DECIMAL(12,4) | |
| selling_price | DECIMAL(12,4) | |
| weight | DECIMAL(10,4) | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| UNIQUE | | (product_id, name) |

#### product_images
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| product_id | INTEGER | NOT NULL, FK &rarr; products(id) ON DELETE CASCADE |
| url | VARCHAR(255) | NOT NULL |
| alt_text | VARCHAR(150) | |
| is_primary | BOOLEAN | DEFAULT FALSE |
| sort_order | INTEGER | DEFAULT 0 |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### product_suppliers
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| product_id | INTEGER | PK, FK &rarr; products(id) ON DELETE CASCADE |
| supplier_id | INTEGER | PK, FK &rarr; suppliers(id) |
| supplier_sku | VARCHAR(50) | |
| price | DECIMAL(12,4) | NOT NULL |
| lead_time_days | INTEGER | DEFAULT 1 |
| min_order_qty | DECIMAL(12,4) | DEFAULT 1 |
| is_preferred | BOOLEAN | DEFAULT FALSE |

#### warehouses
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| code | VARCHAR(20) | NOT NULL, UNIQUE |
| name | VARCHAR(150) | NOT NULL |
| address | TEXT | |
| city | VARCHAR(100) | |
| country | VARCHAR(100) | DEFAULT 'Mexico' |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### warehouse_zones
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| warehouse_id | INTEGER | NOT NULL, FK &rarr; warehouses(id) ON DELETE CASCADE |
| code | VARCHAR(20) | NOT NULL |
| name | VARCHAR(100) | NOT NULL |
| zone_type | VARCHAR(30) | NOT NULL, CHECK(storage, picking, receiving, returns, quarantine, shipping) |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| UNIQUE | | (warehouse_id, code) |

#### warehouse_bins
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| zone_id | INTEGER | NOT NULL, FK &rarr; warehouse_zones(id) ON DELETE CASCADE |
| code | VARCHAR(30) | NOT NULL |
| aisle | VARCHAR(20) | |
| rack | VARCHAR(20) | |
| level | VARCHAR(10) | |
| max_weight | DECIMAL(10,2) | |
| max_volume | DECIMAL(10,2) | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| UNIQUE | | (zone_id, code) |

#### inventory_stock
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| product_id | INTEGER | NOT NULL, FK &rarr; products(id) |
| variant_id | INTEGER | FK &rarr; product_variants(id) |
| bin_id | INTEGER | NOT NULL, FK &rarr; warehouse_bins(id) |
| quantity | DECIMAL(12,4) | NOT NULL, DEFAULT 0 |
| lot_number | VARCHAR(50) | |
| expiry_date | DATE | |
| last_count_date | TIMESTAMP | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| UNIQUE | | (product_id, variant_id, bin_id, lot_number) |

#### stock_movements
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| product_id | INTEGER | NOT NULL, FK &rarr; products(id) |
| variant_id | INTEGER | FK &rarr; product_variants(id) |
| from_bin_id | INTEGER | FK &rarr; warehouse_bins(id) |
| to_bin_id | INTEGER | FK &rarr; warehouse_bins(id) |
| quantity | DECIMAL(12,4) | NOT NULL |
| movement_type | VARCHAR(30) | NOT NULL, CHECK(purchase_receipt, sales_issuance, transfer_out, transfer_in, adjustment_add, adjustment_subtract, return, count_correction) |
| reference_type | VARCHAR(30) | |
| reference_id | INTEGER | |
| lot_number | VARCHAR(50) | |
| notes | TEXT | |
| created_by | INTEGER | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### purchase_orders
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| supplier_id | INTEGER | NOT NULL, FK &rarr; suppliers(id) |
| warehouse_id | INTEGER | NOT NULL, FK &rarr; warehouses(id) |
| po_number | VARCHAR(50) | NOT NULL, UNIQUE |
| order_date | DATE | NOT NULL, DEFAULT (DATE('now')) |
| expected_date | DATE | |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'draft', CHECK(draft, sent, confirmed, received, cancelled) |
| subtotal | DECIMAL(14,2) | DEFAULT 0.00 |
| tax | DECIMAL(14,2) | DEFAULT 0.00 |
| total | DECIMAL(14,2) | DEFAULT 0.00 |
| notes | TEXT | |
| created_by | INTEGER | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### purchase_order_items
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| po_id | INTEGER | NOT NULL, FK &rarr; purchase_orders(id) ON DELETE CASCADE |
| product_id | INTEGER | NOT NULL, FK &rarr; products(id) |
| variant_id | INTEGER | FK &rarr; product_variants(id) |
| quantity_ordered | DECIMAL(12,4) | NOT NULL |
| quantity_received | DECIMAL(12,4) | DEFAULT 0 |
| unit_price | DECIMAL(12,4) | NOT NULL |
| subtotal | DECIMAL(14,2) | NOT NULL |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### goods_receipts
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| po_id | INTEGER | NOT NULL, FK &rarr; purchase_orders(id) |
| receipt_date | DATE | NOT NULL, DEFAULT (DATE('now')) |
| reference_number | VARCHAR(50) | |
| notes | TEXT | |
| created_by | INTEGER | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### goods_receipt_items
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| receipt_id | INTEGER | NOT NULL, FK &rarr; goods_receipts(id) ON DELETE CASCADE |
| po_item_id | INTEGER | NOT NULL, FK &rarr; purchase_order_items(id) |
| product_id | INTEGER | NOT NULL, FK &rarr; products(id) |
| variant_id | INTEGER | FK &rarr; product_variants(id) |
| quantity_received | DECIMAL(12,4) | NOT NULL |
| bin_id | INTEGER | NOT NULL, FK &rarr; warehouse_bins(id) |
| lot_number | VARCHAR(50) | |
| expiry_date | DATE | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### sales_orders
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| order_number | VARCHAR(50) | NOT NULL, UNIQUE |
| customer_name | VARCHAR(150) | |
| customer_email | VARCHAR(100) | |
| order_date | DATE | NOT NULL, DEFAULT (DATE('now')) |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'draft', CHECK(draft, confirmed, picking, shipped, delivered, cancelled) |
| warehouse_id | INTEGER | NOT NULL, FK &rarr; warehouses(id) |
| subtotal | DECIMAL(14,2) | DEFAULT 0.00 |
| tax | DECIMAL(14,2) | DEFAULT 0.00 |
| total | DECIMAL(14,2) | DEFAULT 0.00 |
| notes | TEXT | |
| created_by | INTEGER | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### sales_order_items
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| so_id | INTEGER | NOT NULL, FK &rarr; sales_orders(id) ON DELETE CASCADE |
| product_id | INTEGER | NOT NULL, FK &rarr; products(id) |
| variant_id | INTEGER | FK &rarr; product_variants(id) |
| quantity | DECIMAL(12,4) | NOT NULL |
| unit_price | DECIMAL(12,4) | NOT NULL |
| subtotal | DECIMAL(14,2) | NOT NULL |
| bin_id | INTEGER | FK &rarr; warehouse_bins(id) |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### inventory_counts
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| warehouse_id | INTEGER | NOT NULL, FK &rarr; warehouses(id) |
| zone_id | INTEGER | FK &rarr; warehouse_zones(id) |
| count_date | DATE | NOT NULL, DEFAULT (DATE('now')) |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'draft', CHECK(draft, in_progress, completed, approved) |
| notes | TEXT | |
| created_by | INTEGER | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| updated_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

#### inventory_count_items
| Columna | Tipo | Restricciones |
|---------|------|---------------|
| id | INTEGER | PK, AUTOINCREMENT |
| count_id | INTEGER | NOT NULL, FK &rarr; inventory_counts(id) ON DELETE CASCADE |
| product_id | INTEGER | NOT NULL, FK &rarr; products(id) |
| variant_id | INTEGER | FK &rarr; product_variants(id) |
| bin_id | INTEGER | NOT NULL, FK &rarr; warehouse_bins(id) |
| expected_quantity | DECIMAL(12,4) | NOT NULL |
| counted_quantity | DECIMAL(12,4) | NOT NULL, DEFAULT 0 |
| discrepancy | DECIMAL(12,4) | GENERATED ALWAYS AS (counted - expected) STORED |
| notes | TEXT | |
| created_at | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

### Diagrama de relaciones (ER)

```
roles ──< role_permission >── permissions

categories ──< categories (parent_id, self-ref)
    │
    └──< products ──< product_variants
            │            │
            │            ├──< product_images
            │            └──< inventory_stock
            │
            ├──< product_suppliers >── suppliers
            │
            ├──< purchase_order_items >── purchase_orders ──< suppliers
            │                                       │
            │                                       └──< warehouses
            │                              goods_receipts ──< goods_receipt_items
            │
            ├──< sales_order_items >── sales_orders ──< warehouses
            │
            └──< inventory_count_items >── inventory_counts ──< warehouses
                                            │
                                            └──< warehouse_zones

warehouses ──< warehouse_zones ──< warehouse_bins ──< inventory_stock
                                                       │
                                                       └──< stock_movements

brands ──< products
units_of_measure ──< products
```

## Triggers

### Actualizaci&oacute;n de timestamps (7)

Cada tabla con `updated_at` tiene un trigger `AFTER UPDATE` que sincroniza la columna autom&aacute;ticamente:

- `trg_categories_updated_at`
- `trg_products_updated_at`
- `trg_suppliers_updated_at`
- `trg_inventory_stock_updated_at`
- `trg_purchase_orders_updated_at`
- `trg_sales_orders_updated_at`
- `trg_inventory_counts_updated_at`

### Triggers de negocio (3)

| Trigger | Evento | Acci&oacute;n |
|---------|--------|---------------|
| `trg_update_stock_on_receipt` | `AFTER INSERT ON goods_receipt_items` | Inserta o actualiza `inventory_stock`, crea movimiento `purchase_receipt`, actualiza `quantity_received` en `purchase_order_items` |
| `trg_update_stock_on_sale` | `AFTER INSERT ON sales_order_items` | Descuenta cantidad de `inventory_stock`, crea movimiento `sales_issuance` |
| `trg_apply_count_correction` | `AFTER UPDATE ON inventory_counts` WHEN status = 'approved' | Crea movimientos de ajuste por discrepancia y actualiza `inventory_stock` con valores contados |

## Vistas

| Vista | Prop&oacute;sito |
|-------|------------------|
| `vw_stock_by_warehouse` | Stock total por producto y variante por almac&eacute;n, con estado (ok/low/reorder) |
| `vw_inventory_movements` | Hist&oacute;rico completo de movimientos de inventario con origen/destino |
| `vw_purchase_order_status` | Estado de &oacute;rdenes de compra con % de recepci&oacute;n |
| `vw_low_stock_alert` | Productos por debajo del punto de reorden, con d&eacute;ficit calculado |
| `vw_count_discrepancies` | Discrepancias de conteo f&iacute;sico con valores esperados vs reales |

## Transacciones

Archivos SQL parametrizados que encapsulan operaciones de negocio completas en bloques `BEGIN/COMMIT`.

| Archivo | Operaci&oacute;n |
|---------|------------------|
| `tx_receive_goods.sql` | Recibe mercanc&iacute;a contra orden de compra: crea `goods_receipts`, actualiza estado de PO |
| `tx_create_po.sql` | Crea orden de compra con datos de proveedor, almac&eacute;n y fechas |
| `tx_create_so.sql` | Crea orden de venta con datos de cliente y almac&eacute;n |
| `tx_adjust_stock.sql` | Ajusta stock de un producto en una ubicaci&oacute;n (suma o resta con control de saldo m&iacute;nimo 0) |
| `tx_transfer_stock.sql` | Transfiere stock entre ubicaciones con registro de movimiento |

## UDFs (User Defined Functions)

Requiere SQLite 3.44+ con soporte de `CREATE FUNCTION`.

| Funci&oacute;n | Firma | Descripci&oacute;n |
|------|-------|-------------|
| `fn_stock_on_hand` | `(product_id INTEGER, warehouse_id INTEGER) &rarr; REAL` | Stock total de un producto en un almac&eacute;n |
| `fn_inventory_value` | `(warehouse_id INTEGER) &rarr; REAL` | Valor total del inventario (cantidad * precio de compra) por almac&eacute;n |
| `fn_products_below_reorder` | `(warehouse_id INTEGER) &rarr; INTEGER` | Cantidad de productos debajo de su punto de reorden |
| `fn_bin_capacity_pct` | `(bin_id INTEGER) &rarr; REAL` | Porcentaje de capacidad usado en una ubicaci&oacute;n (volumen o peso) |

## Seed data

`configurations/seed_data.sql` inserta datos iniciales:

- **Roles:** Admin, Warehouse Manager, Operator (3)
- **Permisos:** 12 permisos de gesti&oacute;n (manage_products, manage_purchase_orders, manage_sales_orders, manage_inventory, manage_warehouses, manage_suppliers, view_reports, receive_goods, pick_orders, count_inventory, adjust_stock, view_products)
- **Role-permission:** Admin obtiene todos; Warehouse Manager obtiene gesti&oacute;n+operativos; Operator solo receive_goods, pick_orders, count_inventory, view_products
- **Categor&iacute;as:** 11 categor&iacute;as con jerarqu&iacute;a (Electronics > Computers, Computer Accessories; Clothing > Footwear; Home & Garden > Tools, Cleaning Supplies; Food & Beverage; Packaging; Health & Safety)
- **Marcas (brands):** TechPro, HomeStyle, SafeGuard, PackRight, FreshChoice
- **Unidades de medida:** Piece, Kilogram, Liter, Meter, Square Meter, Box, Pack, Gram
- **Proveedores:** 5 proveedores en distintas ciudades
- **Almacenes:** 3 almacenes (Monterrey, Guadalajara, CDMX)
- **Zonas/Bins:** 8 zonas, 10 ubicaciones
- **Productos:** 12 productos con precios de compra/venta, stock m&iacute;nimo y punto de reorden
- **Variantes:** 5 variantes para productos con tallas/tostados
- **Stock inicial:** 15 registros de stock en almac&eacute;n Monterrey con n&uacute;meros de lote
- &Oacute;rdenes de compra: 3 POs (1 recibida, 1 enviada, 1 confirmada)
- &Oacute;rdenes de venta: 2 SOs (1 enviada, 1 confirmada)

## Compatibilidad

| Caracter&iacute;stica | SQLite m&iacute;nimo |
|---------------------|----------------------|
| Tablas, vistas, triggers | 3.x |
| `CREATE FUNCTION` | 3.44+ |
| `GENERATED ALWAYS AS ... STORED` | 3.31+ |
| `ON CONFLICT DO NOTHING / DO UPDATE` | 3.24+ |
| `PRAGMA foreign_keys` | 3.x |

Para cargar todo el schema:

```bash
sqlite3 inventory.db < index.sql
```
