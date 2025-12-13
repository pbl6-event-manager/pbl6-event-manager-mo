import 'package:attendee/domain/models/order_detail.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/widgets.dart';

class IndividualTicketWidget extends StatelessWidget {
  const IndividualTicketWidget({super.key, required this.detail});

  final OrderDetail detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UIConstants.horizontalPadding),
      decoration: BoxDecoration(
        color: context.colorPalette.surfaceContainer,
        borderRadius: BorderRadius.circular(UIConstants.cornerRadiusBase),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(detail.ticketName, style: context.textPalette.headlineSmall),
          const SizedBox(height: 4),
          Text(AppStringConstants.orders.name(detail.name)),
          Text(AppStringConstants.orders.email(detail.email)),
          Text(AppStringConstants.orders.ticketId(detail.ticketId)),
        ],
      ),
    );
  }
}
