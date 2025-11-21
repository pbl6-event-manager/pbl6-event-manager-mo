import 'package:attendee/domain/models/ticket_details.dart';
import 'package:attendee/ui/common_widgets/common_image_widget.dart';
import 'package:attendee/ui/common_widgets/common_ticket_header.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class HighlightTicketItem extends StatelessWidget {
  const HighlightTicketItem({
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
    final Radius topRadius = Radius.circular(UIConstants.cornerRadiusBase);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CommonTicketHeader(
          width: double.infinity,
          containerColor: context.colorPalette.surfaceContainer,
        ),

        InkWell(
          onTap: onTicketTapped,
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: UIConstants.horizontalPadding,
            ),
            decoration: BoxDecoration(
              color: context.colorPalette.surfaceContainer,
              borderRadius: BorderRadius.only(
                topLeft: topRadius,
                topRight: topRadius,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: 16),
                    Text(
                      detail.eventName,
                      style: context.textPalette.displaySmall,
                    ),
                    Text(detail.location),
                  ],
                ),
                SizedBox(height: 16),
                CommonImageWidget(
                  aspectRatio: 16 / 9,
                  cornerRadius: UIConstants.cornerRadiusBase,
                  imageUrl: detail.eventImageUrl ?? '',
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
        CommonTicketHeader.bottomUp(
          width: double.infinity,
          containerColor: context.colorPalette.surfaceContainer,
        ),
      ],
    );
  }
}
