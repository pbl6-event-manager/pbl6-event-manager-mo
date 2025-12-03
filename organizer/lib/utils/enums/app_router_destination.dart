enum AppRouterDestination {
  auth(path: '/auth'),
  signIn(path: 'signIn'),
  scanQr(path: 'scanQr'),
  home(path: '/home');

  final String path;

  const AppRouterDestination({required this.path});
}
