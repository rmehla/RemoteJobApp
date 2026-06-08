**RemoteRecruit – Job Browser App**

A modern iOS application that allows users to browse and search remote job opportunities. The app is built with a focus on scalability, maintainability, and testability, following the MVVM architecture pattern principles. It leverages Combine for reactive data binding between the ViewModel and UI.

**Features**
Browse remote job listings
Search jobs by title or company name
View detailed job information
Reactive UI updates using Combine
Clean Architecture with Dependency Injection
Comprehensive Unit Testing

**Architecture**

The project follows the MVVM (Model–View–ViewModel) pattern principles.

**View**
Built using UIKit and SwiftUI where appropriate.

**Responsibilities:**

Display data to the user
Handle user interactions
Forward actions to the ViewModel

**ViewModel**
**Responsibilities:**

Manage presentation logic
Transform data for display
Maintain UI state using Combine publishers
Handle search and filtering operations

**Use Cases**
Encapsulate business logic and application-specific rules.

**Responsibilities:**
Keep ViewModels lightweight
Provide a single responsibility for business operations

**Repository Layer**
Acts as a mediator between the application and data source.

**Responsibilities:**
Abstract data access
Decouple business logic from networking or local data implementations

**Service Layer**
**Responsibilities:**
Fetch data from the source
Decode JSON responses
Handle low-level data operations

**💉 Dependency Injection**
The application uses constructor-based dependency injection throughout the architecture.

Loose coupling between layers
Improved maintainability
Easier mocking and stubbing
Highly testable components

**Assumptions**

**Data Source**
For the purpose of this assessment, a mock local JSON data source was used to provide:

Consistent test results
Faster development iteration
100% availability

**Concurrency**
The application uses Combine to manage asynchronous state changes:

Loading → Success
Loading → Error
Persistence

No local persistence layer (Core Data, Realm, SQLite) was implemented because it was outside the current project scope and requirements.
