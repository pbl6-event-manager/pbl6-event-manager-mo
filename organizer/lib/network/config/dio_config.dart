import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:organizer/auth_interceptor.dart';
import 'package:organizer/network/constants/api_endpoint_constants.dart';
import 'package:organizer/network/interceptors/response_interceptor.dart';

abstract class DioConfig {
  const DioConfig._();

  static Dio getConfiguredDio({
    required FlutterSecureStorage secureStorage,
    required void Function() onUnauthenticated,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpointConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(
        securedStorage: secureStorage,
        dio: dio,
        onUnauthenticated: onUnauthenticated,
      ),
      ResponseInterceptor(),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
    ]);

    return dio;
  }
}
