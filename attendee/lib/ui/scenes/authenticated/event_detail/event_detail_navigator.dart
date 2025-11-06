import 'package:attendee/application/base_navigator.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:go_router/go_router.dart';

abstract class EventDetailNavigator extends BaseNavigator {
  void goToBooking({required int id});
}

final class EventDetailNavigatorImplementation implements EventDetailNavigator {
  const EventDetailNavigatorImplementation({required this.goRouter});
  @override
  final GoRouter goRouter;

  @override
  void goToBooking({required int id}) {
    goRouter.pushNamed(
      AppRouteEnum.eventBooking.name,
      pathParameters: {'id': id.toString()},
    );
  }
}
