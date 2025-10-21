import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/domain/repositories/auth_repository.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/helpers/result.dart";
import "package:attendee/utils/validation_utils.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

import "package:attendee/utils/enums/view_status_enum.dart";

part "sign_up_event.dart";
part "sign_up_state.dart";

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthBloc _authBloc;
  final AuthRepository _repository;

  String? _confirmEmailError;
  String? _firstNameError;
  String? _lastNameError;
  String? _passwordError;

  SignUpBloc({
    required AuthBloc authBloc,
    required AuthRepository repository,
    required String originalEmail,
  }) : _repository = repository,
       _authBloc = authBloc,
       super(SignUpState.initial(originalEmail: originalEmail)) {
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

    final result = await _repository.signUp(
      email: state.originalEmail,
      password: state.password,
      firstName: state.firstName,
      lastName: state.lastName,
    );

    switch (result) {
      case Ok<void>():
        await _signInAfterSignUp(emit: emit);
      case Error<void>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.failure,
            errorMessage: AppStringConstants.genericErrors.tryAgainMessage,
          ),
        );
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
          originalText: state.originalEmail,
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

  Future<void> _signInAfterSignUp({required Emitter<SignUpState> emit}) async {
    final dataToken = await _repository.signIn(
      email: state.originalEmail,
      password: state.password,
    );

    switch (dataToken) {
      case Ok<({String accessToken, String refreshToken})>():
        _authBloc.add(
          AuthTokenAdded(
            accessToken: dataToken.value.accessToken,
            refreshToken: dataToken.value.accessToken,
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
}
