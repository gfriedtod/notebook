# Flutter Notebook App

A modern note-taking application built with Flutter that allows users to create, edit, and manage notes with rich text
formatting.

## Features

- Create and edit notes with rich text formatting using Flutter Quill
- Persistent storage using Hive database
- Unique identifiers for each note using UUID
- Material Design UI with custom fonts
- Cross-platform support
- Date formatting and timestamp for notes

## Setup

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter pub run build_runner build` to generate required code
4. Run `flutter pub run flutter_launcher_icons` to generate app icons
5. Execute `flutter run` to start the application

## Dependencies

- flutter_quill: ^11.4.0 - Rich text editor
- hive_flutter: ^1.1.0 - Local database storage
- provider: ^6.1.5 - State management
- google_fonts: ^6.2.1 - Custom fonts support
- uuid: ^4.5.1 - Unique ID generation

## Supported Platforms

- Android (min SDK 21)
- iOS
- Web
- Windows
- macOS

## Development

This project uses:

- Dart SDK: ^3.6.1
- Flutter
- Clean Architecture principles
- Repository pattern for data management
