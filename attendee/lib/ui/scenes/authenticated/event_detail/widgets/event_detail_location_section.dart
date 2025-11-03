import 'package:attendee/ui/scenes/authenticated/event_detail/bloc/event_detail_bloc.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class EventDetailLocationSection extends StatelessWidget {
  const EventDetailLocationSection({
    super.key,
    required this.state,
    required this.onCopyAddressTapped,
  });

  final EventDetailState state;
  final VoidCallback onCopyAddressTapped;

  @override
  Widget build(BuildContext context) {
    final event = state.event;
    if (event?.country == null) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppStringConstants.eventDetail.locationSection,
          style: context.textPalette.headlineLarge,
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event!.address ?? event.cityAndCountryLabel,
                    style: context.textPalette.labelLarge,
                  ),
                  if (event.address != null &&
                      event.cityAndCountryLabel.isNotEmpty)
                    Text(event.cityAndCountryLabel),
                ],
              ),
            ),
            IconButton(
              onPressed: onCopyAddressTapped,
              icon: Icon(Icons.copy),
            ),
          ],
        ),
      ],
    );
  }
}

