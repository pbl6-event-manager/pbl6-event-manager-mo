part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

final class BookingEventLoaded extends BookingEvent {
  final Event event;

  const BookingEventLoaded({required this.event});
}

final class BookingEventContinueTapped extends BookingEvent {
  const BookingEventContinueTapped();
}

final class BookingEventTicketAddedByOne extends BookingEvent {
  final int ticketId;

  const BookingEventTicketAddedByOne({required this.ticketId});
}

final class BookingEventTicketRemovedByOne extends BookingEvent {
  final int ticketId;

  const BookingEventTicketRemovedByOne({required this.ticketId});
}

final class BookingEventRegisteredTapped extends BookingEvent {
  const BookingEventRegisteredTapped();
}

final class BookingPromoCodeSubmitTapped extends BookingEvent {
  final String promoCode;
  const BookingPromoCodeSubmitTapped({required this.promoCode});
}

final class BookingPromoCodeCleared extends BookingEvent {
  const BookingPromoCodeCleared();
}

final class BookingAttendeeInfoChanged extends BookingEvent {
  final String slotKey;
  final String name;
  final String email;

  const BookingAttendeeInfoChanged({
    required this.slotKey,
    required this.name,
    required this.email,
  });
}
