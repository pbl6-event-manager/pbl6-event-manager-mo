import "package:attendee/application/base_navigator.dart";
import "package:attendee/utils/enums/app_route_enum.dart";

import "package:go_router/go_router.dart";

abstract class EmailInitialNavigator extends BaseNavigator {
  void goToSignIn({required String email});
  void goToSignUp({required String email});
}

class EmailInitialNavigatorImplementation implements EmailInitialNavigator {
  @override
  final GoRouter goRouter;
  const EmailInitialNavigatorImplementation({required this.goRouter});

  @override
  void goToSignIn({required String email}) {
    goRouter.pushNamed(
      AppRouteEnum.signIn.name,
      queryParameters: {"email": email},
    );
  }

  @override
  void goToSignUp({required String email}) {
    goRouter.pushNamed(
      AppRouteEnum.signUp.name,
      queryParameters: {"email": email},
    );
  }
}
