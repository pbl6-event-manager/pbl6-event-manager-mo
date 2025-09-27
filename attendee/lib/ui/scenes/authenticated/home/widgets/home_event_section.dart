import "package:attendee/ui/common_widgets/event_widget.dart";
import "package:flutter/material.dart";

/// A section of events, using [EventWidget]
class HomeEventSection extends StatelessWidget {
  HomeEventSection({super.key, this.isLoading = false}) : _isCompact = false;

  HomeEventSection.compact({super.key, this.isLoading = false})
    : _isCompact = true;

  // TODO: Replace dummy data
  final List<String> data = List.filled(5, "Data");
  final bool _isCompact;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: data.length,
      itemBuilder: (context, index) => _isCompact
          ? EventWidget.compact(isLoading: isLoading)
          : EventWidget(isLoading: isLoading),
      separatorBuilder: (context, index) => const SizedBox(height: 28),
    );
  }
}
