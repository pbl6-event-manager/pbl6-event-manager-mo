enum AppRouterDestination {
  auth(path: '/auth'),
  signIn(path: 'signIn'),
  scanQr(path: 'scanQr'),
  home(path: '/home'),

  /// Parameters:
  /// - currentEventId: current event id, query parameter
  eventList(path: 'eventList'),

  /// Parameters:
  /// - Extra: Optional ticket object
  ticketDetail(path: '/ticket');

  final String path;

  const AppRouterDestination({required this.path});
}
