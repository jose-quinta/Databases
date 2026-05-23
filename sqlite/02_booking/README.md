# Booking Database — SQLite

Base de datos relacional para un sistema de reservas hoteleras construida en SQLite, aplicando **1FN, 2FN, 3FN**, atomicidad e integridad referencial.

## Estructura del proyecto

```
booking/
  index.sql              # Entry point
  tables/                # 21 tablas
  triggers/              # 12 triggers
  views/                 # 5 vistas
  transactions/          # 4 transacciones parametrizadas
  UDFs/                  # 3 User Defined Functions
  configurations/        # Seed data
```

## Instalación

```bash
sqlite3 booking.db < index.sql
```

## Modelo de datos

### Diagrama ER

```
roles ──< users ──< customers ──< bookings ──< booking_rooms >── rooms >── room_types >── properties
  │        │                       │              │                    │                      │
  │        │                       │              │                    │                  ┌───┴──────┐
  │        │                       │              │                    │                  │property  │
  │        │                       │              │                    │                  │images    │
  │        │                       │              │                    │                  └──────────┘
  │        │                       │              │                    │               ┌───┴──────┐
  │        │                       │              │                    │               │property  │
  │        │                       │              │                    │               │amenities │
  └──< role_permission >── permissions            │              ┌─────┴──────┐        └──┬──┬─────┘
                                                  │              │  services  │           │  │
                                                  │              └─────┬──────┘     ┌─────┘  └──────┐
                                                  │                    │            │               │
                                                  │              ┌─────┴──────┐ ┌──┴─────┐  ┌─────┴──────┐
                                                  │              │  booking   │ │amenities│  │seasonal   │
                                                  │              │  services  │ └────────┘  │pricing    │
                                                  │              └────────────┘             └────────────┘
                                                  │
                                                  ├──< payments
                                                  ├──< invoices
                                                  ├──< reviews
                                                  └──< booking_promotions >── promotions
```

### Tablas

#### RBAC

| Tabla | Descripción |
|-------|-------------|
| `roles` | Admin, Manager, Receptionist, Customer |
| `permissions` | manage_properties, manage_bookings, manage_payments, view_reports, manage_users, manage_rates, view_own_bookings |
| `role_permission` | M:N role ↔ permission |

#### Personas

| Tabla | Atributos clave |
|-------|-----------------|
| `users` | id, role_id, username, password_hash, email, first_name, last_name, phone, is_active, deleted_at |
| `customers` | id, user_id (UNIQUE), passport, nationality, birth_date, gender, preferred_language, special_needs, total_bookings |

#### Propiedades

| Tabla | Atributos clave |
|-------|-----------------|
| `properties` | id, name, slug (UNIQUE), property_type (hotel/hostel/cabin/resort/apartment/bnb), address, city, country, stars (1–5), currency, check_in_time (15:00), check_out_time (11:00), deleted_at |
| `property_images` | id, property_id (FK), url, is_primary, sort_order |
| `room_types` | id, property_id (FK), name, max_guests, bed_type, base_price, total_rooms |
| `rooms` | id, room_type_id (FK), room_number, floor, is_available, UNIQUE(room_type_id, room_number) |
| `amenities` | id, name, icon (WiFi, Pool, Gym, etc.) |
| `property_amenities` | property_id, amenity_id (M:N) |
| `seasonal_pricing` | id, room_type_id (FK), name, start_date, end_date, price_per_night, min_nights |

#### Reservas

| Tabla | Atributos clave |
|-------|-----------------|
| `bookings` | id, customer_id (FK), property_id (FK), status (pending→confirmed→checked_in→checked_out/cancelled/no_show), check_in, check_out, adults, children, total_nights, subtotal, tax, discount, total, special_requests, source (direct/booking/expedia/airbnb/phone/walk_in) |
| `booking_rooms` | id, booking_id (FK), room_id (FK), check_in, check_out, nights, price_per_night, subtotal |
| `booking_services` | id, booking_id (FK), service_id (FK), quantity, price, subtotal |

#### Servicios extra

| Tabla | Atributos clave |
|-------|-----------------|
| `services` | id, property_id (FK), name, price, charge_type (per_night/per_stay/per_person/per_unit) |

#### Financiero

| Tabla | Atributos clave |
|-------|-----------------|
| `payments` | id, booking_id (FK), amount, method (credit_card/debit_card/cash/transfer/paypal/stripe), status, paid_at |
| `invoices` | id, booking_id (UNIQUE), subtotal, tax, discount, total, paid, balance, status (pending/paid/partially_paid/cancelled/refunded) |

#### Reviews

| Tabla | Atributos clave |
|-------|-----------------|
| `reviews` | id, booking_id (UNIQUE), customer_id, property_id, rating (1–5), staff_rating, cleanliness_rating, comfort_rating, value_rating, is_approved |

#### Promociones

| Tabla | Atributos clave |
|-------|-----------------|
| `promotions` | id, code (UNIQUE), discount_type (percentage/fixed), discount_value, min_amount, min_nights, max_uses, used_count, valid_from, valid_to |
| `booking_promotions` | id, booking_id (FK), promotion_id (FK), discount_amount |

## Triggers

### Actualización de timestamps (8)
- `trg_users_updated_at`, `trg_customers_updated_at`, `trg_properties_updated_at`, `trg_bookings_updated_at`, `trg_invoices_updated_at`, `trg_reviews_updated_at`, `trg_promotions_updated_at`, `trg_room_types_updated_at`

### Triggers de negocio (4)

| Trigger | Evento | Acción |
|---------|--------|--------|
| `trg_validate_booking_dates` | `BEFORE INSERT ON bookings` | Rechaza si check_out ≤ check_in o check_in es pasado |
| `trg_calculate_booking_nights` | `AFTER INSERT ON bookings` | Calcula total_nights = JULIANDAY(check_out) - JULIANDAY(check_in) |
| `trg_prevent_double_booking` | `BEFORE INSERT ON booking_rooms` | Rechaza si la habitación ya está reservada para las fechas |
| `trg_update_invoice_on_payment` | `AFTER INSERT ON payments` | Actualiza paid, balance y status de la factura automáticamente |

## Vistas

| Vista | Propósito |
|-------|-----------|
| `vw_available_rooms` | Habitaciones disponibles (sin booking activo) |
| `vw_booking_details` | Detalle completo: huésped, propiedad, habitaciones, servicios, pagos, factura |
| `vw_customer_history` | Historial de reservas por cliente con reviews |
| `vw_property_occupancy` | % de ocupación e ingresos por propiedad |
| `vw_revenue_summary` | Ingresos mensuales con descuentos y rating promedio |

## Transacciones

| Archivo | Operación |
|---------|-----------|
| `tx_create_booking` | Crea booking + invoice en una transacción |
| `tx_cancel_booking` | Cancela booking y su invoice asociada |
| `tx_process_payment` | Registra pago (el trigger actualiza la factura automáticamente) |
| `tx_check_in_out` | Cambia estado checked_in ↔ checked_out |

## UDFs (User Defined Functions)

| Función | Firma | Descripción |
|---------|-------|-------------|
| `fn_room_available` | `(room_id, start_date, end_date) → INTEGER` | 1 si la habitación está libre en el rango |
| `fn_occupancy_rate` | `(property_id, start_date, end_date) → REAL` | % de ocupación en un período |
| `fn_booking_total` | `(booking_id) → REAL` | Suma de booking_rooms + booking_services |

## Seed data

- **Roles:** Admin, Manager, Receptionist, Customer
- **Permisos:** 7 permisos con asignaciones por rol
- **Amenities:** 10 comodidades (WiFi, Pool, Gym, Restaurant, Parking, Shuttle, AC, Pets, Breakfast, Room Service)
- **Propiedades:** Grand Palace Hotel (5★ NYC), Seaside Resort (4★ Miami), Mountain Cabin Retreat (3★ Aspen)
- **Tipos de habitación:** 7 tipos (Standard, Deluxe, Suite, Ocean View, Beach Bungalow, Rustic Cabin, Family Cabin)
- **Habitaciones:** 36 cuartos con números y pisos
- **Servicios extra:** 6 servicios (desayuno, transfer, spa, jet ski, firewood)
- **Promociones:** WELCOME10 (10%), STAY5 ($100 off), SUMMER20 (20%)
- **Admin demo:** user `admin`
