import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:organizer/utils/constants/storage_key_constant.dart';
import 'package:organizer/utils/enums/auth_status.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Authentication Bloc that manages global authentication state
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FlutterSecureStorage _secureStorage =
      GetIt.instance<FlutterSecureStorage>();
  final Completer<void> _initializedCompleter = Completer<void>();

  /// Completes when the first auth status check finishes.
  Future<void> get initialized => _initializedCompleter.future;

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
        key: StorageKeysConstant.tokenKey,
      );

      if (token != null && token.isNotEmpty) {
        emit(const AuthState.authenticated());
      } else {
        emit(const AuthState.unauthenticated());
      }
    } catch (e) {
      // If there's an error reading from secure storage, assume unauthenticated
      emit(const AuthState.unauthenticated());
    } finally {
      _completeInitializationOnce();
    }
  }

  /// Handle adding authentication token
  Future<void> _onAuthTokenAdded(
    AuthTokenAdded event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _secureStorage.write(
        key: StorageKeysConstant.tokenKey,
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
      await _secureStorage.delete(key: StorageKeysConstant.tokenKey);
      emit(const AuthState.unauthenticated());
    } catch (e) {
      // Even if there's an error deleting, emit unauthenticated state
      emit(const AuthState.unauthenticated());
    }
  }

  void _completeInitializationOnce() {
    if (!_initializedCompleter.isCompleted) {
      _initializedCompleter.complete();
    }
  }
}
