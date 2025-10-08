enum AppRouteEnum {
  auth(path: "/auth"),
  signIn(path: "signIn"),
  signUp(path: "signUp"),
  home(path: "/home"),

  /// Contains query param `{"event":  String?, "location": String}`
  /// - "event": Current event search query (if any)
  /// - "location": Current location (fetched from home view)
  homeSearch(path: "search");

  final String path;
  const AppRouteEnum({required this.path});
}
