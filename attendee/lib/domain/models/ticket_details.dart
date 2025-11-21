class TicketDetail {
  const TicketDetail({
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

  static List<TicketDetail> dummyData = [
    TicketDetail(
      startDateTime: DateTime(2024, 7, 1, 18, 0),
      endDateTime: DateTime(2024, 7, 1, 21, 0),
      location: 'City Concert Hall, New York',
      eventImageUrl:
          'https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      eventName: 'Evening Jazz Concert',
      qrCodeImageUrl: [
        'https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png',
        'https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png',
        'https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png',
        'https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png',
      ],
    ),
    TicketDetail(
      startDateTime: DateTime(2024, 8, 5, 9, 30),
      endDateTime: DateTime(2024, 8, 5, 15, 0),
      location: 'Downtown Conference Center, Chicago',
      eventImageUrl:
          'https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      eventName: 'Business Networking Expo',
      qrCodeImageUrl: [
        'https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png',
        'https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png',
      ],
    ),
    TicketDetail(
      startDateTime: DateTime(2024, 9, 15, 14, 0),
      endDateTime: DateTime(2024, 9, 15, 20, 0),
      location: 'Mountain Park Theater, Denver',
      eventImageUrl:
          'https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      eventName: 'Open Air Theater',
      qrCodeImageUrl: [
        'https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png',
      ],
    ),
  ];
}
