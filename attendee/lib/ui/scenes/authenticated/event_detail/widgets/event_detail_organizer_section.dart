import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/bloc/event_detail_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/organizer_card.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetailOrganizerSection extends StatelessWidget {
  const EventDetailOrganizerSection({
    super.key,
    required this.state,
    required this.onContactTapped,
    required this.onFollowTapped,
  });

  final EventDetailState state;
  final VoidCallback onContactTapped;
  final VoidCallback onFollowTapped;

  @override
  Widget build(BuildContext context) {
    if (state.organizer.hasError) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 32),
        Text(
          AppStringConstants.eventDetail.organizerSection,
          style: context.textPalette.headlineLarge,
        ),
        SizedBox(height: 12),
        Skeletonizer(
          enabled: state.organizer.isLoading,
          child: OrganizerCard(
            organizer: state.organizer.valueOrNull ?? Organizer.dummyOrganizer,
            onContactTapped: onContactTapped,
            onFollowTapped: onFollowTapped,
          ),
        ),
      ],
    );
  }
}

