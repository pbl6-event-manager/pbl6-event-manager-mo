import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/domain/models/ticket_details.dart';
import 'package:attendee/ui/common_widgets/common_ticket_header.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/enums/ticket_option.dart';

import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_clip_card.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_option_section.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_organizer_section.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({super.key, required this.ticketDetail});
  final TicketDetail? ticketDetail;

  @override
  Widget build(BuildContext context) {
    return ticketDetail == null
        ? ErrorPage()
        : TicketDetailView(ticketDetail: ticketDetail!);
  }
}

class TicketDetailView extends StatefulWidget {
  const TicketDetailView({super.key, required this.ticketDetail});

  final TicketDetail ticketDetail;

  @override
  State<TicketDetailView> createState() => _TicketDetailViewState();
}

class _TicketDetailViewState extends State<TicketDetailView> {
  late final ValueNotifier<int> pageIndexNotifier = ValueNotifier<int>(0);

  Organizer? get organizer => Organizer.dummyOrganizer;

  @override
  void dispose() {
    pageIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
        ),
        child: ListView(
          children: [
            CommonTicketHeader(
              width: double.infinity,

              containerColor: context.colorPalette.surfaceContainer,
            ),
            TicketCard(
              details: widget.ticketDetail,
              onQrPageChanged: _onPageChanged,
              pageIndexNotifier: pageIndexNotifier,
            ),
            CommonTicketHeader.bottomUp(
              width: double.infinity,
              containerColor: context.colorPalette.surfaceContainer,
            ),
            const SizedBox(height: 32),
            TicketOptionSection(onOptionTapped: _onTicketOptionTapped),
            const Divider(),
            const SizedBox(height: 32),
            if (organizer != null)
              TicketOrganizerSection(
                organizer: organizer!,
                onContactTapped: _onContactTapped,
                onFollowTapped: _onFollowTapped,
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _onContactTapped() {}

  void _onFollowTapped() {}

  void _onPageChanged(int value) {
    pageIndexNotifier.value = value;
  }

  void _onTicketOptionTapped(TicketOption option) {}
}
