import 'package:attendee/application/base_navigator.dart';
import 'package:attendee/domain/models/user.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

abstract class AccountNavigator extends BaseNavigator {
  Future<void> goToAccountSetting({
    required User? user,
    required void Function(
      ({
        String? firstName,
        String? lastName,
        String? phoneNumber,
        XFile? profilePhoto,
      })
      userUpdateData,
    )
    onReloadNeeded,
  });
}

final class AccountNavigatorImplementation implements AccountNavigator {
  @override
  final GoRouter goRouter;

  const AccountNavigatorImplementation({required this.goRouter});

  @override
  Future<void> goToAccountSetting({
    required User? user,
    required void Function(
      ({
        String? firstName,
        String? lastName,
        String? phoneNumber,
        XFile? profilePhoto,
      })
      userUpdateData,
    )
    onReloadNeeded,
  }) async {
    final dynamic userUpdateData = await goRouter.pushNamed(
      AppRouteEnum.accountSetting.name,
      extra: user,
    );

    if (userUpdateData
        is ({
          String? firstName,
          String? lastName,
          String? phoneNumber,
          XFile? profilePhoto,
        })) {
      onReloadNeeded(userUpdateData);
    }
    // if (needReload == true) {
    //   onReloadNeeded();
    // }
  }
}
