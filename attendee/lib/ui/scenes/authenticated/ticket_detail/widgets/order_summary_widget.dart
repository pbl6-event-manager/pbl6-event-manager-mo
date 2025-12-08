import 'package:attendee/domain/models/order.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({super.key, required this.order});

  final Order order;

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
          Text(
            AppStringConstants.orders.orderNumber(order.id),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            AppStringConstants.orders.status(order.status.name.toUpperCase()),
          ),
          Text(AppStringConstants.orders.created(order.createdAt.dateString)),
          Text(AppStringConstants.orders.updated(order.updatedAt.dateString)),
          Text(AppStringConstants.orders.total(order.totalAmount)),
          Text(
            AppStringConstants.orders.subtotal(order.totalAmountBeforeVoucher),
          ),
          if (order.appliedVoucherCode != null)
            Text(AppStringConstants.orders.voucher(order.appliedVoucherCode!)),
          Text(AppStringConstants.orders.eventId(order.eventId)),
          Text(
            AppStringConstants.orders.ticketsCount(order.orderDetails.length),
          ),
        ],
      ),
    );
  }
}
