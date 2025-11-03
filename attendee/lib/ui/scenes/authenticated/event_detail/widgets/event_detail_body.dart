import 'package:attendee/domain/models/event.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/bloc/event_detail_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/event_detail_general_info_widget.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_location_section.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_organizer_section.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_overview_section.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_related_events_section.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetailBody extends StatelessWidget {
  const EventDetailBody({
    super.key,
    required this.state,
    required this.onCopyAddressTapped,
    required this.onContactTapped,
    required this.onFollowTapped,
    required this.onRelatedEventTapped,
  });

  final EventDetailState state;
  final VoidCallback onCopyAddressTapped;
  final VoidCallback onContactTapped;
  final VoidCallback onFollowTapped;
  final void Function(Event event) onRelatedEventTapped;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: state.status == ViewStatusEnum.loading,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EventDetailGeneralInfoWidget(
              title: state.event?.title,
              city: state.event?.city,
              address: state.event?.address,
              date: state.event?.date,
            ),
            Divider(height: 32),
            EventDetailOverviewSection(state: state),
            EventDetailLocationSection(
              state: state,
              onCopyAddressTapped: onCopyAddressTapped,
            ),
            EventDetailOrganizerSection(
              state: state,
              onContactTapped: onContactTapped,
              onFollowTapped: onFollowTapped,
            ),
            EventDetailRelatedEventsSection(
              state: state,
              onRelatedEventTapped: onRelatedEventTapped,
            ),
          ],
        ),
      ),
    );
  }
}
