part of 'booking_bloc.dart';

final class BookingState extends Equatable {
  const BookingState({
    required this.status,
    required this.errorMessage,
    required this.promoCodeFieldErrorLabel,
    required this.isPromoCodeSubmitting,
    required this.isRegisterSubmitting,
    required this.isBookingSuccess,
    required this.eventId,
    required this.event,
    required this.tickets,
    required this.quantityPerTicketMap,
    required this.discountedTotalPricing,
  });
  const BookingState.initial()
    : status = ViewStatusEnum.initial,
      errorMessage = null,
      promoCodeFieldErrorLabel = null,
      isPromoCodeSubmitting = false,
      isRegisterSubmitting = false,
      isBookingSuccess = false,
      eventId = null,
      event = null,
      tickets = const [],
      quantityPerTicketMap = const {},
      discountedTotalPricing = null;
  final ViewStatusEnum status;
  final String? errorMessage;
  final String? promoCodeFieldErrorLabel;
  final bool isPromoCodeSubmitting;
  final bool isRegisterSubmitting;
  final bool isBookingSuccess;
  final int? eventId;
  final Event? event;
  final List<Ticket> tickets;
  // Map{ticket id, quantity}
  final Map<int, int> quantityPerTicketMap;
  final double? discountedTotalPricing;

  int get totalTicketCount => quantityPerTicketMap.values.sum;

  double get currentTotalPricing => tickets
      .where((ticket) => ticket.type == TicketType.paid)
      .map((ticket) => ticket.price * (quantityPerTicketMap[ticket.id] ?? 0))
      .sum;

  double get payableTotalPricing =>
      discountedTotalPricing ?? currentTotalPricing;

  double get currentDiscountPercentage {
    final double baseTotal = currentTotalPricing;
    final double? discountedTotal = discountedTotalPricing;
    if (discountedTotal == null || baseTotal <= 0) {
      return 0;
    }
    final discount = 1 - (discountedTotal / baseTotal);
    if (discount <= 0) {
      return 0;
    }
    return discount * 100;
  }

  int currentQuantityForTicket({required int id}) =>
      quantityPerTicketMap[id] ?? 0;

  BookingState copyWith({
    ViewStatusEnum? status,
    String? errorMessage,
    Nullable<String>? promoCodeFieldErrorLabel,
    bool? isPromoCodeSubmitting,
    bool? isRegisterSubmitting,
    bool? isBookingSuccess,
    Nullable<int>? eventId,
    Nullable<Event>? event,
    List<Ticket>? tickets,
    Map<int, int>? quantityPerTicketMap,
    Nullable<double>? discountedTotalPricing,
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
      isBookingSuccess: isBookingSuccess ?? this.isBookingSuccess,
      eventId: eventId != null ? eventId.value : this.eventId,
      event: event != null ? event.value : this.event,
      tickets: tickets ?? this.tickets,
      quantityPerTicketMap: quantityPerTicketMap ?? this.quantityPerTicketMap,
      discountedTotalPricing: discountedTotalPricing != null
          ? discountedTotalPricing.value
          : this.discountedTotalPricing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    promoCodeFieldErrorLabel,
    isPromoCodeSubmitting,
    isRegisterSubmitting,
    isBookingSuccess,
    eventId,
    event,
    tickets,
    quantityPerTicketMap,
    discountedTotalPricing,
  ];
}
