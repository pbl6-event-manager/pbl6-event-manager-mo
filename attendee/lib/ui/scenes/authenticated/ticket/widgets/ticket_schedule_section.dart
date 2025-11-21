import 'package:attendee/domain/models/ticket_details.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_date_column.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class TicketScheduleSection extends StatelessWidget {
  const TicketScheduleSection({super.key, required this.details});

  final TicketDetail details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStringConstants.ticket.scheduleSectionTitle),
        Row(
          children: [
            Expanded(
              child: TicketDateColumn(
                date: details.startDateTime.dateString,
                time: details.startDateTime.timeString,
              ),
            ),
            Expanded(
              child: TicketDateColumn(
                date: details.endDateTime.dateString,
                time: details.endDateTime.timeString,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
