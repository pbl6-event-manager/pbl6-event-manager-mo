import 'package:flutter/material.dart';
import 'package:organizer/ui/common_widgets/check_in_button.dart';
import 'package:organizer/ui/common_widgets/error_view.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/constants/ui_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';
import 'package:organizer/utils/extensions/datetime_extension.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({super.key, required this.ticketId});

  final int? ticketId;
  // TODO: Add ticket object here

  @override
  Widget build(BuildContext context) {
    return ticketId != null ? const TicketDetailView() : ErrorPage();
  }
}

class TicketDetailView extends StatelessWidget {
  const TicketDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle largeSubtitle = context.textPalette.subtitleLarge.copyWith(
      fontSize: 13,
    );
    return Scaffold(
      backgroundColor: context.colorPalette.surfaceContainer,
      // TODO: Remove dummy data
      bottomNavigationBar: _buildBottomCheckinButton(
        context,
        isCheckedIn: false,
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

                    Text('Huy Tran', style: context.textPalette.displayLarge),

                    SizedBox(height: 32),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _buildDataEntry(
                            context,
                            title: AppStringConstant.ticket.orderNumberLabel,
                            content: '12673i367826328',
                          ),
                        ),
                        Expanded(
                          child: _buildDataEntry(
                            context,
                            title: AppStringConstant.ticket.ticketTypeLabel,
                            content: 'Ticket type',
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    _buildDataEntry(
                      context,
                      title: AppStringConstant.ticket.checkedInLabel,
                      content: DateTime.now().string,
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
