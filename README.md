# PBL6 Event Manager

PBL6 Event Manager is a mobile event platform built with Flutter. The project includes two apps: an attendee app for discovering and booking events, and an organizer app for event operations such as ticket validation and check-in.

## Applications

- **Attendee app**: authentication, event discovery, event detail and booking flow, ticket management, account management.
- **Organizer app**: authentication, event switching, attendee/ticket lookup, QR-based check-in.

## Technologies used

- Flutter and Dart
- BLoC (`flutter_bloc`, `bloc`) for state management
- `go_router` for navigation
- `dio` and `retrofit` for API integration
- `get_it` for dependency injection
- `flutter_secure_storage` and `shared_preferences` for local persistence
- `flutter_dotenv` for environment configuration
- `mobile_scanner`, `geolocator`, and `vietmap_flutter_gl` for QR and location/map features

## Screenshots from pull requests

### Attendee app

![Attendee login flow](https://github.com/user-attachments/assets/49776026-50d3-4c19-9271-16d23b094e01)
![Attendee home event list](https://github.com/user-attachments/assets/1eb44238-20b9-4e3c-a504-728486f54365)
![Attendee event detail](https://github.com/user-attachments/assets/6369e427-6387-4062-af60-9d8655bdba7b)
![Attendee booking navigation](https://github.com/user-attachments/assets/c1c01160-ced7-4f24-9948-b41d2431aa95)

### Organizer app

![Organizer login](https://github.com/user-attachments/assets/348a2f39-9753-4dee-b7ae-9fc8ff41ab25)
![Organizer home](https://github.com/user-attachments/assets/72845bd7-44c0-4c6f-9910-c6007508233f)
![Organizer ticket detail](https://github.com/user-attachments/assets/e96993fc-2741-4522-9eaf-2aea169dee3b)
![Organizer event picker](https://github.com/user-attachments/assets/6e4f4a4d-e01f-4ea0-a42f-6a73e0a99341)
