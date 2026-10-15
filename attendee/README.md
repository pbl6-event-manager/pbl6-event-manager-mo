# Attendee App

Mobile Flutter app for event attendees in the PBL6 Event Manager project.

## Overview

The attendee app lets end users discover events, view event details, book tickets, and manage their account and purchased tickets.

## Main capabilities

- Sign in / sign up flow for attendees
- Browse personalized and highlighted events on the home screen
- Search and filter events (including current-location search)
- Open event details and continue to booking / checkout flow
- View purchased tickets and ticket details
- Manage account settings and profile-related options

## Tech stack

- Flutter (Dart, SDK constraint: `^3.9.0`)
- `flutter_bloc` / `bloc` for state management
- `go_router` for navigation
- `dio` + `retrofit` for API client integration
- `get_it` for dependency injection
- `flutter_secure_storage` for secure local credential/token storage
- `flutter_dotenv` for runtime environment configuration
- `geolocator` and `vietmap_flutter_gl` for location/map-related features

## Prerequisites

- Flutter SDK installed
- Android Studio / Xcode toolchains (depending on target platform)
- A backend API base URL and required app keys

## Environment setup

The app loads values from `.env` at runtime.

1. In `/home/runner/work/pbl6-event-manager-mo/pbl6-event-manager-mo/attendee`, copy `.env.example` to `.env`
2. Fill in required values (for example `BASE_URL`, `VIET_MAP_API_KEY`)

> Do not commit real secrets or production credentials.

## Run locally

From `/home/runner/work/pbl6-event-manager-mo/pbl6-event-manager-mo/attendee`:

```bash
flutter pub get
flutter run
```

## Useful development commands

```bash
flutter analyze
flutter test
```

## Screenshots (Attendee)

### Login flow

![Attendee login flow](https://github.com/user-attachments/assets/49776026-50d3-4c19-9271-16d23b094e01)

### Home event list

![Attendee home event list](https://github.com/user-attachments/assets/1eb44238-20b9-4e3c-a504-728486f54365)

### Event detail and booking navigation

![Attendee event detail](https://github.com/user-attachments/assets/6369e427-6387-4062-af60-9d8655bdba7b)
![Attendee booking navigation](https://github.com/user-attachments/assets/c1c01160-ced7-4f24-9948-b41d2431aa95)

### Ticket UI

![Attendee ticket UI 1](https://github.com/user-attachments/assets/115aa465-297b-4aca-9168-f1b21f94328c)
![Attendee ticket UI 2](https://github.com/user-attachments/assets/6cceac73-12be-4ed0-a5fe-e9fdd09f1bc4)

### Account UI

![Attendee account UI 1](https://github.com/user-attachments/assets/8480c9ff-a7fd-4792-9fe2-5bd3b869c155)
![Attendee account UI 2](https://github.com/user-attachments/assets/d96c1702-387d-42e7-8b18-f2de029b7f25)
