import 'package:go_router/go_router.dart';
import 'package:organizer/utils/extensions/object_extension.dart';
import 'package:organizer/utils/helpers/base_navigator.dart';
import 'package:organizer/utils/enums/app_router_destination.dart';

abstract class HomeNavigator extends BaseNavigator {
  void goToQRScan();
  void goToTicketDetail({required int ticketId});
  Future<void> goToEventList();
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
  Future<void> goToEventList() async {
    final returnValue = await goRouter.pushNamed(
      AppRouterDestination.eventList.name,
    );
  }
}
