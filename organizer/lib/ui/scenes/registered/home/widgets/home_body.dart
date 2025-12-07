import 'package:flutter/material.dart';
import 'package:organizer/domain/models/order_attendee.dart';
import 'package:organizer/ui/scenes/registered/home/bloc/home_bloc.dart';
import 'package:organizer/ui/scenes/registered/home/widgets/home_attendee_tile.dart';
import 'package:organizer/ui/scenes/registered/home/widgets/home_empty_state.dart';
import 'package:organizer/ui/scenes/registered/home/widgets/home_error_state.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/enums/view_status.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomeBody extends StatelessWidget {
  final HomeState state;
  final ValueChanged<OrderAttendee> onTicketTapped;
  final Future<void> Function()? onRefresh;

  const HomeBody({
    super.key,
    required this.state,
    required this.onTicketTapped,
    this.onRefresh,
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

    if (state.attendees.isEmpty) {
      return Center(
        child: Text(
          AppStringConstant.home.noAttendeesLabel,
          style: context.textPalette.bodyLarge,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, index) =>
            Divider(color: context.colorPalette.divider, height: 0),
        itemCount: state.attendees.length,
        itemBuilder: (context, index) {
          final attendee = state.attendees[index];
          return HomeAttendeeTile(
            orderId: attendee.orderId,
            ticketId: attendee.ticketId,
            attendeeName:
                attendee.attendeeName ??
                AppStringConstant.ticket.unknownAttendeeLabel,
            ticketName:
                attendee.ticketName ??
                AppStringConstant.ticket.unknownTicketLabel,
            email: attendee.email ?? AppStringConstant.ticket.noEmailShortLabel,
            onTap: () => onTicketTapped(attendee),
          );
        },
      ),
    );
  }
}
