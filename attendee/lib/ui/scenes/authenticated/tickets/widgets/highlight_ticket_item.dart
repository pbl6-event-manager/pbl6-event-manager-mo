import 'package:attendee/domain/models/order.dart';
import 'package:attendee/ui/common_widgets/common_ticket_header.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class HighlightTicketItem extends StatelessWidget {
  const HighlightTicketItem({
    super.key,
    required this.context,
    required this.order,
    required this.onTicketTapped,
  });

  final BuildContext context;
  final Order order;
  final VoidCallback onTicketTapped;

  @override
  Widget build(BuildContext context) {
    final Radius topRadius = Radius.circular(UIConstants.cornerRadiusBase);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonTicketHeader(
          width: double.infinity,
          containerColor: context.colorPalette.surfaceContainer,
        ),

        InkWell(
          onTap: onTicketTapped,
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: UIConstants.horizontalPadding,
            ),
            decoration: BoxDecoration(
              color: context.colorPalette.surfaceContainer,
              borderRadius: BorderRadius.only(
                topLeft: topRadius,
                topRight: topRadius,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.createdAt.dateStringWithoutYear,
                              style: context.textPalette.labelLarge,
                            ),
                            Text(order.createdAt.timeString),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              order.orderDetails.length.toString(),
                              style: context.textPalette.bodyLarge,
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.confirmation_number_outlined),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppStringConstants.orders.orderNumber(order.id),
                      style: context.textPalette.displaySmall,
                    ),
                    Text(
                      AppStringConstants.orders.status(
                        order.status.name.toUpperCase(),
                      ),
                      style: context.textPalette.bodyLarge,
                    ),
                    Text(AppStringConstants.orders.total(order.totalAmount)),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        CommonTicketHeader.bottomUp(
          width: double.infinity,
          containerColor: context.colorPalette.surfaceContainer,
        ),
      ],
    );
  }
}
