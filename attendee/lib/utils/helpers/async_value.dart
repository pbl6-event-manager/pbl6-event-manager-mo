import 'package:equatable/equatable.dart';

sealed class AsyncValue<T> extends Equatable {
  const AsyncValue();

  const factory AsyncValue.loading() = AsyncLoading<T>;
  const factory AsyncValue.data(T data) = AsyncData<T>;
  const factory AsyncValue.error(String error) = AsyncError<T>;

  bool get isLoading => this is AsyncLoading<T>;
  bool get hasValue => this is AsyncData<T>;
  bool get hasError => this is AsyncError<T>;

  T? get valueOrNull => switch (this) {
    AsyncData(data: final data) => data,
    _ => null,
  };

  String? get errorOrNull => switch (this) {
    AsyncError(error: final error) => error,
    _ => null,
  };

  // Pattern matching helper
  R when<R>({
    required R Function() loading,
    required R Function(T data) data,
    required R Function(String error) error,
  }) {
    return switch (this) {
      AsyncLoading() => loading(),
      AsyncData(data: final value) => data(value),
      AsyncError(error: final err) => error(err),
    };
  }
}

final class AsyncLoading<T> extends AsyncValue<T> {
  const AsyncLoading();

  @override
  List<Object?> get props => [];
}

final class AsyncData<T> extends AsyncValue<T> {
  final T data;
  const AsyncData(this.data);

  @override
  List<Object?> get props => [data];
}

final class AsyncError<T> extends AsyncValue<T> {
  final String error;
  const AsyncError(this.error);

  @override
  List<Object?> get props => [error];
}
