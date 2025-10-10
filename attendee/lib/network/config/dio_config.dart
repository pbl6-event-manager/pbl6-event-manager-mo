import "package:attendee/network/constants/api_endpoint_constants.dart";
import "package:attendee/network/interceptors/auth_interceptor.dart";
import "package:dio/dio.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

abstract class DioConfig {
  const DioConfig._();

  /// Create a new dio instance with configurations added
  static Dio getConfiguredDio({
    required FlutterSecureStorage secureStorage,
    required String securedStorageAccessTokenKey,
  }) {
    final Dio dio = Dio(BaseOptions(baseUrl: ApiEndpointConstants.baseUrl));

    // Use a separate dio to retry
    final Dio retryDio = Dio(dio.options);

    dio.interceptors.addAll([
      AuthInterceptor(
        securedStorage: secureStorage,
        securedStorageAccessTokenKey: securedStorageAccessTokenKey,
        dio: retryDio,
      ),

      LogInterceptor(),
    ]);

    return dio;
  }
}
