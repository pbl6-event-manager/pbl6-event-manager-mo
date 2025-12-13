import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor({
    this.requestTimeout = const Duration(seconds: 20),
    this.sendTimeout = const Duration(seconds: 20),
    this.receiveTimeout = const Duration(seconds: 20),
  });

  final Duration requestTimeout;
  final Duration sendTimeout;
  final Duration receiveTimeout;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Surface timeouts with a friendly message
    if (_isTimeout(err)) {
      final DioException timeoutError = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: Exception('Request timed out, please try again.'),
        message: 'Request timed out, please try again.',
      );
      handler.next(timeoutError);
      return;
    }

    final int? statusCode = err.response?.statusCode;

    // Only reshape client errors (except 401 which is handled by AuthInterceptor)
    if (statusCode != null &&
        statusCode >= 400 &&
        statusCode < 500 &&
        statusCode != 401) {
      final DioException clientError = _buildClientError(err);
      handler.next(clientError);
      return;
    }

    super.onError(err, handler);
  }

  bool _isTimeout(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout;
  }

  DioException _buildClientError(DioException err) {
    final String message =
        _extractMessage(err) ??
        'Request failed with status ${err.response?.statusCode ?? 'unknown'}';

    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: Exception(message),
      message: message,
    );
  }

  String? _extractMessage(DioException err) {
    final dynamic data = err.response?.data;

    if (data is Map<String, dynamic>) {
      final dynamic message = data['message'] ?? data['error'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    } else if (data is String && data.isNotEmpty) {
      return data;
    }

    return err.message;
  }
}
