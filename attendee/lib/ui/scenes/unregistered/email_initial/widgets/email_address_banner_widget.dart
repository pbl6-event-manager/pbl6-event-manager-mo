import "dart:math";

import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

/// Showing a banner telling user to use the same email as on ticket
class EmailAddressBannerWidget extends StatelessWidget {
  const EmailAddressBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UIConstants.cornerRadiusSmall),
        color: context.colorPalette.secondary,
      ),
      child: Row(
        spacing: 12,
        children: [
          // Original icon is horizontal
          Transform.rotate(
            angle: 90 * pi / 180,
            child: Icon(
              Icons.confirmation_num_outlined,
              color: context.colorPalette.invertedText,
            ),
          ),
          Flexible(
            child: Text(
              AppStringConstants.emailInitial.bannerMessage,
              style: context.textPalette.labelLarge.copyWith(
                height: 1.3,
                color: context.colorPalette.invertedText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
