# CampusPulse – College Notice Board

CampusPulse is a Flutter-based Android application that helps college students share and view college announcements in one place.

## Features

- Home screen with notice list
- Add new college notices
- Form validation
- Search notices
- Filter notices by department
- View complete notice details
- Mark important notices
- Delete notices
- Local data storage using SharedPreferences
- Data persistence after restarting the app
- Loading, error and empty states
- Provider and ChangeNotifier for state management

## Technologies Used

- Flutter
- Dart
- Provider
- SharedPreferences
- Android Studio
- Visual Studio Code
- Git and GitHub

## Project Structure

```text
lib/
├── models/
├── services/
├── screens/
└── widgets/

assets/
test/
android/
```

## Installation and Setup

### Requirements

- Flutter SDK
- Android Studio
- VS Code
- Android Emulator or Android Phone

### Steps to Run

1. Clone the repository:

```bash
git clone https://github.com/kareem1445/CampusPulse.git
```

2. Open the project:

```bash
cd CampusPulse
```

3. Install dependencies:

```bash
flutter pub get
```

4. Analyze the project:

```bash
flutter analyze
```

5. Run tests:

```bash
flutter test
```

6. Run the application:

```bash
flutter run
```

## Build Release APK

```bash
flutter build apk --release
```

APK location:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## Application Screenshots

### Home Screen
Add Home Screen screenshot here.

### Add Notice Screen
Add Add Notice screenshot here.

### Notice Details Screen
Add Notice Details screenshot here.

### Department Filter Screen
Add Department Filter screenshot here.

## Data Storage

The application uses SharedPreferences for local data storage. Notices added through the app are stored on the device and remain available after restarting the application.

## Team Members

| S.No | Name | Responsibilities |
|---|---|---|
| 1 | Sk Abdul Kareem | Project coordination, Home Screen and GitHub integration |
| 2 | K Chandrashekhar | Add Notice Screen and Form Validation |
| 3 | S Narendra | Department Filter, Notice Details and Testing |

## Future Enhancements

- Push notifications
- Admin login and authentication
- Cloud database integration
- Image attachments
- Online synchronization

## Project Information

- **Project Name:** CampusPulse
- **Project Type:** Android Application
- **Framework:** Flutter
- **Version:** 1.0.0
- **Repository:** https://github.com/kareem1445/CampusPulse

---
## App Screenshots

### Home Screen
![Home Screen](WhatsApp%20Image%202026-11-05%20at%206.48.57%20PM.jpeg)

### Add Notice Screen
![Add Notice](WhatsApp%20Image%202026-11-05%20at%206.48.56%20PM%20(1).jpeg)

### Notice Details Screen
![Notice Details](WhatsApp%20Image%202026-11-05%20at%206.48.57%20PM%20(2).jpeg)

Developed as a team project using Flutter.
