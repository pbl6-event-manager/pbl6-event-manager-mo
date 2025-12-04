import 'package:go_router/go_router.dart';
import 'package:organizer/utils/constants/helpers/base_navigator.dart';
import 'package:organizer/utils/enums/app_router_destination.dart';

abstract class HomeNavigator extends BaseNavigator {
  void goToQRScan();
  void goToTicketDetail({required int ticketId});
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
}
