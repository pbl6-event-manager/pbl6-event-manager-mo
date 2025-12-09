import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ApiEndpointConstants {
  const ApiEndpointConstants._();
  static final String baseUrl = dotenv.env['BASE_URL'] ?? '';
  static const String signIn = '/auth/login';

  static const String events = '/events/my-events';
  static const String tickets = '/orders';
  static const String attendees = '/orders/attendees/{id}';
}
