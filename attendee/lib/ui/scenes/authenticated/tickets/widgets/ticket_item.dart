import 'package:attendee/domain/models/order.dart';
import 'package:attendee/ui/common_widgets/common_ticket_header.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:attendee/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({
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
    return Column(
      children: [
        CommonTicketHeader(
          width: double.infinity,
          containerColor: context.colorPalette.surfaceContainer,
        ),

        InkWell(
          onTap: onTicketTapped,
          borderRadius: BorderRadius.circular(UIConstants.cornerRadiusBase),
          child: Ink(
            decoration: BoxDecoration(
              color: context.colorPalette.surfaceContainer,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(UIConstants.cornerRadiusBase),
                bottomRight: Radius.circular(UIConstants.cornerRadiusBase),
              ),
            ),

            padding: EdgeInsets.only(
              left: UIConstants.horizontalPadding,
              right: UIConstants.horizontalPadding,
              bottom: 16,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStringConstants.orders.orderNumber(order.id),
                      style: context.textPalette.labelLarge,
                    ),
                    Text(
                      AppStringConstants.orders.status(
                        order.status.name.toUpperCase(),
                      ),
                    ),
                    Text(
                      AppStringConstants.orders.total(
                        order.totalAmount.withCurrency,
                      ),
                    ),
                    if (order.appliedVoucherCode != null)
                      Text(
                        AppStringConstants.orders.voucher(
                          order.appliedVoucherCode!,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
