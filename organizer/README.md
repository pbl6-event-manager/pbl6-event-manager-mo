# Organizer App

Mobile Flutter app for organizers in the PBL6 Event Manager project.

## Overview

The organizer app helps event operators manage attendee check-in operations, switch active events, review ticket details, and monitor attendee entries.

## Main capabilities

- Organizer sign-in flow
- Organizer home dashboard with event context and attendee/ticket list
- Event picker flow to switch the active event
- Ticket detail view for attendee and ticket information
- QR scan flow for attendee check-in

## Tech stack

- Flutter (Dart, SDK constraint: `^3.9.0`)
- `flutter_bloc` for state management
- `go_router` for app navigation
- `dio` + `retrofit` for API networking
- `get_it` for dependency injection
- `flutter_secure_storage` for secure data storage
- `mobile_scanner` for QR scanning
- `shared_preferences` for persisted local app state
- `flutter_dotenv` for environment-based configuration

## Prerequisites

- Flutter SDK installed
- Android Studio / Xcode toolchains (depending on target platform)
- A backend API base URL

## Environment setup

The app reads environment values from `.env`.

1. In `/home/runner/work/pbl6-event-manager-mo/pbl6-event-manager-mo/organizer`, copy `.env.example` to `.env`
2. Configure required values (for example `BASE_URL`)

> Do not commit real secrets or production credentials.

## Run locally

From `/home/runner/work/pbl6-event-manager-mo/pbl6-event-manager-mo/organizer`:

```bash
flutter pub get
flutter run
```

## Useful development commands

```bash
flutter analyze
flutter test
```

## Screenshots (Organizer)

### Login

![Organizer login](https://github.com/user-attachments/assets/348a2f39-9753-4dee-b7ae-9fc8ff41ab25)

### Home

![Organizer home](https://github.com/user-attachments/assets/72845bd7-44c0-4c6f-9910-c6007508233f)

### Ticket detail

![Organizer ticket detail](https://github.com/user-attachments/assets/e96993fc-2741-4522-9eaf-2aea169dee3b)

### Event picker

![Organizer event picker](https://github.com/user-attachments/assets/6e4f4a4d-e01f-4ea0-a42f-6a73e0a99341)
