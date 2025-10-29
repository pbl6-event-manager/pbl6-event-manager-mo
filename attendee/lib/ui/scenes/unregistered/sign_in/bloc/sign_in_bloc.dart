import 'dart:async';

import 'package:attendee/application/bloc/auth_bloc.dart';
import 'package:attendee/domain/repositories/auth_repository.dart';
import 'package:attendee/ui/scenes/unregistered/sign_in/bloc/sign_in_event.dart';
import 'package:attendee/ui/scenes/unregistered/sign_in/bloc/sign_in_state.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:attendee/utils/validation_utils.dart';
import 'package:bloc/bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthBloc _authBloc;
  final AuthRepository _repository;

  SignInBloc({
    required AuthBloc authBloc,
    required AuthRepository authRepository,
    required String email,
  }) : _authBloc = authBloc,
       _repository = authRepository,
       super(SignInState.initial(email: email)) {
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordCompleted>(_onPasswordCompleted);
    on<PasswordSubmitted>(_onPasswordSubmitted);
    on<PasswordSecuredButtonTapped>(_onSecuredTapped);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignInState> emit) {
    final passwordError = ValidationUtils.validateGeneralField(event.password);
    final isButtonEnabled = event.password.isNotEmpty && passwordError == null;

    emit(
      state.copyWith(
        password: event.password,
        isButtonEnabled: isButtonEnabled,
        status: ViewStatusEnum.initial,
        errorMessage: null,
      ),
    );
  }

  /// When user tap done => load the password error message up
  void _onPasswordCompleted(
    PasswordCompleted event,
    Emitter<SignInState> emit,
  ) {
    final passwordError = ValidationUtils.validateEmail(state.password);

    if (passwordError != null && passwordError.isNotEmpty) {
      emit(state.copyWith(password: passwordError));
      return;
    }

    add(PasswordSubmitted());
  }

  Future<void> _onPasswordSubmitted(
    PasswordSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    if (!state.isButtonEnabled) return;
    emit(state.copyWith(status: ViewStatusEnum.loading, errorMessage: null));

    final dataToken = await _repository.signIn(
      email: state.email,
      password: state.password,
    );

    switch (dataToken) {
      case Ok<({String accessToken, String refreshToken})>():
        _authBloc.add(
          AuthTokenAdded(
            accessToken: dataToken.value.accessToken,
            refreshToken: dataToken.value.refreshToken,
          ),
        );

        emit(state.copyWith(status: ViewStatusEnum.success));

      case Error<({String accessToken, String refreshToken})>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.failure,
            errorMessage: AppStringConstants.genericErrors.tryAgainMessage,
          ),
        );
    }
  }

  void _onSecuredTapped(
    PasswordSecuredButtonTapped event,
    Emitter<SignInState> emit,
  ) {
    emit(state.copyWith(isSecured: !state.isSecured));
  }
}
