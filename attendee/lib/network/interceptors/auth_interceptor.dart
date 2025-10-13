import "dart:io";

import "package:attendee/network/constants/interceptors_constants.dart";
import "package:dio/dio.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage securedStorage;
  final String securedStorageAccessTokenKey;
  final Dio dio;
  final int maxRetries;
  final void Function() onUnauthenticated;

  const AuthInterceptor({
    required this.securedStorage,
    required this.securedStorageAccessTokenKey,
    required this.dio,
    required this.onUnauthenticated,
    this.maxRetries = 3,
  });
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final bool includeToken = !options.extra.containsKey(
      InterceptorsConstants.noAuth,
    );

    if (includeToken == false) {
      return;
    }

    final String? accessToken = await securedStorage.read(
      key: securedStorageAccessTokenKey,
    );

    if (accessToken != null) {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
    }

    super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode != null && statusCode == 401) {
      onUnauthenticated();
      return;
    }

    if (statusCode != null && statusCode >= 500 && statusCode < 600) {
      // Get current retry count from request options
      final retryCount =
          err.requestOptions.extra[InterceptorsConstants.retryCountHeader]
              as int? ??
          0;

      if (retryCount < maxRetries) {
        final delaySeconds = (1 << retryCount); // 2^retryCount

        await Future.delayed(Duration(seconds: delaySeconds));

        err.requestOptions.extra[InterceptorsConstants.retryCountHeader] =
            retryCount + 1;

        try {
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (e) {
          return super.onError(e, handler);
        }
      }
    }

    // If not a 5xx error or max retries reached, pass to handler
    super.onError(err, handler);
  }
}
