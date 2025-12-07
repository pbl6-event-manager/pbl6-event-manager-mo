import 'package:flutter/material.dart';
import 'package:organizer/ui/common_widgets/check_in_button.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomeAttendeeTile extends StatelessWidget {
  final int ticketId;
  final String attendeeName;
  final bool isReserved;
  final VoidCallback onTap;
  final VoidCallback onCheckinTapped;

  const HomeAttendeeTile({
    super.key,
    required this.ticketId,
    required this.attendeeName,
    required this.isReserved,
    required this.onTap,
    required this.onCheckinTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
      minLeadingWidth: 0,
      leading: isReserved
          ? Container(width: 8, color: context.colorPalette.success)
          : null,
      horizontalTitleGap: 8,
      trailing: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: SizedBox(
          width: 100,
          child: CheckInButton(
            isReserved: isReserved,
            onTapped: isReserved ? () {} : onCheckinTapped,
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: isReserved ? 0 : 16),
        child: Text(attendeeName, style: context.textPalette.headlineLarge),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(left: isReserved ? 0 : 16),
        child: Text(
          isReserved.toString(),
          style: context.textPalette.bodyLarge.copyWith(
            color: context.colorPalette.textPlaceholder,
          ),
        ),
      ),
    );
  }
}
