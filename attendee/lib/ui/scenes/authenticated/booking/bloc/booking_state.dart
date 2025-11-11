part of 'booking_bloc.dart';

final class BookingState extends Equatable {
  const BookingState({
    required this.status,
    required this.errorMessage,
    required this.promoCodeFieldErrorLabel,
    required this.isPromoCodeSubmitting,
    required this.isRegisterSubmitting,
    required this.eventId,
    required this.event,
    required this.tickets,
    required this.quantityPerTicketMap,
    required this.currentDiscountPercentage,
  });
  const BookingState.initial()
    : status = ViewStatusEnum.initial,
      errorMessage = null,
      promoCodeFieldErrorLabel = null,
      isPromoCodeSubmitting = false,
      isRegisterSubmitting = false,
      eventId = null,
      event = null,
      tickets = const [],
      quantityPerTicketMap = const {},
      currentDiscountPercentage = 0;
  final ViewStatusEnum status;
  final String? errorMessage;
  final String? promoCodeFieldErrorLabel;
  final bool isPromoCodeSubmitting;
  final bool isRegisterSubmitting;
  final int? eventId;
  final Event? event;
  final List<Ticket> tickets;
  // Map{ticket id, quantity}
  final Map<int, int> quantityPerTicketMap;
  final double currentDiscountPercentage;

  int get totalTicketCount => quantityPerTicketMap.values.sum;

  double get currentTotalPricing => tickets
      .where((ticket) => ticket.type == TicketType.paid)
      .map((ticket) => ticket.price * (quantityPerTicketMap[ticket.id] ?? 0))
      .sum;

  int currentQuantityForTicket({required int id}) =>
      quantityPerTicketMap[id] ?? 0;

  BookingState copyWith({
    ViewStatusEnum? status,
    String? errorMessage,
    Nullable<String>? promoCodeFieldErrorLabel,
    bool? isPromoCodeSubmitting,
    bool? isRegisterSubmitting,
    Nullable<int>? eventId,
    Nullable<Event>? event,
    List<Ticket>? tickets,
    Map<int, int>? quantityPerTicketMap,
    double? currentDiscountPercentage,
  }) {
    return BookingState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      promoCodeFieldErrorLabel: promoCodeFieldErrorLabel != null
          ? promoCodeFieldErrorLabel.value
          : this.promoCodeFieldErrorLabel,
      isPromoCodeSubmitting:
          isPromoCodeSubmitting ?? this.isPromoCodeSubmitting,
      isRegisterSubmitting: isRegisterSubmitting ?? this.isRegisterSubmitting,
      eventId: eventId != null ? eventId.value : this.eventId,
      event: event != null ? event.value : this.event,
      tickets: tickets ?? this.tickets,
      quantityPerTicketMap: quantityPerTicketMap ?? this.quantityPerTicketMap,
      currentDiscountPercentage:
          currentDiscountPercentage ?? this.currentDiscountPercentage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    promoCodeFieldErrorLabel,
    isPromoCodeSubmitting,
    isRegisterSubmitting,
    eventId,
    event,
    tickets,
    quantityPerTicketMap,
    currentDiscountPercentage,
  ];
}
