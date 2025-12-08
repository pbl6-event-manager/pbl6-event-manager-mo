import 'package:attendee/application/app_router.dart';
import 'package:attendee/domain/models/order.dart';
import 'package:attendee/domain/repositories/order_repository.dart';
import 'package:attendee/ui/scenes/authenticated/tickets/bloc/orders_cubit.dart';
import 'package:attendee/ui/scenes/authenticated/tickets/tickets_navigator.dart';
import 'package:attendee/ui/scenes/authenticated/tickets/widgets/highlight_ticket_item.dart';
import 'package:attendee/ui/scenes/authenticated/tickets/widgets/ticket_item.dart';
import 'package:attendee/ui/scenes/authenticated/tickets/widgets/ticket_list_appbar.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TicketsNavigator>(
      create: (context) => TicketsNavigatorImplementation(
        goRouter: GetIt.instance<AppRouter>().router,
      ),
      child: BlocProvider(
        create: (_) =>
            OrdersCubit(orderRepository: GetIt.instance<OrderRepository>())
              ..fetchOrders(),
        child: const TicketsView(),
      ),
    );
  }
}

class TicketsView extends StatelessWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    final TicketsNavigator navigator = context.read<TicketsNavigator>();
    return Scaffold(
      appBar: TicketListAppbar(),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          switch (state.status) {
            case OrdersStatus.initial:
            case OrdersStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case OrdersStatus.failure:
              return Center(
                child: Text(
                  AppStringConstants.orders.failedToLoadOrders,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            case OrdersStatus.success:
              if (state.orders.isEmpty) {
                return Center(
                  child: Text(
                    AppStringConstants.orders.noOrdersFound,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                );
              }
              return ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 36),
                padding: EdgeInsets.symmetric(
                  horizontal: UIConstants.horizontalPadding,
                  vertical: 32,
                ),
                itemBuilder: (context, index) {
                  final Order order = state.orders[index];
                  if (index == 0) {
                    return HighlightTicketItem(
                      context: context,
                      order: order,
                      onTicketTapped: () =>
                          _onTicketTapped(navigator, order: order),
                    );
                  }
                  return TicketItem(
                    context: context,
                    order: order,
                    onTicketTapped: () =>
                        _onTicketTapped(navigator, order: order),
                  );
                },
                itemCount: state.orders.length,
              );
          }
        },
      ),
    );
  }

  void _onTicketTapped(TicketsNavigator navigator, {required Order order}) {
    navigator.goToTicketDetail(order);
  }
}
