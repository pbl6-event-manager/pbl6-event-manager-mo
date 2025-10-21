import "package:attendee/application/base_navigator.dart";
import "package:go_router/go_router.dart";

abstract class HomeSearchNavigator extends BaseNavigator {
  void returnToHome({
    required String? eventQuery,
    required String? locationQuery,
    required bool isUsingCurrentLocation,
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
    required bool isUsingCurrentLocation,
  }) {
    final (String?, String?, bool) returnValue = (
      eventQuery,
      locationQuery,
      isUsingCurrentLocation,
    );
    goRouter.pop(returnValue);
  }
}
