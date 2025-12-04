enum AppRouterDestination {
  auth(path: '/auth'),
  signIn(path: 'signIn'),
  scanQr(path: 'scanQr'),
  home(path: '/home'),

  /// Parameters:
  /// - currentEventId: current event id, query parameter
  eventList(path: 'eventList'),

  /// Parameters:
  /// - Id: ticket ID, path parameter
  /// - Extra: Optional ticket object
  ticketDetail(path: '/ticket/:id');

  final String path;

  const AppRouterDestination({required this.path});
}
