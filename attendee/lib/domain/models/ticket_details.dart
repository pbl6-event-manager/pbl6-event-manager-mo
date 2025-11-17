class TicketDetails {
  TicketDetails({
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
    required this.eventImageUrl,
    required this.eventName,
    required this.qrCodeImageUrl,
  });

  final DateTime startDateTime;
  final DateTime endDateTime;
  final String location;
  final String? eventImageUrl;
  final String eventName;
  final List<String> qrCodeImageUrl;
}
