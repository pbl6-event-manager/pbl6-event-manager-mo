import "package:attendee/application/base_navigator.dart";
import "package:attendee/utils/enums/app_route_enum.dart";
import "package:go_router/go_router.dart";

abstract class AccountSettingNavigator extends BaseNavigator {
  void goToPassword();
}

final class AccountSettingNavigatorImplementation
    implements AccountSettingNavigator {
  @override
  final GoRouter goRouter;

  const AccountSettingNavigatorImplementation({required this.goRouter});

  @override
  void goToPassword() {
    goRouter.pushNamed(AppRouteEnum.accountSettingPassword.name);
  }
}
