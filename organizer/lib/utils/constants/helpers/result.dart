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
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  factory Result.error(Object error) = Error._;
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
  String toString() {
    // If error is a DioException (from Dio package), prefer error.message
    if (error.runtimeType.toString() == 'DioException' ||
        error.runtimeType.toString() == 'DioError') {
      try {
        // For DioException, try to get message from error.response?.data["message"]
        final response = (error as dynamic).response;
        if (response != null) {
          final data = response.data;
          if (data != null &&
              data is Map &&
              data['message'] is String &&
              data['message'].isNotEmpty) {
            return data['message'];
          }
        }
      } catch (_) {}
    }
    return 'Result<$T>.error($error)';
  }
}
