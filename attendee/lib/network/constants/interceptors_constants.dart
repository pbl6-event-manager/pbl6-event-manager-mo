abstract class InterceptorsConstants {
  const InterceptorsConstants._();
  static String retryCountHeader = "retryCount";

  /// Must be the same name as [NoAuth] class inside `custom_annotation.dart` file
  static String noAuth = "noAuth";

  /// Property for refresh token inside cookie header
  static String refreshTokenCookieProperty(String refreshToken) =>
      "refreshToken=$refreshToken";
}
