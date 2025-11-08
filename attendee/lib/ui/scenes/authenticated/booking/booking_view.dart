import 'package:attendee/ui/common_widgets/common_text_field.dart';
import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:attendee/ui/scenes/authenticated/booking/widgets/booking_ticket_card.dart';
import 'package:attendee/ui/scenes/authenticated/booking/widgets/booking_view_app_bar.dart';
import 'package:attendee/ui/scenes/authenticated/event_detail/widgets/event_detail_bottom_bar.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';

import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return id != null ? const BookingView() : const ErrorPage();
  }
}

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  String get eventName => "Event! this is an event with a long name";
  DateTime get dateTime => DateTime.now();

  String get ticketName => "Ticket name";
  String get pricing => "Free";
  DateTime? get ticketDeadline => DateTime.now();
  String? get ticketDescription =>
      "as;lfjasd;lfkjasd;lfjasd;ffsdlkfjsdlkfjas;lfjasd;lfjasd;lfjasd;lfkjads;lfjasd;lfjasdl;fjas;dlfjlkjasdfkljfjsdlk;fasdjfk;l;flsdkjs;aldfkjsad;lkfjsdklfjsha";

  bool get isPromoCodeEnabled => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: EventDetailBottomBar.expanded(
        primaryButtonLabel: AppStringConstants.booking.registerButton,
        onPrimaryButtonTapped: () {},
        dateTimeString: null,
        pricingString: pricing,
        isHidden: false,
      ),
      appBar: BookingAppBar(
        eventName: eventName,
        eventDateTime: dateTime,
        onCloseTapped: _onCloseTapped,
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
          vertical: 16,
        ),

        children: [
          if (isPromoCodeEnabled) ...[
            CommonTextField(
              hintText: AppStringConstants.booking.promoCodePlaceholder,
              trailingIcon: TextButton(
                onPressed: _onPromoCodeTrallingButtonTapped,
                child: Text(AppStringConstants.booking.applyButton),
              ),
            ),
            SizedBox(height: 24),
          ],

          Column(
            spacing: 16,
            children: [
              BookingTicketCard(
                ticketName: ticketName,
                pricingLabel: pricing,
                ticketDeadline: ticketDeadline,
                ticketDescription: ticketDescription,
                selectedTicketQuantity: 0,
                onAddTicket: null,
                onSubtractTicket: null,
              ),
              BookingTicketCard(
                ticketName: ticketName,
                pricingLabel: pricing,
                ticketDeadline: ticketDeadline,
                ticketDescription: ticketDescription,
                selectedTicketQuantity: 1,
                onAddTicket: null,
                onSubtractTicket: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onCloseTapped() {}

  void _onPromoCodeTrallingButtonTapped() {}
}
