import 'package:attendee/application/base_navigator.dart';
import 'package:attendee/domain/models/ticket_details.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:go_router/go_router.dart';

abstract class TicketsNavigator extends BaseNavigator {
  void goToTicketDetail(TicketDetail detail);
}

final class TicketsNavigatorImplementation implements TicketsNavigator {
  @override
  final GoRouter goRouter;

  const TicketsNavigatorImplementation({required this.goRouter});

  @override
  void goToTicketDetail(TicketDetail detail) {
    goRouter.pushNamed(AppRouteEnum.ticketDetail.name, extra: detail);
  }
}
