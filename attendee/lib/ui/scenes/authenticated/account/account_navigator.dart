import "package:attendee/application/base_navigator.dart";
import "package:attendee/domain/models/user.dart";
import "package:attendee/utils/enums/app_route_enum.dart";
import "package:go_router/go_router.dart";

abstract class AccountNavigator extends BaseNavigator {
  Future<void> goToAccountSetting({
    required User? user,
    required void Function() onReloadNeeded,
  });
}

final class AccountNavigatorImplementation implements AccountNavigator {
  @override
  final GoRouter goRouter;

  const AccountNavigatorImplementation({required this.goRouter});

  @override
  Future<void> goToAccountSetting({
    required User? user,
    required void Function() onReloadNeeded,
  }) async {
    final needReload = await goRouter.pushNamed(
      AppRouteEnum.accountSetting.name,
      extra: user,
    );
    if (needReload == true) {
      onReloadNeeded();
    }
  }
}
