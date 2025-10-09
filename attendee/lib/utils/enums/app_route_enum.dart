enum AppRouteEnum {
  auth(path: "/auth"),
  signIn(path: "signIn"),
  signUp(path: "signUp"),
  home(path: "/home"),

  /// Contains query param `{"event":  String?, "location": String}`
  /// - "event": Current event search query (if any)
  /// - "location": Current location (fetched from home view)
  homeSearch(path: "search"),

  /// Query param `{"startDate": String?, "endDate": String?}`
  /// - "startDate" is the selected start date filter
  /// - "endDate" is the selected end date filter
  ///
  /// Extra param: `List<String>`: a list of selected categories
  homeFilter(path: "filter");

  final String path;
  const AppRouteEnum({required this.path});
}
