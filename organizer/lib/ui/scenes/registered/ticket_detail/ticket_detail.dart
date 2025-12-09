import 'package:flutter/material.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/ui/common_widgets/check_in_button.dart';
import 'package:organizer/ui/common_widgets/error_view.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/constants/ui_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({super.key, this.attendee});

  final Attendee? attendee;

  @override
  Widget build(BuildContext context) {
    return attendee != null ? TicketDetailView(attendee: attendee!) : ErrorPage();
  }
}

class TicketDetailView extends StatelessWidget {
  const TicketDetailView({super.key, required this.attendee});

  final Attendee attendee;

  @override
  Widget build(BuildContext context) {
    TextStyle largeSubtitle = context.textPalette.subtitleLarge.copyWith(
      fontSize: 13,
    );
    return Scaffold(
      backgroundColor: context.colorPalette.surfaceContainer,
      bottomNavigationBar: _buildBottomCheckinButton(
        context,
        isCheckedIn: attendee.isCheckedIn,
        onCheckinTapped: () {},
      ),
      body: RefreshIndicator(
        onRefresh: _onRefreshed,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: context.colorPalette.secondary,
              title: Text(
                AppStringConstant.ticket.attendeeDetailsTitle,
                style: context.textPalette.headlineLarge.copyWith(
                  color: context.colorPalette.invertedText,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: UIConstant.horizontalPadding,
                  vertical: 24,
                ),
                color: context.colorPalette.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStringConstant.ticket.attendeeLabel,
                      style: largeSubtitle,
                    ),
                    SizedBox(height: 6),
                    Text(
                      attendee.fullName,
                      style: context.textPalette.displayLarge,
                    ),
                    SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildDataEntry(
                            context,
                            title: AppStringConstant.ticket.ticketTypeLabel,
                            content: attendee.ticketName,
                          ),
                        ),
                        Expanded(
                          child: _buildDataEntry(
                            context,
                            title: 'Ticket price',
                            content: attendee.ticketPrice,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildDataEntry(
                      context,
                      title: AppStringConstant.ticket.attendeeEmailLabel,
                      content: attendee.email,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataEntry(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textPalette.subtitleLarge.copyWith(fontSize: 13),
        ),
        Text(content, style: context.textPalette.bodyLarge),
      ],
    );
  }

  Widget _buildBottomCheckinButton(
    BuildContext context, {
    required bool isCheckedIn,
    required VoidCallback? onCheckinTapped,
  }) {
    return Container(
      color: context.colorPalette.surface,
      padding: EdgeInsets.symmetric(
        horizontal: UIConstant.horizontalPadding,
        vertical: 16,
      ),
      child: CheckInButton(isReserved: isCheckedIn, onTapped: onCheckinTapped),
    );
  }

  Future<void> _onRefreshed() async {}
}
