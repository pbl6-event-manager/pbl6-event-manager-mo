import "package:attendee/application/base_navigator.dart";
import "package:go_router/go_router.dart";

abstract class HomeSearchNavigator extends BaseNavigator {
  void returnToHome({
    required String? eventQuery,
    required String? locationQuery,
  });
}

final class HomeSearchNavigatorImplementation implements HomeSearchNavigator {
  @override
  const HomeSearchNavigatorImplementation({required this.goRouter});
  @override
  final GoRouter goRouter;

  @override
  void returnToHome({
    required String? eventQuery,
    required String? locationQuery,
  }) {
    final (String?, String?)? returnValue =
        (eventQuery != null || locationQuery != null)
        ? (eventQuery, locationQuery)
        : null;
    goRouter.pop(returnValue);
  }
}
