import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/domain/models/ticket_details.dart';
import 'package:attendee/ui/common_widgets/ticket_header.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/enums/ticket_option.dart';

import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_clip_card.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_option_section.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/widgets/ticket_organizer_section.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TicketView();
  }
}

class TicketView extends StatelessWidget {
  const TicketView({super.key});

  Organizer? get organizer => Organizer.dummyOrganizer;

  TicketDetail get ticketDetails => TicketDetail(
    startDateTime: DateTime.now(),
    endDateTime: DateTime.now(),
    location:
        'Location!fasdjjklfhdaslkjfhasklfhaslkfhaslkdfhdalskfhaslkfhadslkj',
    eventImageUrl:
        'https://images.unsplash.com/photo-1763307411477-6bb3254f1496?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    eventName: 'Event name goes here',
    qrCodeImageUrl: const [
      'https://docs.lightburnsoftware.com/legacy/img/QRCode/ExampleCode.png',
    ],
  );

  @override
  Widget build(BuildContext context) {
    final ticketDetails = this.ticketDetails;
    final organizerData = organizer ?? Organizer.dummyOrganizer;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
        ),
        child: ListView(
          children: [
            TicketHeader(
              width: double.infinity,

              containerColor: context.colorPalette.surfaceContainer,
            ),
            TicketCard(details: ticketDetails, onQrPageChanged: _onPageChanged),
            TicketHeader.bottomUp(
              width: double.infinity,
              containerColor: context.colorPalette.surfaceContainer,
            ),
            const SizedBox(height: 32),
            TicketOptionSection(onOptionTapped: _onTicketOptionTapped),
            const Divider(),
            const SizedBox(height: 32),
            TicketOrganizerSection(
              organizer: organizerData,
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

  void _onPageChanged(int value) {}

  void _onTicketOptionTapped(TicketOption option) {}
}
