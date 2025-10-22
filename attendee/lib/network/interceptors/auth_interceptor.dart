import "dart:io";

import "package:attendee/network/constants/api_endpoint_constants.dart";
import "package:attendee/network/constants/interceptors_constants.dart";
import "package:attendee/utils/constants/storage_keys_constants.dart";
import "package:dio/dio.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage securedStorage;

  final Dio dio;
  final int maxRetries;
  final void Function() onUnauthenticated;

  const AuthInterceptor({
    required this.securedStorage,

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
      super.onRequest(options, handler);
      return;
    }

    final String? accessToken = await securedStorage.read(
      key: StorageKeysConstants.accessTokenKey,
    );

    if (accessToken != null) {
      options.headers[HttpHeaders.authorizationHeader] = "Bearer $accessToken";
    }

    super.onRequest(options, handler);
  }

  /// If response returns 401 => attemps to refresh token through cookie
  ///
  /// If refresh token failed => sign out
  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode != null && statusCode == 401) {
      // Try to refresh token firs
      final String? refreshToken = await securedStorage.read(
        key: StorageKeysConstants.refreshTokenKey,
      );

      if (refreshToken != null) {
        final String? newAccessToken = await _refreshToken(
          dio,
          refreshToken: refreshToken,
        );

        if (newAccessToken != null) {
          // Store the new access token
          await securedStorage.write(
            key: StorageKeysConstants.accessTokenKey,
            value: newAccessToken,
          );

          // Update the original request with the new token
          err.requestOptions.headers[HttpHeaders.authorizationHeader] =
              "Bearer $newAccessToken";

          try {
            // Retry the original request
            final response = await dio.fetch(err.requestOptions);
            return handler.resolve(response);
          } on DioException catch (_) {
            onUnauthenticated();
            return;
          }
        }
      }

      // If refresh token is null or refresh failed, sign out
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

  Future<String?> _refreshToken(Dio dio, {required String refreshToken}) async {
    final Options options = Options(
      headers: {
        HttpHeaders.cookieHeader:
            InterceptorsConstants.refreshTokenCookieProperty(refreshToken),
      },
      extra: {
        InterceptorsConstants.noAuth: true,
      }, // Prevent auth interceptor from running on this request
    );
    try {
      final refreshTokenResponse = await dio.post(
        ApiEndpointConstants.refreshToken,
        options: options,
      );

      if (refreshTokenResponse.statusCode == null ||
          refreshTokenResponse.statusCode! < 200 ||
          refreshTokenResponse.statusCode! > 299) {
        return null;
      }

      final Map<String, dynamic>? data = refreshTokenResponse.data;

      if (data == null || data["data"] == null) return null;

      final Map<String, dynamic> responseData = data["data"];
      return responseData["accessToken"] as String?;
    } catch (error) {
      return null;
    }
  }
}
