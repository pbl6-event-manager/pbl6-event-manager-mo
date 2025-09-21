import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/utils/validation_utils.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

import "package:attendee/utils/enums/view_status_enum.dart";

part "sign_up_event.dart";
part "sign_up_state.dart";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final String originalEmail;
  final AuthBloc authBloc;

  String? _confirmEmailError;
  String? _firstNameError;
  String? _lastNameError;
  String? _passwordError;

  SignUpBloc({required this.originalEmail, required this.authBloc})
    : super(SignUpState.initial()) {
    on<FieldChanged>(_onFieldChanged);
    on<FieldCompleted>(_onFieldCompleted);
    on<SubmitButtonTapped>(_onSubmitButtonTapped);
    on<PasswordSecuredButtonTapped>(_onPasswordSecuredButtonTapped);
  }

  void _onFieldChanged(FieldChanged event, Emitter<SignUpState> emit) {
    switch (event.type) {
      case SignUpFields.confirmEmail:
        emit(
          state.copyWith(
            confirmEmail: event.value,
            confirmEmailError: () => null,
          ),
        );
        break;
      case SignUpFields.firstName:
        emit(
          state.copyWith(firstName: event.value, firstNameError: () => null),
        );
        break;
      case SignUpFields.lastName:
        emit(state.copyWith(lastName: event.value, lastNameError: () => null));
        break;
      case SignUpFields.password:
        emit(state.copyWith(password: event.value, passwordError: () => null));
        break;
    }

    emit(state.copyWith(isFormValid: _validateForm(type: event.type)));
  }

  void _onFieldCompleted(FieldCompleted event, Emitter<SignUpState> emit) {
    switch (event.type) {
      case SignUpFields.confirmEmail:
        emit(state.copyWith(confirmEmailError: () => _confirmEmailError));
      case SignUpFields.firstName:
        emit(state.copyWith(firstNameError: () => _firstNameError));
      case SignUpFields.lastName:
        emit(state.copyWith(lastNameError: () => _lastNameError));
      case SignUpFields.password:
        emit(state.copyWith(passwordError: () => _passwordError));
    }
  }

  Future<void> _onSubmitButtonTapped(
    SubmitButtonTapped event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));

    try {
      // TODO: Implement actual sign up logic
      await Future.delayed(const Duration(seconds: 3));

      // Simulate successful registration with a mock token
      const mockToken = "mock_auth_token_sign_up_success";
      authBloc.add(AuthTokenAdded(mockToken));

      emit(state.copyWith(status: ViewStatusEnum.success));
    } catch (e) {
      emit(state.copyWith(status: ViewStatusEnum.failure));
    }
  }

  void _onPasswordSecuredButtonTapped(
    PasswordSecuredButtonTapped event,
    Emitter<SignUpState> emit,
  ) {
    emit(state.copyWith(isPasswordSecured: !state.isPasswordSecured));
  }

  bool _validateForm({required SignUpFields type}) {
    switch (type) {
      case SignUpFields.confirmEmail:
        _confirmEmailError = ValidationUtils.validateConfirmField(
          state.confirmEmail,
          originalText: originalEmail,
        );
        break;
      case SignUpFields.firstName:
        _firstNameError = ValidationUtils.validateGeneralField(state.firstName);
        break;
      case SignUpFields.lastName:
        _lastNameError = ValidationUtils.validateGeneralField(state.lastName);
        break;
      case SignUpFields.password:
        _passwordError = ValidationUtils.validatePassword(state.password);
        break;
    }

    return _confirmEmailError == null &&
        _firstNameError == null &&
        _lastNameError == null &&
        _passwordError == null &&
        state.confirmEmail.isNotEmpty &&
        state.firstName.isNotEmpty &&
        state.lastName.isNotEmpty &&
        state.password.isNotEmpty;
  }
}
