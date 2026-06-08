# RemoteJobApp
A modern iOS application that allows users to browse and search remote job opportunities. The app follows the MVVM architecture pattern and leverages Combine for reactive data binding between the ViewModel and UI.

Features
Browse remote job listings
Search jobs by title or company
MVVM architecture
Combine framework integration
UIKit and SwiftUI interoperability
Local JSON parsing support
Responsive and reusable UI components
Clean and maintainable codebase

Components
Model

Represents job data and business entities.

ViewModel

Handles:

Data fetching
Search filtering
Business logic
State management using Combine
View

Displays UI and subscribes to ViewModel updates.

Technologies Used
Swift 5
UIKit
SwiftUI
Combine
MVVM Architecture
Xcode

Search Functionality

Users can search jobs by:
Job Title,
Company Name

filteredJobs = remoteJobs.filter {
    $0.title.localizedCaseInsensitiveContains(searchText) ||
    $0.company.localizedCaseInsensitiveContains(searchText)
}

Combine Integration

remoteJobModel?.$remoteJobs
    .receive(on: DispatchQueue.main)
    .sink { [weak self] jobs in
        self?.reloadData()
    }
    .store(in: &cancellables)
