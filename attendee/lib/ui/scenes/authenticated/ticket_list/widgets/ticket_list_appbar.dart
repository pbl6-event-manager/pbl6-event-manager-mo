import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:flutter/material.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';

class TicketListAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TicketListAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: context.colorPalette.border.withValues(alpha: 0.2),
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          AppStringConstants.ticket.ticketLabel,
          style: context.textPalette.displayMedium,
        ),
      ),
      actionsPadding: EdgeInsets.only(
        right: UIConstants.horizontalPadding,
        top: 20,
        bottom: 10,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
