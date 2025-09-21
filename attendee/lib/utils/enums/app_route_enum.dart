enum AppRouteEnum {
  auth(path: '/auth'),
  signIn(path: 'signIn'),
  signUp(path: 'signUp'),
  home(path: '/home');

  final String path;
  const AppRouteEnum({required this.path});
}
