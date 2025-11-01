import 'package:attendee/domain/models/event.dart';
import 'package:attendee/ui/common_widgets/event_widget.dart';
import 'package:flutter/material.dart';

/// A section of events, using [EventWidget]
class HomeEventSection extends StatelessWidget {
  const HomeEventSection({
    super.key,
    this.isLoading = false,
    required this.events,
    required this.onTapped,
  }) : _isCompact = false;

  const HomeEventSection.compact({
    super.key,
    this.isLoading = false,
    required this.events,
    required this.onTapped,
  }) : _isCompact = true;

  final List<Event> events;
  final bool _isCompact;
  final bool isLoading;

  final ValueChanged<Event> onTapped;

  @override
  Widget build(BuildContext context) {
    // Show skeleton loaders when loading
    final displayEvents = isLoading
        ? List.filled(5, const Event(id: 0))
        : events;

    return SliverList.separated(
      itemCount: displayEvents.length,
      itemBuilder: (context, index) => _isCompact
          ? EventWidget.compact(
              onTapped: () => onTapped(displayEvents[index]),
              isLoading: isLoading,
              event: displayEvents[index],
            )
          : EventWidget(
              isLoading: isLoading,
              event: displayEvents[index],
              onTapped: () => onTapped(displayEvents[index]),
            ),
      separatorBuilder: (context, index) => const SizedBox(height: 28),
    );
  }
}
