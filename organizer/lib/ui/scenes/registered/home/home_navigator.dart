import 'package:go_router/go_router.dart';
import 'package:organizer/domain/models/event.dart';
import 'package:organizer/utils/extensions/object_extension.dart';
import 'package:organizer/utils/helpers/base_navigator.dart';
import 'package:organizer/utils/enums/app_router_destination.dart';

abstract class HomeNavigator extends BaseNavigator {
  void goToQRScan();
  void goToTicketDetail({required int ticketId});
  Future<void> goToEventList({
    required void Function(Event event) onEventReturned,
  });
}

final class HomeNavigatorImpl implements HomeNavigator {
  @override
  final GoRouter goRouter;

  const HomeNavigatorImpl({required this.goRouter});

  @override
  void goToQRScan() {
    goRouter.pushNamed(AppRouterDestination.scanQr.name);
  }

  @override
  void goToTicketDetail({required int ticketId}) {
    goRouter.pushNamed(
      AppRouterDestination.ticketDetail.name,
      pathParameters: {'id': ticketId.toString()},
    );
  }

  @override
  Future<void> goToEventList({
    required void Function(Event event) onEventReturned,
  }) async {
    final returnValue = await goRouter.pushNamed(
      AppRouterDestination.eventList.name,
    );

    final Event? event = returnValue?.tryCast<Event>();

    if (event != null) {
      onEventReturned(event);
    }
  }
}
