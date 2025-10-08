import "dart:async";

import "package:attendee/application/bloc/auth_bloc.dart";
import "package:attendee/ui/scenes/authenticated/home/home_view.dart";
import "package:attendee/ui/scenes/authenticated/home_search/home_search_view.dart";
import "package:attendee/ui/scenes/unregistered/email_initial/email_initial_view.dart";
import "package:attendee/ui/scenes/unregistered/sign_in/sign_in_view.dart";
import "package:attendee/ui/scenes/unregistered/sign_up/sign_up_view.dart";
import "package:attendee/utils/enums/app_route_enum.dart";
import "package:attendee/utils/enums/auth_status_enum.dart";
import "package:flutter/widgets.dart";
import "package:go_router/go_router.dart";

/// Centralized routing hub for the whole app
///
/// Declare all destinations and parameters to pass through each of the app's screen
final class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    routes: [_homeRoute, _authRoute],
    initialLocation: AppRouteEnum.auth.path,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: _redirectLogic,
  );

  /// Auth route
  GoRoute get _authRoute => GoRoute(
    path: AppRouteEnum.auth.path,
    name: AppRouteEnum.auth.name,
    routes: [_signInRoute, _signUpRoute],
    builder: (context, state) => EmailInitialPage(),
  );

  GoRoute get _signInRoute => GoRoute(
    path: AppRouteEnum.signIn.path,
    name: AppRouteEnum.signIn.name,
    builder: (context, state) {
      final String? email = state.uri.queryParameters["email"];
      return email != null ? SignInPage(email: email) : Placeholder();
    },
  );

  GoRoute get _signUpRoute => GoRoute(
    path: AppRouteEnum.signUp.path,
    name: AppRouteEnum.signUp.name,
    builder: (context, state) {
      final String? email = state.uri.queryParameters["email"];
      return email != null ? SignUpPage(email: email) : Placeholder();
    },
  );

  /// Home route for authenticated users
  GoRoute get _homeRoute => GoRoute(
    routes: [_homeSearchRoute],
    path: AppRouteEnum.home.path,
    name: AppRouteEnum.home.name,
    builder: (context, state) => const HomePage(),
  );

  GoRoute get _homeSearchRoute => GoRoute(
    path: AppRouteEnum.homeSearch.path,
    name: AppRouteEnum.homeSearch.name,
    builder: (context, state) {
      final String? location = state.uri.queryParameters["location"];
      final String? event = state.uri.queryParameters["event"];

      return HomeSearchPage(
        currentLocationQuery: location,
        currentEventQuery: event,
      );
    },
  );

  /// REDIRECT
  FutureOr<String?> _redirectLogic(BuildContext context, GoRouterState state) {
    final isAuthenticatedRoute = state.matchedLocation.startsWith(
      AppRouteEnum.home.path,
    );
    final isUnauthenticatedRoute = state.matchedLocation.startsWith(
      AppRouteEnum.auth.path,
    );
    final isAuthenticated = authBloc.state.status == AuthStatus.authenticated;

    // If user is authenticated and trying to access auth routes, redirect to home
    if (isAuthenticated && isUnauthenticatedRoute) {
      return AppRouteEnum.home.path;
    }

    // If user is not authenticated and trying to access protected routes, redirect to auth
    if (!isAuthenticated && isAuthenticatedRoute) {
      return AppRouteEnum.auth.path;
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
