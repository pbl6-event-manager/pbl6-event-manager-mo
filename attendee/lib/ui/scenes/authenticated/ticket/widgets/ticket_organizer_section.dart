import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/ui/common_widgets/organizer_card.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TicketOrganizerSection extends StatelessWidget {
  const TicketOrganizerSection({
    super.key,
    required this.organizer,
    required this.onContactTapped,
    required this.onFollowTapped,
  });

  final Organizer organizer;
  final VoidCallback onContactTapped;
  final VoidCallback onFollowTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStringConstants.ticket.organizerSectionTitle,
          style: context.textPalette.headlineLarge,
        ),
        const SizedBox(height: 16),
        OrganizerCard(
          organizer: organizer,
          onContactTapped: onContactTapped,
          onFollowTapped: onFollowTapped,
        ),
      ],
    );
  }
}
