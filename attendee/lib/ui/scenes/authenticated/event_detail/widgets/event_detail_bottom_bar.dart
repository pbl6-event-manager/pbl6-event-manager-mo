import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class EventDetailBottomBar extends StatelessWidget {
  const EventDetailBottomBar({
    super.key,
    required this.onGetTicketTapped,
    required this.dateTimeString,
    required this.pricingString,
    required this.isHidden,
  });
  final VoidCallback? onGetTicketTapped;
  final String? dateTimeString;
  final String pricingString;
  final bool isHidden;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeOutSine,
      duration: Duration(milliseconds: 800),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: UIConstants.horizontalPadding),
      height: isHidden ? 0 : 80,

      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pricingString,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textPalette.labelLarge,
                  ),
                  if (dateTimeString != null)
                    Text(
                      dateTimeString!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentGeometry.centerRight,
                child: FilledButton(
                  onPressed: onGetTicketTapped,
                  child: Text(AppStringConstants.eventDetail.getTicketButton),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
