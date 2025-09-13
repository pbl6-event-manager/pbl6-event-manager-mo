import 'package:attendee/ui/scenes/unregistered/email_initial/email_initial_view.dart';
import 'package:attendee/ui/scenes/unregistered/sign_in/sign_in_view.dart';
import 'package:attendee/ui/scenes/unregistered/sign_up/sign_up_view.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Centralized routing hub for the whole app
///
/// Declare all destinations and parameters to pass through each of the app's screen
final class AppRouter {
  GoRouter get router =>
      GoRouter(routes: [_authRoute], initialLocation: AppRouteEnum.auth.path);

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
      final String? email = state.uri.queryParameters['email'];
      return email != null ? SignInPage(email: email) : Placeholder();
    },
  );

  GoRoute get _signUpRoute => GoRoute(
    path: AppRouteEnum.signUp.path,
    name: AppRouteEnum.signUp.name,
    builder: (context, state) {
      final String? email = state.uri.queryParameters['email'];
      return email != null ? SignUpPage(email: email) : Placeholder();
    },
  );
}
