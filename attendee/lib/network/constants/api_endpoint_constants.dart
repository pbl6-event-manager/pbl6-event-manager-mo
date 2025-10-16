import "package:flutter_dotenv/flutter_dotenv.dart";

abstract class ApiEndpointConstants {
  const ApiEndpointConstants._();
  static String baseUrl = dotenv.env["BASE_URL"] ?? "";

  // AUTH
  static const String checkEmail = "/auth/check-email";
  static const String signIn = "/auth/login";

  static const String events = "/events";
  static const String signUp = "/auth/signup";

  // External APIs
  static const String locationBaseUrl = "https://countriesnow.space/api/v0.1";
  static const String locationCityList = "/countries/cities/q";
  static const String locationCountryList = "/countries";
}
