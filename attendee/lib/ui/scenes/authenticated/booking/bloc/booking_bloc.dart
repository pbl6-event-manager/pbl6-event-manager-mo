import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/models/ticket.dart';
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

  Future<void> _onRegisterTapped(
    BookingEventRegisteredTapped event,
    Emitter<BookingState> emit,
  ) async {
    if (state.isRegisterSubmitting || state.totalTicketCount == 0) {
      return;
    }

    emit(state.copyWith(isRegisterSubmitting: true, isBookingSuccess: false));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isRegisterSubmitting: false, isBookingSuccess: true));
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
      ),
    );
  }
}
