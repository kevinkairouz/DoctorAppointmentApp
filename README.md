# Doctor Calendar App

A SwiftUI-based medical appointment scheduling application with secure authentication and patient management, powered by Supabase backend.

## Features

* Multiple authentication methods (Email/Password, Google Sign-In, Apple Sign-In)
* Patient profile management
* Appointment booking with date selection
* Patient health information collection (height, weight, symptoms)
* Feedback and suggestion system
* User settings and account management

### SwiftUI Components:
* `NavigationStack` - Modern navigation hierarchy
* `TabView` - Main app navigation between Calendar and Settings
* `DatePicker` - Appointment date selection with graphical style
* `TextField/SecureField` - User input for credentials and patient data
* `ScrollView` - Scrollable appointment form
* `LinearGradient` - Animated purple-white gradient backgrounds
* `fullScreenCover` - Modal presentations for multi-step flows
* Custom button styling with rounded corners and opacity effects

### State Management:
* `@State` - Local view state for form inputs and UI toggles
* `@Binding` - Two-way data binding for appointment dates
* `@StateObject` - Observable object lifecycle management
* `@ObservedObject` - Shared state observation

### Architecture:
* **MVVM Foundation** - Separated Models, Services, and Views
* **Models** - `Patient`, `Appointment`, `Suggestion` data structures
* **Services** - `Authentication` and `DatabaseManager` classes
* **Views** - Seven view components for different app flows

### Backend & Database:
* **Supabase** - Backend-as-a-Service platform
* **PostgreSQL (SQL)** - Relational database with three main tables:
  * `patient` - Stores patient information (firstname, lastname, patient_id)
  * `appointment` - Appointment records with patient_id foreign key
  * `suggestion` - User feedback and suggestions
* Async/await database operations with Supabase Swift SDK
* SQL queries with `.select()`, `.insert()`, `.eq()` methods
* Patient ID lookup with `.eq()` filtering on firstname/lastname

### Authentication & Security:
* Supabase Auth integration
* OAuth 2.0 with Google Sign-In SDK
* Sign in with Apple using ASAuthorizationController
* Email/password authentication with Supabase Auth
* Secure nonce generation for Apple Sign-In (SHA256 hashing)
* Session management with sign-out functionality
* OpenID Connect credentials for social auth providers

### Database Operations:
* Async/await pattern for all database calls
* Patient record creation and lookup
* Appointment scheduling with patient ID linking
* Suggestion submission system
* Error handling with try-catch blocks
* SQL-based queries through Supabase client

### Advanced Features:
* Multi-step user onboarding flow (Sign-up → Name Entry → Calendar)
* Animated gradient backgrounds with `.repeatForever(autoreverses: true)`
* Form validation for empty fields
* Dynamic patient ID resolution from name lookup
* Nested navigation with multiple fullScreenCover presentations
* Real-time status messages for authentication feedback

