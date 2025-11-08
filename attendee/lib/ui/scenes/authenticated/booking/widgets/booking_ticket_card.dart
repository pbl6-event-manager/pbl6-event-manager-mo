import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class BookingTicketCard extends StatefulWidget {
  const BookingTicketCard({
    super.key,
    required this.ticketName,
    required this.pricingLabel,
    required this.ticketDeadline,
    required this.ticketDescription,
    required this.selectedTicketQuantity,
    required this.onAddTicket,
    required this.onSubtractTicket,
  });
  final String ticketName;
  final String pricingLabel;
  final DateTime? ticketDeadline;
  final String? ticketDescription;
  final int selectedTicketQuantity;
  final VoidCallback? onAddTicket;
  final VoidCallback? onSubtractTicket;

  bool get hasTicket => selectedTicketQuantity > 0;
  bool get shouldShowMoreDescription =>
      ticketDescription != null &&
      ticketDescription!.isNotEmpty &&
      ticketDescription!.length > 100;

  @override
  State<BookingTicketCard> createState() => _BookingTicketCardState();
}

class _BookingTicketCardState extends State<BookingTicketCard> {
  late bool _isShowingMore;

  @override
  void initState() {
    super.initState();
    _isShowingMore = widget.shouldShowMoreDescription ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 16;
    final Color borderColor = widget.hasTicket
        ? context.colorPalette.primary
        : context.colorPalette.border;
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor),
        borderRadius: BorderRadiusGeometry.circular(
          UIConstants.cornerRadiusBase,
        ),
      ),
      elevation: 0,
      color: context.colorPalette.surfaceContainer,

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      widget.ticketName,
                      style: context.textPalette.headlineLarge,
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButton.outlined(
                            onPressed: widget.onAddTicket,
                            icon: Icon(Icons.remove),
                          ),
                        ),

                        Expanded(
                          child: Text(
                            widget.selectedTicketQuantity.toString(),
                            textAlign: TextAlign.center,
                            style: context.textPalette.headlineLarge,
                          ),
                        ),

                        SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButton.outlined(
                            onPressed: widget.onSubtractTicket,
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: borderColor),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.pricingLabel,
                    style: context.textPalette.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.ticketDeadline != null)
                    Text(
                      'Sales end on ${widget.ticketDeadline!.shortenDateString}',
                      style: context.textPalette.bodyMedium,
                    ),
                  if (widget.ticketDescription != null &&
                      widget.ticketDescription!.isNotEmpty) ...[
                    SizedBox(height: 8),
                    Text(
                      _isShowingMore
                          ? widget.ticketDescription!
                          : '${widget.ticketDescription!.substring(0, 101)}...',
                      style: context.textPalette.bodyMedium,
                    ),
                    if (widget.shouldShowMoreDescription)
                      InkWell(
                        borderRadius: BorderRadius.circular(
                          UIConstants.cornerRadiusSmall,
                        ),
                        onTap: _onShowMoreTapped,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            _isShowingMore
                                ? AppStringConstants.booking.showLessButton
                                : AppStringConstants.booking.showMoreButton,
                            style: context.textPalette.headlineSmall,
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onShowMoreTapped() {
    setState(() {
      _isShowingMore = !_isShowingMore;
    });
  }
}
