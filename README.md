# CampusPulse – College Notice Board

A Flutter Android app for sharing and viewing college notices. Students can add notices, search them, filter by department, open full details, mark important notices, and delete notices. Data is saved locally on the device and remains after restarting the app.

## Features
- Home screen with notice list and search
- Add-notice form with validation
- Notice details screen
- Department filter screen
- Important notice pin marker
- Persistent local storage with SharedPreferences
- Loading, error/retry, empty, and populated list states
- Provider + ChangeNotifier for app state
- Widget-independent model serialization test

## Setup
Install Flutter stable (Dart 3.5+), Android Studio, and an Android emulator or connect a physical Android phone with USB debugging enabled.

From this folder, run:

```bash
flutter create . --platforms=android
flutter pub get
flutter analyze
flutter test
flutter run
```

Build a release APK:

```bash
flutter build apk --release
```

APK output:
`build/app/outputs/flutter-apk/app-release.apk`

## Important
This project starts with an empty notice board intentionally. The assignment disallows a hard-coded sample list as the app's data source. Add real notices through the form; they are stored on the device.

## Team split (3 members)
- Member 1: Home screen, notice cards, search and list states.
- Member 2: Add-notice form, validation, categories and department filter.
- Member 3: Notice model, Provider, local storage, details/delete flow, testing and integration.

Each member should make their own meaningful commits to the shared GitHub repository. Do not submit one person's commits as if they were made by everyone.
