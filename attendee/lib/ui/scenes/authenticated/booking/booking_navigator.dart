import 'package:attendee/application/base_navigator.dart';
import 'package:attendee/ui/scenes/authenticated/booking/bloc/booking_bloc.dart';
import 'package:attendee/utils/enums/app_route_enum.dart';
import 'package:go_router/go_router.dart';

abstract class BookingNavigator extends BaseNavigator {
  void returnToEventDetail();
  void goToCheckout({required BookingBloc bloc});
}

final class BookingNavigatorImplementation implements BookingNavigator {
  @override
  final GoRouter goRouter;

  const BookingNavigatorImplementation({required this.goRouter});

  @override
  void returnToEventDetail() {
    if (goRouter.canPop()) {
      goRouter.pop();
      return;
    }
    goRouter.goNamed(AppRouteEnum.home.name);
  }

  @override
  void goToCheckout({required BookingBloc bloc}) {
    goRouter.pushNamed(
      AppRouteEnum.checkout.name,
      extra: bloc,
    );
  }
}
