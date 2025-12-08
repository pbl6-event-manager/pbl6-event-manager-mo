import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:flutter/material.dart';

class TicketLocationSection extends StatelessWidget {
  const TicketLocationSection({super.key, required this.location});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStringConstants.ticket.locationSectionTitle),
        Text(location),
      ],
    );
  }
}
