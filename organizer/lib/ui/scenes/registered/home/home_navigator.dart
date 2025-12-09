import 'package:go_router/go_router.dart';
import 'package:organizer/domain/models/event.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/utils/enums/app_router_destination.dart';
import 'package:organizer/utils/extensions/object_extension.dart';
import 'package:organizer/utils/helpers/base_navigator.dart';

abstract class HomeNavigator extends BaseNavigator {
  Future<bool?> goToQRScan();
  void goToTicketDetail({required Attendee attendee});
  Future<void> goToEventList({
    required void Function(Event event) onEventReturned,
  });
}

final class HomeNavigatorImpl implements HomeNavigator {
  @override
  final GoRouter goRouter;

  const HomeNavigatorImpl({required this.goRouter});

  @override
  Future<bool?> goToQRScan() {
    return goRouter.pushNamed<bool>(AppRouterDestination.scanQr.name);
  }

  @override
  void goToTicketDetail({required Attendee attendee}) {
    goRouter.pushNamed(AppRouterDestination.ticketDetail.name, extra: attendee);
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
