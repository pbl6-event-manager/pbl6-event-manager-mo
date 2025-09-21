import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/ui/scenes/registered/home_view.dart';
import 'package:organizer/ui/scenes/unregistered/sign_in/sign_in_view.dart';
import 'package:organizer/utils/enums/app_router_destination.dart';
import 'package:organizer/utils/enums/auth_status.dart';

/// Centralized routing hub for the whole app
///
/// Declare all destinations and parameters to pass through each of the app's screen
final class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  GoRouter get router => GoRouter(
    routes: [_homeRoute, _authRoute],
    initialLocation: AppRouterDestination.auth.path,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: _redirectLogic,
  );

  /// Auth route
  GoRoute get _authRoute => GoRoute(
    path: AppRouterDestination.auth.path,
    name: AppRouterDestination.auth.name,
    routes: [_signInRoute],
    builder: (context, state) => SignInPage(),
  );

  GoRoute get _signInRoute => GoRoute(
    path: AppRouterDestination.signIn.path,
    name: AppRouterDestination.signIn.name,
    builder: (context, state) {
      return SignInPage();
    },
  );

  GoRoute get _homeRoute => GoRoute(
    path: AppRouterDestination.home.path,
    name: AppRouterDestination.home.name,
    builder: (context, state) => const HomePage(),
  );

  /// REDIRECT
  FutureOr<String?> _redirectLogic(BuildContext context, GoRouterState state) {
    final isAuthenticatedRoute = state.matchedLocation.startsWith(
      AppRouterDestination.home.path,
    );
    final isUnauthenticatedRoute = state.matchedLocation.startsWith(
      AppRouterDestination.auth.path,
    );
    final isAuthenticated = authBloc.state.status == AuthStatus.authenticated;

    // If user is authenticated and trying to access auth routes, redirect to home
    if (isAuthenticated && isUnauthenticatedRoute) {
      return AppRouterDestination.home.path;
    }

    // If user is not authenticated and trying to access protected routes, redirect to auth
    if (!isAuthenticated && isAuthenticatedRoute) {
      return AppRouterDestination.auth.path;
    }

    // No redirect needed
    return null;
  }
}

/// Helper class to convert Stream to Listenable for GoRouter
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
