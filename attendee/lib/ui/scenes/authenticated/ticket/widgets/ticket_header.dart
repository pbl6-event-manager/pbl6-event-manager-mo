import 'package:attendee/ui/common_widgets/common_image_widget.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/ticket_details.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class TicketHeader extends StatelessWidget {
  const TicketHeader({super.key, required this.details});

  final TicketDetails details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          details.startDateTime.dateStringWithoutYear,
          style: context.textPalette.labelLarge,
        ),
        Text(details.startDateTime.timeString),
        const SizedBox(height: 16),
        Row(
          children: [
            Flexible(
              child: CommonImageWidget(
                imageUrl: details.eventImageUrl ?? '',
                aspectRatio: 1,
                height: 90,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                details.eventName,
                style: context.textPalette.headlineSmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
