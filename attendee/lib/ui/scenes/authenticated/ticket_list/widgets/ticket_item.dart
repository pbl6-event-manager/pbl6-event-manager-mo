import 'package:attendee/domain/models/ticket_details.dart';
import 'package:attendee/ui/common_widgets/common_image_widget.dart';
import 'package:attendee/ui/common_widgets/common_ticket_header.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({
    super.key,
    required this.context,
    required this.detail,
    required this.onTicketTapped,
  });

  final BuildContext context;
  final TicketDetail detail;
  final VoidCallback onTicketTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonTicketHeader(
          width: double.infinity,
          containerColor: context.colorPalette.surfaceContainer,
        ),

        InkWell(
          onTap: onTicketTapped,
          borderRadius: BorderRadius.circular(UIConstants.cornerRadiusBase),
          child: Ink(
            decoration: BoxDecoration(
              color: context.colorPalette.surfaceContainer,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(UIConstants.cornerRadiusBase),
                bottomRight: Radius.circular(UIConstants.cornerRadiusBase),
              ),
            ),

            padding: EdgeInsets.only(
              left: UIConstants.horizontalPadding,
              right: UIConstants.horizontalPadding,
              bottom: 16,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.startDateTime.dateStringWithoutYear,
                          style: context.textPalette.labelLarge,
                        ),
                        Text(detail.startDateTime.timeString),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          detail.qrCodeImageUrl.length.toString(),
                          style: context.textPalette.bodyLarge,
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.qr_code),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 90,
                      child: CommonImageWidget(
                        aspectRatio: 1,
                        imageUrl: detail.eventImageUrl ?? '',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.eventName,
                            style: context.textPalette.labelLarge,
                          ),
                          Text(detail.location),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
