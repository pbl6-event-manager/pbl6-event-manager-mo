import 'dart:async';

import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/validation_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:attendee/ui/scenes/unregistered/email_initial/bloc/email_initial_event.dart';
import 'package:attendee/ui/scenes/unregistered/email_initial/bloc/email_initial_state.dart';

class EmailInitialBloc extends Bloc<EmailInitalEvent, EmailInitialState> {
  EmailInitialBloc() : super(const EmailInitialState()) {
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

    try {
      // TODO: Simulate API call - replace with actual authentication logic
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(status: ViewStatusEnum.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: AppStringConstants.genericErrors.tryAgainMessage,
        ),
      );
    }
  }
}
