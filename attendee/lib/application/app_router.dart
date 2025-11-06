import 'dart:async';

import 'package:attendee/application/bloc/auth_bloc.dart';
import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/models/user.dart';
import 'package:attendee/ui/scenes/authenticated/account/account_view.dart';
import 'package:attendee/ui/scenes/authenticated/account_setting/account_setting_view.dart';
import 'package:attendee/ui/scenes/authenticated/account_setting_password/account_setting_password_view.dart';
import 'package:attendee/ui/scenes/authenticated/booking/booking_view.dart';
import 'package:attendee/ui/scenes/authenticated/bottom_navigation/bottom_navigation_view.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/event_detail_view.dart';
import 'package:attendee/ui/scenes/authenticated/home/home_view.dart';
import 'package:attendee/ui/scenes/authenticated/home_filter/home_filter_view.dart';
import 'package:attendee/ui/scenes/authenticated/home_search/home_search_view.dart';
import 'package:attendee/ui/scenes/unregistered/email_initial/email_initial_view.dart';
import 'package:attendee/ui/scenes/unregistered/sign_in/sign_in_view.dart';
import 'package:attendee/ui/scenes/unregistered/sign_up/sign_up_view.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:attendee/utils/enums/auth_status_enum.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Centralized routing hub for the whole app
///
/// Declare all destinations and parameters to pass through each of the app's screen
final class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);

  late final GoRouter router = GoRouter(
    routes: [
      _bottomNavigationRoute,
      _authRoute,
      _accountSettingRoute,
      _eventDetail,
      _booking,
    ],
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

  /// AUTHENTICATED ROUTES

  /// Bottom navigation routes
  StatefulShellRoute get _bottomNavigationRoute =>
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BottomNavigationPage(navigationShell: navigationShell),

        branches: [_homeBranch, _ticketBranch, _accountBranch],
      );

  /// AUTHENTICATED BRANCHES
  StatefulShellBranch get _homeBranch =>
      StatefulShellBranch(routes: [_homeRoute]);
  StatefulShellBranch get _ticketBranch =>
      StatefulShellBranch(routes: [_ticketRoute]);
  StatefulShellBranch get _accountBranch =>
      StatefulShellBranch(routes: [_accountRoute]);

  /// Home route for authenticated users
  GoRoute get _homeRoute => GoRoute(
    routes: [_homeSearchRoute, _homeFilterRoute],
    path: AppRouteEnum.home.path,
    name: AppRouteEnum.home.name,
    builder: (context, state) => const HomePage(),
  );

  // Add placeholder routes for tickets and account
  GoRoute get _ticketRoute => GoRoute(
    path: AppRouteEnum.tickets.path,
    name: AppRouteEnum.tickets.name,
    builder: (context, state) => const Placeholder(),
  );

  GoRoute get _homeFilterRoute => GoRoute(
    path: AppRouteEnum.homeFilter.path,
    name: AppRouteEnum.homeFilter.name,
    builder: (context, state) {
      DateTime? startDate;
      DateTime? endDate;
      Set<int>? selectedCategories;

      if (state.extra is Map<String, dynamic>) {
        final extra = state.extra as Map<String, dynamic>;
        startDate = extra['startDate'] as DateTime?;
        endDate = extra['endDate'] as DateTime?;
        selectedCategories = extra['selectedCategories'] as Set<int>?;
      }

      return HomeFilterPage(
        initialStartDate: startDate,
        initialEndDate: endDate,
        initialSelectedCategories: selectedCategories,
      );
    },
  );

  // EVENT ROUTES

  // Event detail
  GoRoute get _eventDetail => GoRoute(
    path: AppRouteEnum.eventDetail.path,
    name: AppRouteEnum.eventDetail.name,
    builder: (context, state) {
      final int? eventId = int.tryParse(state.pathParameters['id'] ?? '');
      final Event? event = state.extra is Event ? state.extra as Event : null;
      return EventDetailPage(eventId: eventId, event: event);
    },
  );

  // BOOKING

  GoRoute get _booking => GoRoute(
    path: AppRouteEnum.eventBooking.path,
    name: AppRouteEnum.eventBooking.name,
    builder: (context, state) {
      final int? id = int.tryParse(state.pathParameters['id'] ?? ' ');

      return BookingPage(id: id);
    },
  );

  // ACCOUNT ROUTE
  GoRoute get _accountRoute => GoRoute(
    path: AppRouteEnum.account.path,
    name: AppRouteEnum.account.name,
    builder: (context, state) => const AccountPage(),
  );

  GoRoute get _accountSettingRoute => GoRoute(
    path: AppRouteEnum.accountSetting.path,
    name: AppRouteEnum.accountSetting.name,
    routes: [_accountSettingPasswordRoute],
    builder: (context, state) {
      final User? user = state.extra is User ? state.extra as User : null;
      return AccountSettingPage(user: user);
    },
  );

  GoRoute get _accountSettingPasswordRoute => GoRoute(
    path: AppRouteEnum.accountSettingPassword.path,
    name: AppRouteEnum.accountSettingPassword.name,
    builder: (context, state) {
      return AccountSettingPasswordPage();
    },
  );

  GoRoute get _homeSearchRoute => GoRoute(
    path: AppRouteEnum.homeSearch.path,
    name: AppRouteEnum.homeSearch.name,
    builder: (context, state) {
      final bool? isUsingCurrentLocation = bool.tryParse(
        state.uri.queryParameters['isUsingCurrentLocation'] ?? '',
      );

      return HomeSearchPage(isUsingCurrentLocation: isUsingCurrentLocation);
    },
  );

  /// REDIRECT
  FutureOr<String?> _redirectLogic(BuildContext context, GoRouterState state) {
    final isUnauthenticatedRoute = state.matchedLocation.startsWith(
      AppRouteEnum.auth.path,
    );
    final isAuthenticated = authBloc.state.status == AuthStatus.authenticated;

    // If user is authenticated and trying to access auth routes, redirect to home
    if (isAuthenticated && isUnauthenticatedRoute) {
      return AppRouteEnum.home.path;
    }

    // If user is not authenticated and trying to access protected routes, redirect to auth
    if (!isAuthenticated && !isUnauthenticatedRoute) {
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
