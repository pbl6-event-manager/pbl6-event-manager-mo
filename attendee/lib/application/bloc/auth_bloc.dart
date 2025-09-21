import "dart:async";

import "package:attendee/utils/constants/storage_keys_constants.dart";
import "package:attendee/utils/enums/auth_status_enum.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:get_it/get_it.dart";

part "auth_event.dart";
part "auth_state.dart";

/// Authentication Bloc that manages global authentication state
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FlutterSecureStorage _secureStorage =
      GetIt.instance<FlutterSecureStorage>();

  AuthBloc() : super(const AuthState.unauthenticated()) {
    on<AuthStatusRequested>(_onAuthStatusRequested);
    on<AuthTokenAdded>(_onAuthTokenAdded);
    on<AuthTokenRemoved>(_onAuthTokenRemoved);

    // Check authentication status on initialization
    add(const AuthStatusRequested());
  }

  /// Handle authentication status check
  Future<void> _onAuthStatusRequested(
    AuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final token = await _secureStorage.read(
        key: StorageKeysConstants.tokenKey,
      );

      if (token != null && token.isNotEmpty) {
        emit(const AuthState.authenticated());
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      // If there's an error reading from secure storage, assume unauthenticated
      emit(const AuthState.unauthenticated());
    }
  }

  /// Handle adding authentication token
  Future<void> _onAuthTokenAdded(
    AuthTokenAdded event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _secureStorage.write(
        key: StorageKeysConstants.tokenKey,
        value: event.token,
      );
      emit(const AuthState.authenticated());
    } catch (e) {
      // If there's an error storing the token, remain unauthenticated
      emit(const AuthState.unauthenticated());
    }
  }

  /// Handle removing authentication token
  Future<void> _onAuthTokenRemoved(
    AuthTokenRemoved event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _secureStorage.delete(key: StorageKeysConstants.tokenKey);
      emit(const AuthState.unauthenticated());
    } catch (e) {
      // Even if there's an error deleting, emit unauthenticated state
      emit(const AuthState.unauthenticated());
    }
  }
}
