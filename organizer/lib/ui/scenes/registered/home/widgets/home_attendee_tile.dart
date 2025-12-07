import 'package:flutter/material.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomeAttendeeTile extends StatelessWidget {
  final int orderId;
  final int ticketId;
  final String attendeeName;
  final String ticketName;
  final String email;
  final VoidCallback onTap;

  const HomeAttendeeTile({
    super.key,
    required this.orderId,
    required this.ticketId,
    required this.attendeeName,
    required this.ticketName,
    required this.email,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: Text(
        AppStringConstant.ticket.orderBadgeLabel(orderId),
        style: context.textPalette.bodyLarge.copyWith(
          color: context.colorPalette.textPlaceholder,
        ),
      ),
      title: Text(attendeeName, style: context.textPalette.headlineLarge),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStringConstant.ticket.ticketSummaryLabel(ticketName, ticketId),
            style: context.textPalette.bodyLarge.copyWith(
              color: context.colorPalette.textPlaceholder,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: context.textPalette.bodyLarge,
          ),
        ],
      ),
    );
  }
}
