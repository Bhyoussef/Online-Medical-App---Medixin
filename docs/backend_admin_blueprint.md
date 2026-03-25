# Medixin Production Backend + Admin Blueprint

## 1) UI Analysis (from current Flutter screens)

### Core domains inferred
1. **Auth & Identity**
   - Register, login, forgot password, reset password.
   - Profile editing and settings.
2. **Doctor Discovery**
   - Home highlights, specialist listing, search result, doctor details.
3. **Appointments**
   - Book flow (slot + consultation type + patient details + payment + completion).
   - Upcoming/past appointments with status actions (cancel/reschedule).
4. **Messaging/Calls**
   - Inbox threads, chat messages, audio/video call sessions.
5. **Notifications**
   - User notifications grouped by today/yesterday, mark-all-read.
6. **Payments**
   - Method selection, voucher/coupon application, checkout + confirmation.
7. **Admin Operations**
   - CRUD and moderation for users, doctors, specialties, schedules, appointments,
     payments, vouchers, notifications, support items.

### Screen-by-screen mapping summary
- Onboarding/Splash -> static CMS managed content.
- Registration/Login/Forgot/Reset -> auth APIs.
- Home -> aggregate endpoint (profile, upcoming, featured doctors, services).
- Doctors/Search/Details -> doctor listing + filters + profile endpoint.
- Appointment screens -> slot availability, booking, status transitions.
- Inbox/Chat/Call -> thread list, message list/post, call session records.
- Notification -> list/read status.
- Payment -> method list, apply voucher, checkout intent, confirmation.
- Menu/Settings/Profile -> user account details + preference endpoints.

---

## 2) Database Schema (MySQL 8)

> All tables include `id BIGINT UNSIGNED PK`, `created_at`, `updated_at`.  
> Soft delete enabled on business entities where restore/audit is useful.

### users
- name VARCHAR(120)
- email VARCHAR(190) UNIQUE INDEX
- phone VARCHAR(30) NULL INDEX
- password VARCHAR(255)
- avatar_url VARCHAR(255) NULL
- gender ENUM('male','female','other') NULL
- dob DATE NULL
- status ENUM('active','blocked') DEFAULT 'active' INDEX
- email_verified_at TIMESTAMP NULL
- remember_token VARCHAR(100) NULL
- deleted_at TIMESTAMP NULL

### roles
- slug VARCHAR(40) UNIQUE (admin, patient, doctor, support)
- name VARCHAR(80)

### role_user (pivot)
- user_id FK users.id
- role_id FK roles.id
- UNIQUE(user_id, role_id)

### specialties
- name VARCHAR(120) UNIQUE
- icon VARCHAR(80) NULL
- is_active TINYINT(1) DEFAULT 1
- deleted_at TIMESTAMP NULL

### doctors
- user_id FK users.id UNIQUE
- specialty_id FK specialties.id INDEX
- license_no VARCHAR(80) UNIQUE
- bio TEXT NULL
- experience_years INT DEFAULT 0
- consultation_fee_chat DECIMAL(10,2) DEFAULT 0
- consultation_fee_voice DECIMAL(10,2) DEFAULT 0
- consultation_fee_video DECIMAL(10,2) DEFAULT 0
- city VARCHAR(120) INDEX
- country VARCHAR(120) INDEX
- rating_avg DECIMAL(3,2) DEFAULT 0
- rating_count INT DEFAULT 0
- is_active TINYINT(1) DEFAULT 1 INDEX
- deleted_at TIMESTAMP NULL

### doctor_services
- doctor_id FK doctors.id
- service_name VARCHAR(120)
- price DECIMAL(10,2)

### doctor_availabilities
- doctor_id FK doctors.id INDEX
- weekday TINYINT (1..7) INDEX
- start_time TIME
- end_time TIME
- slot_minutes SMALLINT DEFAULT 30
- is_active TINYINT(1) DEFAULT 1

### appointments
- patient_id FK users.id INDEX
- doctor_id FK doctors.id INDEX
- appointment_no VARCHAR(32) UNIQUE
- type ENUM('hospital','online') INDEX
- consult_mode ENUM('messaging','voice','video') INDEX
- schedule_date DATE INDEX
- schedule_start TIME
- schedule_end TIME
- patient_name VARCHAR(120)
- patient_email VARCHAR(190)
- patient_phone VARCHAR(30)
- patient_gender VARCHAR(20)
- patient_age VARCHAR(40)
- visiting_purpose TEXT NULL
- status ENUM('pending','confirmed','completed','cancelled','rescheduled') INDEX
- payment_status ENUM('unpaid','paid','refunded') INDEX
- total_amount DECIMAL(10,2)
- notes TEXT NULL
- deleted_at TIMESTAMP NULL

### appointment_status_logs
- appointment_id FK appointments.id INDEX
- from_status VARCHAR(30)
- to_status VARCHAR(30)
- actor_id FK users.id
- note TEXT NULL

### payment_methods
- code VARCHAR(40) UNIQUE (apple_pay, paypal, gpay, card)
- label VARCHAR(80)
- is_active TINYINT(1) DEFAULT 1

### vouchers
- code VARCHAR(40) UNIQUE INDEX
- type ENUM('percent','fixed')
- value DECIMAL(10,2)
- max_discount DECIMAL(10,2) NULL
- min_order DECIMAL(10,2) NULL
- usage_limit INT NULL
- used_count INT DEFAULT 0
- starts_at DATETIME
- ends_at DATETIME INDEX
- is_active TINYINT(1) DEFAULT 1

### payments
- appointment_id FK appointments.id UNIQUE
- patient_id FK users.id INDEX
- method_id FK payment_methods.id
- voucher_id FK vouchers.id NULL
- amount DECIMAL(10,2)
- discount_amount DECIMAL(10,2) DEFAULT 0
- final_amount DECIMAL(10,2)
- provider_txn_id VARCHAR(120) NULL INDEX
- status ENUM('initiated','success','failed','refunded') INDEX
- paid_at DATETIME NULL

### notification_templates
- code VARCHAR(80) UNIQUE
- title VARCHAR(150)
- body TEXT
- channel ENUM('in_app','email','sms','push')

### notifications
- user_id FK users.id INDEX
- title VARCHAR(150)
- body TEXT
- type VARCHAR(50) INDEX
- reference_type VARCHAR(80) NULL
- reference_id BIGINT NULL
- is_read TINYINT(1) DEFAULT 0 INDEX
- read_at DATETIME NULL

### conversation_threads
- patient_id FK users.id INDEX
- doctor_id FK doctors.id INDEX
- last_message_at DATETIME INDEX
- is_active TINYINT(1) DEFAULT 1

### messages
- thread_id FK conversation_threads.id INDEX
- sender_id FK users.id INDEX
- type ENUM('text','image','file','system')
- body TEXT NULL
- media_url VARCHAR(255) NULL
- sent_at DATETIME INDEX
- seen_at DATETIME NULL

### call_sessions
- thread_id FK conversation_threads.id INDEX
- initiated_by FK users.id
- call_type ENUM('audio','video')
- started_at DATETIME
- ended_at DATETIME NULL
- duration_seconds INT DEFAULT 0
- status ENUM('ringing','connected','ended','missed')

### favorites
- patient_id FK users.id INDEX
- doctor_id FK doctors.id INDEX
- UNIQUE(patient_id, doctor_id)

### support_tickets
- user_id FK users.id INDEX
- subject VARCHAR(180)
- message TEXT
- status ENUM('open','in_progress','resolved','closed') INDEX
- priority ENUM('low','medium','high') DEFAULT 'medium'

### audit_logs
- actor_id FK users.id NULL
- action VARCHAR(80)
- auditable_type VARCHAR(100)
- auditable_id BIGINT
- meta JSON NULL
- ip_address VARCHAR(45) NULL

---

## 3) Laravel Backend (API)

## Stack
- Laravel 11
- Sanctum (token auth)
- spatie/laravel-permission (roles/permissions)
- Laravel Policy + Gates
- Queue for notifications/messages
- Filament v3 admin panel

## Suggested project structure
- `app/Domain/*` for business logic services
- `app/Models/*` Eloquent models + relations
- `app/Http/Controllers/Api/V1/*`
- `app/Http/Requests/*`
- `app/Http/Resources/*`
- `routes/api_v1.php`

## Key model relationships
- User hasOne Doctor.
- User belongsToMany Role.
- Doctor belongsTo Specialty.
- Doctor hasMany Appointment.
- Patient(User) hasMany Appointment.
- Appointment hasOne Payment.
- User hasMany Notification.
- Thread belongsTo patient(User) and doctor(Doctor).
- Thread hasMany Message.

## Controller list
- AuthController
- ProfileController
- OnboardingController (CMS-managed slides)
- HomeController
- DoctorController
- AppointmentController
- PaymentController
- NotificationController
- InboxController
- CallSessionController
- SettingsController

## Validation examples (FormRequest)
- `StoreAppointmentRequest`
  - doctor_id exists
  - schedule_date date|after_or_equal:today
  - consult_mode in:messaging,voice,video
- `ApplyVoucherRequest`
  - code required|string|exists:vouchers,code
- `SendMessageRequest`
  - thread_id exists
  - type in:text,image,file
  - body required_if:type,text

---

## 4) API Contract (Flutter optimized)

### Auth
- `POST /api/v1/auth/register`
- `POST /api/v1/auth/login`
- `POST /api/v1/auth/forgot-password`
- `POST /api/v1/auth/reset-password`
- `POST /api/v1/auth/logout`

`POST /auth/login` request:
```json
{ "email": "rafi@mail.com", "password": "secret123" }
```
Response 200:
```json
{
  "token": "plain_text_token",
  "user": { "id": 12, "name": "Rafi Islam Apon", "email": "rafi@mail.com" }
}
```

### Home / Doctors
- `GET /api/v1/home`
- `GET /api/v1/doctors?search=&specialty_id=&city=&sort=top_rated&page=1`
- `GET /api/v1/doctors/{id}`
- `POST /api/v1/doctors/{id}/favorite`
- `DELETE /api/v1/doctors/{id}/favorite`

### Appointments
- `GET /api/v1/appointments?tab=upcoming|past&page=1`
- `POST /api/v1/appointments`
- `GET /api/v1/appointments/{id}`
- `PATCH /api/v1/appointments/{id}/cancel`
- `PATCH /api/v1/appointments/{id}/reschedule`

Create appointment request:
```json
{
  "doctor_id": 9,
  "type": "online",
  "consult_mode": "video",
  "schedule_date": "2026-03-28",
  "schedule_start": "11:00",
  "schedule_end": "11:30",
  "patient_name": "Mizanur Rahman Abrar",
  "patient_email": "mizanur@gmail.com",
  "patient_phone": "+8801668449222",
  "patient_gender": "male",
  "patient_age": "21 Years, 250 Days",
  "visiting_purpose": "Backbone pain"
}
```

### Payment
- `GET /api/v1/payments/methods`
- `POST /api/v1/payments/voucher/preview`
- `POST /api/v1/payments/checkout`
- `POST /api/v1/payments/{payment}/confirm`

Checkout response:
```json
{
  "payment_id": 112,
  "appointment_id": 440,
  "amount": "20.00",
  "discount_amount": "5.00",
  "final_amount": "15.00",
  "status": "initiated"
}
```

### Inbox / Calls
- `GET /api/v1/inbox/threads`
- `GET /api/v1/inbox/threads/{id}/messages?page=1`
- `POST /api/v1/inbox/threads/{id}/messages`
- `POST /api/v1/inbox/threads/{id}/calls`
- `PATCH /api/v1/calls/{id}/end`

### Notifications
- `GET /api/v1/notifications?page=1`
- `PATCH /api/v1/notifications/{id}/read`
- `PATCH /api/v1/notifications/read-all`
- `DELETE /api/v1/notifications/clear`

### Profile/Settings
- `GET /api/v1/profile`
- `PUT /api/v1/profile`
- `GET /api/v1/settings`
- `PUT /api/v1/settings`

### Standard response wrapper
```json
{
  "data": {},
  "meta": { "pagination": { "page": 1, "per_page": 15, "total": 120 } },
  "message": "OK"
}
```

---

## 5) Admin Panel (Filament)

## Resources
1. UsersResource
2. RolesResource
3. DoctorsResource
4. SpecialtiesResource
5. AvailabilitiesResource
6. AppointmentsResource
7. PaymentsResource
8. VouchersResource
9. NotificationsResource
10. ThreadsResource
11. MessagesResource
12. SupportTicketsResource

## Per-resource basics
- Table: sortable columns, global search, status filters, date range filters.
- Forms: strict validation, select relations, image upload for avatars.
- Actions: Create/Update/Delete, bulk actions, activate/deactivate, export CSV.

## Dashboard widgets
- KPI cards: total users, active doctors, today appointments, monthly revenue.
- Charts: appointments/day, revenue/month, top specialties, cancellation rate.
- Queue monitor + failed jobs widget.

## UI style
- Use app primary `#2F6FDE` and neutral light cards.
- Rounded cards, compact spacing, high-contrast table states.

---

## 6) Flutter Integration Data Flow

For every feature:

`Cubit -> UseCase -> Repository (data layer) -> RemoteDataSource (Dio) -> Laravel API -> MySQL`

Mapping examples:
- HomePage load -> `GET /home`
- Doctors list/search -> `GET /doctors`
- Book button -> `POST /appointments`
- Checkout -> `POST /payments/checkout`
- Inbox open -> `GET /inbox/threads`
- Notification screen -> `GET /notifications`
- Profile save -> `PUT /profile`

Error handling:
- Backend returns normalized error:
```json
{ "message": "Validation failed", "errors": { "email": ["Email already taken"] } }
```
- Flutter maps this in repository to failure objects consumed by Cubits.

---

## 7) Seeders + Sample data

## Seeders list
- RolesSeeder
- AdminUserSeeder
- SpecialtiesSeeder
- DoctorsSeeder
- AvailabilitiesSeeder
- PatientsSeeder
- AppointmentsSeeder
- PaymentsSeeder
- NotificationsSeeder
- ThreadsAndMessagesSeeder

## Example seeder payload snippet
```php
Doctor::factory()->count(20)->create();
Appointment::factory()->count(100)->create();
Notification::factory()->count(200)->create();
```

## Example notification API sample
```json
{
  "data": [
    {
      "id": 1,
      "title": "Security",
      "body": "Hey Rafi, your password was successfully reset",
      "type": "lock",
      "is_read": false,
      "created_at": "2026-03-25T10:00:00Z"
    }
  ]
}
```

---

## 8) Security & production hardening checklist

- Sanctum tokens + device/session revoke.
- Role-based middleware (`role:admin`, `role:patient`, `role:doctor`).
- Rate-limit auth and messaging endpoints.
- Enforce ownership policies (patient can only see own appointments/threads).
- Audit log for admin writes.
- Queued notifications and webhook-safe payment callbacks.
- DB indexes on search/filter fields (`status`, `schedule_date`, `doctor_id`, `user_id`).
- S3/object storage for media uploads.
- Observability: Sentry + Laravel Telescope (non-production gated).
