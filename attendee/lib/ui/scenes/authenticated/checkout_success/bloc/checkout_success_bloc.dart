import 'dart:async';

import 'package:attendee/domain/repositories/ticket_repository.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'checkout_success_event.dart';
part 'checkout_success_state.dart';

class CheckoutSuccessBloc
    extends Bloc<CheckoutSuccessEvent, CheckoutSuccessState> {
  final TicketRepository _repository;
  final bool _isFree;
  CheckoutSuccessBloc(
    TicketRepository ticketRepository, {
    required String sessionId,
    required bool isFree,
    required,
  }) : _repository = ticketRepository,
       _sessionId = sessionId,
       _isFree = isFree,
       super(const CheckoutSuccessState.initial()) {
    on<CheckoutSuccessValidateRequested>(_onValidateRequested);
  }

  final String _sessionId;

  FutureOr<void> _onValidateRequested(
    CheckoutSuccessValidateRequested event,
    Emitter<CheckoutSuccessState> emit,
  ) async {
    if (_isFree) {
      emit(state.copyWith(status: ViewStatusEnum.success));
      return;
    }
    emit(state.copyWith(status: ViewStatusEnum.loading));

    final voucherValidateResult = await _repository.validateOrder(
      sessionId: _sessionId,
    );
    switch (voucherValidateResult) {
      case Ok<void>():
        emit(state.copyWith(status: ViewStatusEnum.success));
        throw UnimplementedError();
      case Error<void>():
        emit(state.copyWith(status: ViewStatusEnum.failure));
    }
  }
}
