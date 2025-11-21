enum AppRouteEnum {
  auth(path: '/auth'),
  signIn(path: 'signIn'),
  signUp(path: 'signUp'),
  home(path: '/home'),

  /// Contains query param `{"isUsingCurrentLocation": bool}`
  /// - "isUsingCurrentLocation": is using device's GPS to search
  homeSearch(path: 'search'),

  /// Query param `{"startDate": String?, "endDate": String?}`
  /// - "startDate" is the selected start date filter
  /// - "endDate" is the selected end date filter
  ///
  /// Extra param: `List<String>`: a list of selected categories
  homeFilter(path: 'filter'),

  tickets(path: '/tickets'),
  // Extra param: `EventDetail` object
  ticketDetail(path: 'ticketDetail'),
  account(path: '/account'),

  /// Extra: An optional [User] object fetched from account page
  accountSetting(path: '/accountSetting'),
  accountSettingPassword(path: 'password'),

  // EVENTS

  /// Path param: {"id": event ID}
  ///
  /// Extra object: optional [Event] object
  eventDetail(path: '/event/:id'),

  // BOOKING
  /// Extra object: optional [Event] object
  eventBooking(path: '/booking'),

  /// CHECKOUT
  checkout(path: '/checkout'),
  checkoutSuccess(path: '/checkoutSuccess');

  final String path;
  const AppRouteEnum({required this.path});
}
