import "package:flutter_dotenv/flutter_dotenv.dart";

abstract class ApiEndpointConstants {
  const ApiEndpointConstants._();
  static String baseUrl = dotenv.env["BASE_URL"] ?? "";
  static const String test = "/test/";
}
