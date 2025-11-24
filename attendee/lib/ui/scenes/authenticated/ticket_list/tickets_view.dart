import 'package:attendee/application/app_router.dart';
import 'package:attendee/domain/models/ticket_details.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_list/tickets_navigator.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_list/widgets/highlight_ticket_item.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_list/widgets/ticket_item.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_list/widgets/ticket_list_appbar.dart';
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
      child: const TicketsView(),
    );
  }
}

class TicketsView extends StatelessWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TicketDetail> ticketDetails = TicketDetail.dummyData;
    final TicketsNavigator navigator = context.read<TicketsNavigator>();
    return Scaffold(
      appBar: TicketListAppbar(),
      body: ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(height: 36),
        padding: EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
          vertical: 32,
        ),
        itemBuilder: (context, index) {
          final detail = ticketDetails[index];
          if (index == 0) {
            return HighlightTicketItem(
              context: context,
              detail: detail,
              onTicketTapped: () => _onTicketTapped(navigator, detail: detail),
            );
          }
          return TicketItem(
            context: context,
            detail: detail,
            onTicketTapped: () => _onTicketTapped(navigator, detail: detail),
          );
        },
        itemCount: ticketDetails.length,
      ),
    );
  }

  void _onTicketTapped(
    TicketsNavigator navigator, {
    required TicketDetail detail,
  }) {
    navigator.goToTicketDetail(detail);
  }
}
