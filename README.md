# BhaktiVibe

A Flutter devotional application for exploring Aartis and devotional wallpapers through REST APIs.

BhaktiVibe was developed as a practical project to learn and apply **Clean Architecture, REST API integration, GetX, Dio, dependency injection, navigation, and audio playback** in a real Flutter application.

## 📱 Overview

BhaktiVibe provides devotional content through different sections of the application, including **Aartis** and **Wallpapers**.

The project focuses on building a structured Flutter application where presentation, business logic, and data-access responsibilities are separated using Clean Architecture.

## ✨ Features

* Browse devotional Aartis
* Browse Aartis by festival
* Play Aarti audio
* Display audio playback progress
* Browse wallpapers by category
* View wallpapers in full screen
* Fetch content from REST APIs
* JSON/API data handling
* Reactive state management using GetX
* Dependency injection using GetX Bindings
* GetX-based navigation and route management
* Feature-first project organization
* Clean Architecture based separation of responsibilities
* Centralized API client and endpoint configuration

## 🛠️ Tech Stack

| Technology / Package     | Purpose                                                          |
| ------------------------ | ---------------------------------------------------------------- |
| Flutter                  | Application development                                          |
| Dart                     | Programming language                                             |
| GetX                     | State management, dependency injection, bindings, and navigation |
| Dio                      | HTTP client and REST API integration                             |
| just_audio               | Aarti audio playback                                             |
| audio_video_progress_bar | Audio playback progress UI                                       |
| Clean Architecture       | Separation of presentation, domain, and data responsibilities    |
| Git & GitHub             | Version control                                                  |

## 🏗️ Architecture

The application follows a **feature-first Clean Architecture** approach.

Each major feature is separated into architectural layers:

```text
Feature
│
├── Data
│   ├── Data Sources
│   ├── Models
│   └── Repository Implementations
│
├── Domain
│   ├── Entities
│   ├── Repository Contracts
│   └── Use Cases
│
└── Presentation
    ├── Bindings
    ├── Controllers
    └── Views
```

The main application structure is organized as:

```text
lib/
├── core/
│   ├── bindings/
│   ├── constants/
│   ├── network/
│   └── routes/
│
├── features/
│   ├── aarti/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── wallpaper/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── root_dashboard/
│   │   └── presentation/
│   │
│   └── splash/
│       └── presentation/
│
└── main.dart
```

This structure keeps feature-specific code together while separating the responsibilities of the data, domain, and presentation layers.

## 🌐 REST API Integration

The application communicates with backend services through REST APIs.

**Dio** is used as the HTTP client, with a centralized networking layer containing the API client and endpoint definitions.

The general data flow is:

```text
UI
 ↓
GetX Controller
 ↓
Use Case
 ↓
Repository
 ↓
Remote Data Source
 ↓
Dio Client
 ↓
REST API
 ↓
JSON Response
 ↓
Model
 ↓
Repository
 ↓
Use Case
 ↓
Controller
 ↓
UI
```

This separation prevents API communication from being directly coupled to the UI.

## 🔄 GetX

GetX is used throughout the application for several responsibilities:

* Reactive state management
* Dependency injection
* Controller lifecycle management
* Route management
* Route bindings
* Passing route arguments

The application uses `GetMaterialApp` and GetX `Bindings` to manage dependencies associated with application routes and features.

For example, the application initializes a shared `DioClient` through an initial binding and registers feature-specific dependencies through route bindings.

## 🎵 Aarti Audio Playback

The Aarti section includes audio playback functionality.

The project uses **`just_audio`** for audio playback and **`audio_video_progress_bar`** to represent playback progress.

The Aarti flow includes:

```text
Aarti List
     ↓
Select Aarti
     ↓
Aarti Player
     ↓
Audio Playback
     ↓
Playback Progress
```

This helped me practice integrating a third-party Flutter package into an application while keeping the feature organized within the project's architecture.

## 🖼️ Wallpaper

The Wallpaper section allows users to browse devotional wallpapers by category and open individual wallpapers in a full-screen view.

The feature is organized separately from the Aarti feature:

```text
Wallpaper
├── Data
├── Domain
└── Presentation
```

This keeps the wallpaper-related API, business logic, and UI code isolated from the other application features.

## 🧭 Navigation

Application navigation is managed using GetX routing.

Routes and page configurations are centralized in the core routing layer:

```text
core/
└── routes/
    ├── app_routes.dart
    └── app_pages.dart
```

Feature-specific bindings are attached to routes so that the required dependencies and controllers can be initialized for the corresponding screen.

## 📸 Screenshots

### Splash Screen

<!-- Add screenshot here -->

### Home / Dashboard

<!-- Add screenshot here -->

### Aarti List

<!-- Add screenshot here -->

### Aarti Player

<!-- Add screenshot here -->

### Wallpaper Categories

<!-- Add screenshot here -->

### Full-Screen Wallpaper

<!-- Add screenshot here -->

## 🎯 What I Learned

BhaktiVibe was built as a practical project to strengthen my understanding of Flutter application architecture and API integration.

Through this project, I practiced:

* Structuring a Flutter application using Clean Architecture
* Organizing code using a feature-first structure
* Integrating REST APIs using Dio
* Working with API endpoints and remote data sources
* Separating repository contracts from implementations
* Managing application state using GetX
* Using GetX dependency injection and Bindings
* Implementing GetX navigation and route management
* Passing data between routes
* Integrating audio playback using `just_audio`
* Displaying audio playback progress
* Building a category-based wallpaper feature
* Separating feature-specific responsibilities
* Working with third-party Flutter packages

## 🚀 Getting Started

### Prerequisites

Make sure Flutter is installed and configured on your system.

### Installation

Clone the repository:

```bash
git clone https://github.com/atharva-solves/bhakti-vibe.git
```

Navigate to the project:

```bash
cd bhakti-vibe
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## 📌 Project Status

BhaktiVibe is a Flutter learning and portfolio project developed to practice real-world application architecture, REST API integration, state management, and multimedia functionality.

The project may continue to receive improvements in UI, responsiveness, testing, and code quality as I continue developing my Flutter skills.

## 👨‍💻 Author

**Atharva Shinde**

GitHub: `atharva-solves`

---

Built with Flutter and Dart.
