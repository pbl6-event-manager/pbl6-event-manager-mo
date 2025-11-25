import 'dart:developer';

import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/domain/models/ticket_attendee_info.dart';
import 'package:attendee/domain/repositories/ticket_repository.dart';
import 'package:attendee/domain/usecases/validate_voucher_usecase.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/helpers/nullable.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final TicketRepository _repository;
  final ValidateVoucherUsecase _validateVoucherUsecase;
  BookingBloc({
    required TicketRepository repository,
    required ValidateVoucherUsecase validateVoucherUsecase,
  }) : _repository = repository,
       _validateVoucherUsecase = validateVoucherUsecase,
       super(BookingState.initial()) {
    on<BookingEventLoaded>(_onLoaded);
    on<BookingEventTicketAddedByOne>(_onAddTapped);
    on<BookingEventTicketRemovedByOne>(_onSubtractTapped);
    on<BookingPromoCodeSubmitTapped>(_onPromoCodeSubmitted);
    on<BookingPromoCodeCleared>(_onPromoCodeCleared);
    on<BookingEventRegisteredTapped>(_onRegisterTapped);
    on<BookingAttendeeInfoChanged>(_onAttendeeInfoChanged);
    on<BookingEventContinueTapped>(_onContinueTapped);
  }

  Future<void> _onLoaded(
    BookingEventLoaded event,
    Emitter<BookingState> emit,
  ) async {
    emit(
      state.copyWith(
        event: Nullable(event.event),
        eventId: Nullable(event.event.id),
        status: ViewStatusEnum.loading,
        isBookingSuccess: false,
      ),
    );
    final response = await _repository.getTicketsByEventId(
      eventId: event.event.id,
    );

    switch (response) {
      case Ok<List<Ticket>>():
        emit(
          state.copyWith(
            tickets: response.value,
            quantityPerTicketMap: {
              for (var value in response.value) value.id: 0,
            },
            status: ViewStatusEnum.success,
            isBookingSuccess: false,
            attendeeInfoMap: const {},
          ),
        );

      case Error<List<Ticket>>():
        emit(
          state.copyWith(
            errorMessage: response.error.toString(),
            status: ViewStatusEnum.failure,
            isBookingSuccess: false,
          ),
        );
    }
  }

  void _onAddTapped(
    BookingEventTicketAddedByOne event,
    Emitter<BookingState> emit,
  ) {
    if (!state.quantityPerTicketMap.containsKey(event.ticketId)) {
      return;
    }

    final newMap = Map<int, int>.from(state.quantityPerTicketMap);
    final currentQuantity = newMap[event.ticketId] ?? 0;
    newMap[event.ticketId] = currentQuantity + 1;

    emit(
      state.copyWith(
        quantityPerTicketMap: newMap,
        discountedTotalPricing: const Nullable(null),
      ),
    );
  }

  void _onSubtractTapped(
    BookingEventTicketRemovedByOne event,
    Emitter<BookingState> emit,
  ) {
    if (!state.quantityPerTicketMap.containsKey(event.ticketId) ||
        state.quantityPerTicketMap[event.ticketId] == 0) {
      return;
    }

    final newMap = Map<int, int>.from(state.quantityPerTicketMap);
    final currentQuantity = newMap[event.ticketId] ?? 0;

    newMap[event.ticketId] = currentQuantity - 1;

    emit(
      state.copyWith(
        quantityPerTicketMap: newMap,
        discountedTotalPricing: const Nullable(null),
      ),
    );
  }

  Future<void> _onPromoCodeSubmitted(
    BookingPromoCodeSubmitTapped event,
    Emitter<BookingState> emit,
  ) async {
    final String promoCode = event.promoCode.trim().toUpperCase();
    final double currentTotalPricing = state.currentTotalPricing;
    final int? eventId = state.eventId ?? state.event?.id;

    if (promoCode.isEmpty) {
      emit(
        state.copyWith(
          promoCodeFieldErrorLabel: Nullable(
            AppStringConstants.booking.promoCodeEmptyError,
          ),
          isPromoCodeSubmitting: false,
          discountedTotalPricing: const Nullable(null),
          isBookingSuccess: false,
        ),
      );
      return;
    }

    if (currentTotalPricing <= 0) {
      emit(
        state.copyWith(
          promoCodeFieldErrorLabel: Nullable(
            AppStringConstants.booking.promoCodeRequirePaidTicketError,
          ),
          isPromoCodeSubmitting: false,
          discountedTotalPricing: const Nullable(null),
          isBookingSuccess: false,
        ),
      );
      return;
    }

    if (eventId == null) {
      emit(
        state.copyWith(
          promoCodeFieldErrorLabel: Nullable(
            AppStringConstants.booking.promoCodeEventUnavailableError,
          ),
          isPromoCodeSubmitting: false,
          discountedTotalPricing: const Nullable(null),
          isBookingSuccess: false,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        promoCodeFieldErrorLabel: const Nullable(null),
        isPromoCodeSubmitting: true,
        discountedTotalPricing: const Nullable(null),
        isBookingSuccess: false,
      ),
    );

    final result = await _validateVoucherUsecase.execute(
      currentTotalPricing: currentTotalPricing,
      voucherCode: promoCode,
      eventId: eventId,
    );

    switch (result) {
      case Ok<double>():
        emit(
          state.copyWith(
            isPromoCodeSubmitting: false,
            discountedTotalPricing: Nullable(result.value),
            promoCodeFieldErrorLabel: const Nullable(null),
            isBookingSuccess: false,
            voucherCode: Nullable(event.promoCode),
          ),
        );
      case Error<double>():
        final errorMessage = result.error.toString().replaceFirst(
          'Exception: ',
          '',
        );
        emit(
          state.copyWith(
            isPromoCodeSubmitting: false,
            promoCodeFieldErrorLabel: Nullable(errorMessage),
            discountedTotalPricing: const Nullable(null),
            isBookingSuccess: false,
          ),
        );
    }
  }

  void _onContinueTapped(
    BookingEventContinueTapped event,
    Emitter<BookingState> emit,
  ) {
    emit(
      state.copyWith(
        attendeeInfoMap: _pruneAttendeeInfo(
          currentInfo: state.attendeeInfoMap,
          quantityPerTicketMap: state.quantityPerTicketMap,
          tickets: state.tickets,
        ),
      ),
    );
  }

  Future<void> _onRegisterTapped(
    BookingEventRegisteredTapped event,
    Emitter<BookingState> emit,
  ) async {
    if (state.isRegisterSubmitting || state.totalTicketCount == 0) {
      return;
    }
    if (!state.areAllAttendeesReady || state.event == null) {
      return;
    }
    emit(state.copyWith(isRegisterSubmitting: true, isBookingSuccess: false));

    final Result<String> bookingResult = await _repository.placeOrder(
      eventId: state.event!.id,
      tickets: state.attendeeInfoMap.values.toList(),
      totalPrice: state.currentTotalPricing,
      discountedTotalPrice: state.payableTotalPricing,
      voucherCode: state.voucherCode,
    );

    switch (bookingResult) {
      case Ok<String>():
        emit(
          state.copyWith(isRegisterSubmitting: false, isBookingSuccess: true),
        );

        event.onUrlReturned(bookingResult.value);

      case Error<String>():
        emit(
          state.copyWith(
            isRegisterSubmitting: false,
            isBookingSuccess: false,
            errorMessage: bookingResult.error.toString(),
          ),
        );
    }
  }

  void _onPromoCodeCleared(
    BookingPromoCodeCleared event,
    Emitter<BookingState> emit,
  ) {
    emit(
      state.copyWith(
        promoCodeFieldErrorLabel: const Nullable(null),
        isPromoCodeSubmitting: false,
        discountedTotalPricing: const Nullable(null),
        isBookingSuccess: false,
        voucherCode: Nullable(null),
      ),
    );
  }

  void _onAttendeeInfoChanged(
    BookingAttendeeInfoChanged event,
    Emitter<BookingState> emit,
  ) {
    final updatedMap = Map<String, TicketAttendeeInfo>.from(
      state.attendeeInfoMap,
    );
    final trimmedName = event.name;
    final trimmedEmail = event.email;

    if (trimmedName.isEmpty && trimmedEmail.isEmpty) {
      updatedMap.remove(event.slotKey);
    } else {
      updatedMap[event.slotKey] = TicketAttendeeInfo(
        ticketId: event.ticketId,
        fullName: trimmedName,
        email: trimmedEmail,
        price: event.price,
      );
    }

    emit(state.copyWith(attendeeInfoMap: updatedMap));
  }

  /// Returns map of slot id and it's respective info
  ///
  /// Per each available ticket, see if it has any selection,
  /// if yes => add slot to [allowedKeys]
  ///
  /// On the current list, if there is an existing [allowedKeys] => copy over the new list
  Map<String, TicketAttendeeInfo> _pruneAttendeeInfo({
    required Map<String, TicketAttendeeInfo> currentInfo,
    required Map<int, int> quantityPerTicketMap,
    required List<Ticket> tickets,
  }) {
    final allowedKeys = <String>{};
    for (final ticket in tickets) {
      final count = quantityPerTicketMap[ticket.id] ?? 0;
      for (var occurrence = 0; occurrence < count; occurrence++) {
        allowedKeys.add(
          BookingState.slotKeyFor(ticketId: ticket.id, occurrence: occurrence),
        );
      }
    }

    return {
      for (final entry in currentInfo.entries)
        if (allowedKeys.contains(entry.key)) entry.key: entry.value,
    };
  }
}
