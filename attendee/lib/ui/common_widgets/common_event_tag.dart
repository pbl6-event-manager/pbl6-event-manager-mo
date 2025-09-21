import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

/// Event tags that show on the top right of given event
/// - FEW TICKETS LEFT
class CommonEventTag extends StatelessWidget {
  const CommonEventTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: context.colorPalette.territory,
        borderRadius: BorderRadius.circular(UIConstants.cornerRadiusSmall),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department, size: 18),
          SizedBox(width: 4),
          Text(
            AppStringConstants.event.fewTicketsLeftTag,
            style: context.textPalette.labelSmall.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 10,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
