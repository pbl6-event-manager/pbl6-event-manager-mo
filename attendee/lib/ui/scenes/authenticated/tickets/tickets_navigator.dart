import 'package:attendee/application/base_navigator.dart';
import 'package:attendee/domain/models/order.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:go_router/go_router.dart';

abstract class TicketsNavigator extends BaseNavigator {
  void goToTicketDetail(Order order);
}

final class TicketsNavigatorImplementation implements TicketsNavigator {
  @override
  final GoRouter goRouter;

  const TicketsNavigatorImplementation({required this.goRouter});

  @override
  void goToTicketDetail(Order order) {
    goRouter.pushNamed(AppRouteEnum.ticketDetail.name, extra: order);
  }
}
