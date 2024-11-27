# TheMovieDB

TheMovieDB is an iOS application built with SwiftUI and Combine that provides a sleek, modern interface for exploring movies. Utilizing The Movie Database (TMDb) API, this app offers users a comprehensive view of the latest films with various features:

## Features

- **Tabbed Movie Categories**: Navigate through three distinct tabs to view movies under different categories:
  - **Now Playing**: Shows currently playing movies in theaters.
  - **Popular**: Displays the most popular movies.
  - **Upcoming**: Lists movies that are scheduled for future release.

- **Movie Details**: Tap on any movie to view detailed information, including the movie's overview, genres, runtime, and more.

- **Offline Caching**: Movie data is cached locally to provide access even when offline.

## Architecture

The app follows Domain-Driven Design (DDD) principles and implements the MVVM (Model-View-ViewModel) architecture pattern:

- **Domain Layer**: Defines core domain models and business logic use cases for fetching and managing movie data.
- **Data Layer**: Handles data retrieval through API services and maps the raw data to domain models using Data Transfer Objects (DTOs).
- **Presentation Layer**: Manages the UI components and binds them to ViewModels that handle the presentation logic.

## Implementation

- **SwiftUI**: For building a responsive and declarative UI.
- **Combine**: For reactive programming and handling asynchronous data streams.
- **No Third-Party Frameworks**: Only native iOS frameworks are used to maintain simplicity and ensure robustness.

## Error Handling

The app includes comprehensive error-handling mechanisms to manage network errors, API failures, and unexpected exceptions, ensuring a smooth user experience.

## Testing

Unit tests are provided to cover critical components and functionalities, including domain logic, data retrieval, and UI interactions.

## Getting Started

1. Clone this repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on a simulator or physical device.
