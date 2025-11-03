import 'package:attendee/ui/scenes/authenticated/event_detail/bloc/event_detail_bloc.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class EventDetailOverviewSection extends StatelessWidget {
  const EventDetailOverviewSection({
    super.key,
    required this.state,
  });

  final EventDetailState state;

  @override
  Widget build(BuildContext context) {
    if (state.event?.summary == null || state.event!.summary!.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStringConstants.eventDetail.overviewSection,
          style: context.textPalette.headlineLarge,
        ),
        SizedBox(height: 8),
        Text(state.event!.summary!, style: context.textPalette.bodyLarge),
        Divider(height: 32),
      ],
    );
  }
}

