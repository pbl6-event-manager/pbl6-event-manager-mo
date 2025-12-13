import 'package:attendee/domain/models/order.dart';
import 'package:attendee/ui/common_widgets/common_ticket_header.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_detail/enums/ticket_option.dart';
import 'package:attendee/ui/scenes/authenticated/ticket_detail/widgets/individual_ticket_widget.dart';
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
            SizedBox(height: 48),
            Text(
              AppStringConstants.orders.ticketsTitle,
              style: context.textPalette.displayMedium,
            ),
            const SizedBox(height: 12),
            ...order.orderDetails.map(
              (detail) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: IndividualTicketWidget(detail: detail),
              ),
            ),
            const Divider(height: 24),
            TicketOptionSection(onOptionTapped: _onTicketOptionTapped),
          ],
        ),
      ),
    );
  }

  void _onTicketOptionTapped(TicketOption option) {}
}
