import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:flutter/material.dart';

class BookingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookingAppBar({
    super.key,
    required this.eventName,
    required this.eventDateTime,
    required this.onCloseTapped,
  });
  final String eventName;
  final DateTime? eventDateTime;
  final VoidCallback? onCloseTapped;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(eventName, style: context.textPalette.bodyLarge),
          if (eventDateTime != null)
            Text(
              eventDateTime!.shortenDateTimeStringWithDot,
              style: context.textPalette.bodyLarge,
            ),
        ],
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [IconButton(onPressed: onCloseTapped, icon: Icon(Icons.close))],
      actionsPadding: EdgeInsets.only(right: UIConstants.horizontalPadding),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
