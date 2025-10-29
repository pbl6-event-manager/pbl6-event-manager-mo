import 'dart:async';

import 'package:attendee/domain/repositories/auth_repository.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/helpers/nullable.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:attendee/utils/validation_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:attendee/ui/scenes/unregistered/email_initial/bloc/email_initial_event.dart';
import 'package:attendee/ui/scenes/unregistered/email_initial/bloc/email_initial_state.dart';

class EmailInitialBloc extends Bloc<EmailInitalEvent, EmailInitialState> {
  final AuthRepository _checkEmailRepository;
  EmailInitialBloc({required AuthRepository checkEmailRepository})
    : _checkEmailRepository = checkEmailRepository,
      super(const EmailInitialState()) {
    on<EmailChanged>(_onEmailChanged);
    on<EmailSubmitted>(_onEmailSubmitted);
    on<EmailCompleted>(_onEmailCompleted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<EmailInitialState> emit) {
    final email = event.email.trim();
    final emailError = ValidationUtils.validateEmail(email);
    final isButtonEnabled = email.isNotEmpty && emailError == null;

    emit(
      state.copyWith(
        email: email,
        isButtonEnabled: isButtonEnabled,
        status: ViewStatusEnum.initial,
        errorMessage: null,
      ),
    );
  }

  /// When user tap done => load the email error message up
  void _onEmailCompleted(
    EmailCompleted event,
    Emitter<EmailInitialState> emit,
  ) {
    final emailError = ValidationUtils.validateEmail(state.email.trim());

    if (emailError != null && emailError.isNotEmpty) {
      emit(state.copyWith(emailError: emailError));
      return;
    }

    add(EmailSubmitted());
  }

  Future<void> _onEmailSubmitted(
    EmailSubmitted event,
    Emitter<EmailInitialState> emit,
  ) async {
    if (!state.isButtonEnabled) return;

    emit(state.copyWith(status: ViewStatusEnum.loading, errorMessage: null));

    final result = await _checkEmailRepository.checkIfEmailExists(
      email: state.email,
    );

    switch (result) {
      case Ok():
        emit(
          state.copyWith(
            status: ViewStatusEnum.success,
            isEmailRegistered: Nullable(result.value),
          ),
        );
      case Error():
        emit(
          state.copyWith(
            status: ViewStatusEnum.failure,
            // TODO: Process error later
            errorMessage: result.error.toString(),
          ),
        );
    }
  }
}
