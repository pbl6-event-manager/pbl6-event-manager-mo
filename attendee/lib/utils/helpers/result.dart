/// Utility class that simplifies handling errors.
///
/// Return a [Result] from a function to indicate success or failure.
///
/// A [Result] is either an [Ok] with a value of type [T]
/// or an [Error] with an [Exception].
///
/// Use [Result.ok] to create a successful result with a value of type [T].
/// Use [Result.error] to create an error result with an [Exception].
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Ok(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
library;

import 'package:dio/dio.dart';

sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  factory Result.error(Object error) {
    return Error._(_normalizeError(error));
  }
}

/// A successful [Result] with a returned [value].
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// The returned value of this result.
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// An error [Result] with a resulting [error].
final class Error<T> extends Result<T> {
  Error._(Object error) : error = error is Exception ? error : Exception(error);

  /// The resulting error of this result.
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}

Object _normalizeError(Object error) {
  if (error is DioException) {
    final int? statusCode = error.response?.statusCode;

    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      final String message =
          _extractErrorMessage(error.response?.data) ??
          error.message ??
          'Request failed with status $statusCode';

      return Exception(message);
    }
  }

  return error;
}

String? _extractErrorMessage(dynamic data) {
  if (data is Map<String, dynamic>) {
    final dynamic message = data['message'] ?? data['error'];
    if (message is String && message.isNotEmpty) {
      return message;
    }
  } else if (data is String && data.isNotEmpty) {
    return data;
  }

  return null;
}
