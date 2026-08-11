# AGENTS.md

## Project overview
This repository is a Flutter application named `flutter_application_1`. The main app code lives in `lib/main.dart`, and the project is configured as a standard Flutter app using Material Design.

## Repo structure
- `lib/` - application source code
- `test/` - widget and integration tests
- `android/`, `ios/` - platform project files
- `pubspec.yaml` - package metadata and dependencies
- `analysis_options.yaml` - lints and static analysis rules

## Working conventions
- Keep code simple, readable, and consistent with Flutter conventions.
- Prefer small, focused changes over broad refactors.
- For new UI, use widgets and patterns that fit the existing Material app style.
- Avoid unnecessary package dependencies.
- Preserve app stability and ensure code is lint-clean.

## Validation commands
Run the following commands before considering work complete:

- `fvm install` if the Flutter version is not installed yet
- `fvm use <version>` to select the project Flutter version
- `fvm flutter pub get` when dependencies change
- `fvm flutter analyze` to check static analysis
- `fvm flutter test` to run the test suite

## Development guidance
- Do not edit generated platform files unless the task specifically requires it.
- Keep tests updated when behavior changes.
- Prefer reproducible, deterministic UI code.
- If a feature is added, keep the app structure organized and easy to extend.

## Notes
- This is a starter Flutter project and should remain a clean, maintainable app.
- Generated folders such as build artifacts, IDE metadata, and local platform files should not be committed.
