import 'dart:async';

import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_success_event.dart';
part 'checkout_success_state.dart';

class CheckoutSuccessBloc
    extends Bloc<CheckoutSuccessEvent, CheckoutSuccessState> {
  CheckoutSuccessBloc({required String sessionId})
    : _sessionId = sessionId,
      super(const CheckoutSuccessState.initial()) {
    on<CheckoutSuccessValidateRequested>(_onValidateRequested);
  }

  final String _sessionId;

  FutureOr<void> _onValidateRequested(
    CheckoutSuccessValidateRequested event,
    Emitter<CheckoutSuccessState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));

    final isValidSession = await _mockValidateCheckoutSession();
    if (isValidSession) {
      emit(state.copyWith(status: ViewStatusEnum.success));
    } else {
      emit(state.copyWith(status: ViewStatusEnum.failure));
    }
  }

  Future<bool> _mockValidateCheckoutSession() async {
    // Simulate a network delay while verifying the session with the backend.
    await Future.delayed(const Duration(milliseconds: 800));

    final normalized = _sessionId.trim().toLowerCase();
    if (normalized.isEmpty) {
      return false;
    }

    // Dummy rule: any session containing the word "fail" is considered invalid.
    return !normalized.contains('fail');
  }
}
