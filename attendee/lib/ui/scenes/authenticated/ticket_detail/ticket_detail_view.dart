import 'package:attendee/domain/models/order.dart';
import 'package:attendee/ui/common_widgets/common_ticket_header.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_detail/enums/ticket_option.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_detail/widgets/order_summary_widget.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_detail/widgets/ticket_option_section.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({super.key, required this.order});
  final Order? order;

  @override
  Widget build(BuildContext context) {
    return order == null ? ErrorPage() : TicketDetailView(order: order!);
  }
}

class TicketDetailView extends StatelessWidget {
  const TicketDetailView({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
        ),
        child: ListView(
          children: [
            CommonTicketHeader(
              width: double.infinity,
              containerColor: context.colorPalette.surfaceContainer,
            ),
            OrderSummaryWidget(order: order),
            CommonTicketHeader.bottomUp(
              width: double.infinity,
              containerColor: context.colorPalette.surfaceContainer,
            ),
            const SizedBox(height: 24),
            TicketOptionSection(onOptionTapped: _onTicketOptionTapped),
            const Divider(),
            const SizedBox(height: 24),
            Text(
              AppStringConstants.orders.ticketsTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            ...order.orderDetails.map(
              (detail) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(UIConstants.horizontalPadding),
                  decoration: BoxDecoration(
                    color: context.colorPalette.surfaceContainer,
                    borderRadius: BorderRadius.circular(
                      UIConstants.cornerRadiusBase,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.ticketName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(AppStringConstants.orders.name(detail.name)),
                      Text(AppStringConstants.orders.email(detail.email)),
                      Text(AppStringConstants.orders.ticketId(detail.ticketId)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTicketOptionTapped(TicketOption option) {}
}
