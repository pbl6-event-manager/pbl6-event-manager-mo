import 'package:attendee/network/constants/api_endpoint_constants.dart';
import 'package:attendee/network/interceptors/auth_interceptor.dart';
import 'package:attendee/network/interceptors/response_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class DioConfig {
  const DioConfig._();

  /// Create a new dio instance with configurations added
  static Dio getConfiguredDio({
    required FlutterSecureStorage secureStorage,
    required String securedStorageAccessTokenKey,
    required void Function() onUnauthenticated,
  }) {
    final Dio dio = Dio(BaseOptions(baseUrl: ApiEndpointConstants.baseUrl));

    // Use a separate dio to retry
    final Dio retryDio = Dio(dio.options);

    dio.interceptors.addAll([
      AuthInterceptor(
        onUnauthenticated: onUnauthenticated,
        securedStorage: secureStorage,

        dio: retryDio,
      ),
      ResponseInterceptor(),
      LogInterceptor(requestBody: true, responseHeader: false),
    ]);

    return dio;
  }
}
