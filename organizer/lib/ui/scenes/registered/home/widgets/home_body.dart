import 'package:flutter/material.dart';
import 'package:organizer/ui/scenes/registered/home/bloc/home_bloc.dart';
import 'package:organizer/ui/scenes/registered/home/widgets/home_attendee_tile.dart';
import 'package:organizer/ui/scenes/registered/home/widgets/home_empty_state.dart';
import 'package:organizer/ui/scenes/registered/home/widgets/home_error_state.dart';
import 'package:organizer/utils/enums/view_status.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomeBody extends StatelessWidget {
  final HomeState state;
  final ValueChanged<int> onTicketTapped;
  final ValueChanged<int> onCheckinTapped;

  const HomeBody({
    super.key,
    required this.state,
    required this.onTicketTapped,
    required this.onCheckinTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (state.status == ViewStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == ViewStatus.failure) {
      return HomeErrorState(message: state.errorMessage);
    }

    if (state.event == null) {
      return const HomeEmptyState();
    }

    final List<(String, bool)> attendees = _generateDummyAttendees();

    return ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(color: context.colorPalette.divider, height: 0),
      itemCount: attendees.length,
      itemBuilder: (context, index) {
        final attendee = attendees[index];
        return HomeAttendeeTile(
          ticketId: index,
          attendeeName: attendee.$1,
          isReserved: attendee.$2,
          onTap: () => onTicketTapped(index),
          onCheckinTapped: () => onCheckinTapped(index),
        );
      },
    );
  }
}

// TODO: Replace with real attendees data when available.
List<(String, bool)> _generateDummyAttendees() =>
    List.generate(32, (index) => ('Attendee #$index', index % 4 == 0));
