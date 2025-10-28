import "package:attendee/application/base_navigator.dart";
import "package:attendee/utils/enums/app_route_enum.dart";
import "package:go_router/go_router.dart";

abstract class AccountSettingNavigator extends BaseNavigator {
  void goToPassword();
  void goBackToAccount({
    required String? firstName,
    required String? lastName,
    required String? phoneNumber,
    required String? profilePhoto,
  });
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

  @override
  void goBackToAccount({
    required String? firstName,
    required String? lastName,
    required String? phoneNumber,
    required String? profilePhoto,
  }) {
    goRouter.pop((
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      profilePhoto: profilePhoto,
    ));
  }
}
