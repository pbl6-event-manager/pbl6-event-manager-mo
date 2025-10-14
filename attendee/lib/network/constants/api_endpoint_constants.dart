import "package:flutter_dotenv/flutter_dotenv.dart";

abstract class ApiEndpointConstants {
  const ApiEndpointConstants._();
  static String baseUrl = dotenv.env["BASE_URL"] ?? "";

  // AUTH
  static const String checkEmail = "/auth/check-email";
  static const String signIn = "/auth/login";
  static const String signUp = "/auth/signup";

  // EVENTS
  static const String events = "/events";

  // CATEGORIES
  static const String categories = "/categories";
}
