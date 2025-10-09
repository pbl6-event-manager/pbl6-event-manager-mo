import "package:attendee/application/base_navigator.dart";
import "package:go_router/go_router.dart";

abstract class HomeFilterNavigator extends BaseNavigator {
  void returnToHome({required (DateTime?, DateTime?, Set<int>)? filterData});
}

final class HomeFilterNavigatorImplementation implements HomeFilterNavigator {
  @override
  const HomeFilterNavigatorImplementation({required this.goRouter});
  @override
  final GoRouter goRouter;

  @override
  void returnToHome({required (DateTime?, DateTime?, Set<int>)? filterData}) {
    goRouter.pop(filterData);
  }
}
