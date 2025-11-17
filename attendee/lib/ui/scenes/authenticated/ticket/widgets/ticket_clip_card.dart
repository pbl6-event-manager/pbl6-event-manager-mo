import 'package:attendee/ui/scenes/authenticated/ticket/ticket_details.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_header.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_location_section.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_qr_section.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_schedule_section.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.details,
    required this.onQrPageChanged,
  });

  final TicketDetails details;
  final ValueChanged<int> onQrPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorPalette.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TicketHeader(details: details),
            if (details.qrCodeImageUrl.isNotEmpty)
              TicketQrSection(
                imageUrls: details.qrCodeImageUrl,
                onPageChanged: onQrPageChanged,
              ),
            const SizedBox(height: 16),
            TicketScheduleSection(details: details),
            const SizedBox(height: 16),
            TicketLocationSection(location: details.location),
          ],
        ),
      ),
    );
  }
}
