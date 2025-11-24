import 'package:attendee/application/base_navigator.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:go_router/src/router.dart';

abstract class CheckoutSuccessNavigator extends BaseNavigator {
  void goToHome();
  void goToTicket();
}

class CheckoutSuccessNavigatorImplementation
    implements CheckoutSuccessNavigator {
  const CheckoutSuccessNavigatorImplementation({required this.goRouter});
  @override
  final GoRouter goRouter;

  @override
  void goToHome() {
    goRouter.goNamed(AppRouteEnum.home.name);
  }

  @override
  void goToTicket() {
    goRouter.goNamed(AppRouteEnum.tickets.name);
  }
}
