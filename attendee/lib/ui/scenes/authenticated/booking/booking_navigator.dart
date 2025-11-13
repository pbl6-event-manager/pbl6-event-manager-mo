import 'package:attendee/application/base_navigator.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:go_router/go_router.dart';

abstract class BookingNavigator extends BaseNavigator {
  void returnToEventDetail();
}

final class BookingNavigatorImplementation implements BookingNavigator {
  @override
  final GoRouter goRouter;

  const BookingNavigatorImplementation({required this.goRouter});

  @override
  void returnToEventDetail() {
    if (goRouter.canPop()) {
      goRouter.pop();
      return;
    }

    goRouter.goNamed(AppRouteEnum.home.name);
  }
}
