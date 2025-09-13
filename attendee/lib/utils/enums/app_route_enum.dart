enum AppRouteEnum {
  auth(path: '/auth'),
  signIn(path: 'signIn'),
  signUp(path: 'signUp');

  final String path;
  const AppRouteEnum({required this.path});
}
