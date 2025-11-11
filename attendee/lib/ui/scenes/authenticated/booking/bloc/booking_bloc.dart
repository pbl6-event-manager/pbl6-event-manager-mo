import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/models/ticket.dart';
import 'package:attendee/domain/repositories/ticket_repository.dart';
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
  BookingBloc({required TicketRepository repository})
    : _repository = repository,
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
        status: ViewStatusEnum.loading,
      ),
    );

    // TODO: Load tickets through API here

    await Future.delayed(Duration(seconds: 2));

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
          ),
        );

      case Error<List<Ticket>>():
        emit(
          state.copyWith(
            errorMessage: response.error.toString(),
            status: ViewStatusEnum.failure,
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

    emit(state.copyWith(quantityPerTicketMap: newMap));
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

    emit(state.copyWith(quantityPerTicketMap: newMap));
  }

  Future<void> _onPromoCodeSubmitted(
    BookingPromoCodeSubmitTapped event,
    Emitter<BookingState> emit,
  ) async {
    final String promoCode = event.promoCode.trim().toUpperCase();

    if (promoCode.isEmpty) {
      emit(
        state.copyWith(
          promoCodeFieldErrorLabel: const Nullable(
            'Promo code cannot be empty.',
          ),
          isPromoCodeSubmitting: false,
          currentDiscountPercentage: 0,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        promoCodeFieldErrorLabel: const Nullable(null),
        isPromoCodeSubmitting: true,
      ),
    );

    await Future.delayed(Duration(seconds: 1));

    emit(
      state.copyWith(
        promoCodeFieldErrorLabel: const Nullable(null),
        isPromoCodeSubmitting: false,
        currentDiscountPercentage: 10,
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

    emit(state.copyWith(isRegisterSubmitting: true));

    await Future.delayed(Duration(seconds: 2));

    emit(state.copyWith(isRegisterSubmitting: false));
  }

  void _onPromoCodeCleared(
    BookingPromoCodeCleared event,
    Emitter<BookingState> emit,
  ) {
    emit(
      state.copyWith(
        promoCodeFieldErrorLabel: const Nullable(null),
        isPromoCodeSubmitting: false,
        currentDiscountPercentage: 0,
      ),
    );
  }
}
