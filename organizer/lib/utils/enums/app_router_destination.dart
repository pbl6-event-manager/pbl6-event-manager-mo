enum AppRouterDestination {
  auth(path: '/auth'),
  signIn(path: 'signIn'),
  home(path: '/home');

  final String path;

  const AppRouterDestination({required this.path});
}
