import 'package:attendee/domain/models/event.dart';
import 'package:attendee/ui/common_widgets/event_widget.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/bloc/event_detail_bloc.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EventDetailRelatedEventsSection extends StatelessWidget {
  const EventDetailRelatedEventsSection({
    super.key,
    required this.state,
    required this.onRelatedEventTapped,
  });

  final EventDetailState state;
  final void Function(Event event) onRelatedEventTapped;

  @override
  Widget build(BuildContext context) {
    final relatedEvents = state.suggestedEvents;

    // Hide section on error or if empty data
    if (relatedEvents.hasError ||
        (relatedEvents.hasValue && relatedEvents.valueOrNull!.isEmpty)) {
      return SizedBox.shrink();
    }

    final events = relatedEvents.valueOrNull ?? [];
    final isLoading = relatedEvents.isLoading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 32),
        Text(
          AppStringConstants.eventDetail.relatedEventsSection,
          style: context.textPalette.headlineLarge,
        ),
        SizedBox(height: 20),
        Skeletonizer(
          enabled: isLoading,
          child: Column(
            children: List.generate(
              isLoading ? 3 : events.length,
              (index) => _buildRelatedEventItem(
                index,
                events: events,
                length: isLoading ? 3 : events.length,
                isLoading: isLoading,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedEventItem(
    int index, {
    required List<Event> events,
    required int length,
    required bool isLoading,
  }) {
    // Use dummy event for skeleton loading
    final event = isLoading ? Event.dummyEvent : events[index];

    return Padding(
      padding: EdgeInsets.only(bottom: index < length - 1 ? 28 : 0),
      child: EventWidget.compact(
        isLoading: isLoading,
        event: event,
        onTapped: isLoading ? () {} : () => onRelatedEventTapped(event),
      ),
    );
  }
}

