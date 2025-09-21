import "package:attendee/application/base_navigator.dart";
import "package:attendee/utils/enums/app_route_enum.dart";
import "package:bloc/bloc.dart";
import "package:go_router/go_router.dart";

mixin EmailInitialNavigator on BaseNavigator {
  void goToSignIn({required String email});
  void goToSignUp({required String email});
}

class EmailInitialNavigatorImplementation extends Cubit<void>
    implements EmailInitialNavigator {
  @override
  final GoRouter goRouter;
  EmailInitialNavigatorImplementation({required this.goRouter}) : super(null);

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
