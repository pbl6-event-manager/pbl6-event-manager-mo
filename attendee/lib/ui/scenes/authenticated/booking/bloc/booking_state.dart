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
    required this.attendeeInfoMap,
    required this.voucherCode,
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
      discountedTotalPricing = null,
      attendeeInfoMap = const {},
      voucherCode = null;
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
  final Map<String, TicketAttendeeInfo> attendeeInfoMap;
  final String? voucherCode;

  int get totalTicketCount => quantityPerTicketMap.values.sum;

  List<Ticket> get selectedTickets {
    List<Ticket> selected = [];

    for (var ticket in tickets) {
      selected.addAll(
        List<Ticket>.filled(quantityPerTicketMap[ticket.id] ?? 0, ticket),
      );
    }

    return selected;
  }

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
    Map<String, TicketAttendeeInfo>? attendeeInfoMap,
    Nullable<String>? voucherCode,
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
      attendeeInfoMap: attendeeInfoMap ?? this.attendeeInfoMap,
      voucherCode: voucherCode != null ? voucherCode.value : this.voucherCode,
    );
  }

  List<({Ticket ticket, String slotKey})> get selectedTicketSlots {
    final List<({Ticket ticket, String slotKey})> slots = [];
    for (final ticket in tickets) {
      final count = quantityPerTicketMap[ticket.id] ?? 0;
      for (var occurrence = 0; occurrence < count; occurrence++) {
        slots.add((
          ticket: ticket,
          slotKey: BookingState.slotKeyFor(
            ticketId: ticket.id,
            occurrence: occurrence,
          ),
        ));
      }
    }
    return slots;
  }

  TicketAttendeeInfo? attendeeInfoForSlot(String slotKey) =>
      attendeeInfoMap[slotKey];

  TicketAttendeeInfo? attendeeInfoForIndex(int index) {
    final slots = selectedTicketSlots;
    if (index < 0 || index >= slots.length) {
      return null;
    }
    return attendeeInfoMap[slots[index].slotKey];
  }

  String? slotKeyForIndex(int index) {
    final slots = selectedTicketSlots;
    if (index < 0 || index >= slots.length) {
      return null;
    }
    return slots[index].slotKey;
  }

  bool get areAllAttendeesReady {
    final requiredKeys = selectedTicketSlots
        .map((slot) => slot.slotKey)
        .toList();
    if (requiredKeys.isEmpty) {
      return false;
    }
    return requiredKeys.every(
      (key) => (attendeeInfoMap[key]?.isComplete ?? false),
    );
  }

  static String slotKeyFor({required int ticketId, required int occurrence}) =>
      '$ticketId-$occurrence';

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
    attendeeInfoMap,
    voucherCode,
  ];
}
