import 'package:flutter/material.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class CheckInButton extends StatelessWidget {
  const CheckInButton({
    super.key,
    required this.isReserved,
    required this.onTapped,
  });

  final bool isReserved;
  final VoidCallback? onTapped;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 6),
        disabledBackgroundColor: context.colorPalette.disabled,
        disabledForegroundColor: context.colorPalette.disabledText,
        textStyle: context.textPalette.button,
        backgroundColor: isReserved
            ? context.colorPalette.successSurface
            : context.colorPalette.surfaceContainer,
        foregroundColor: isReserved
            ? context.colorPalette.success
            : context.colorPalette.secondary,
        shape: RoundedRectangleBorder(
          side: isReserved
              ? BorderSide.none
              : BorderSide(color: context.colorPalette.border),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onTapped,
      child: Text(
        isReserved
            ? AppStringConstant.ticket.checkedInLabel
            : AppStringConstant.ticket.notCheckedIn,
      ),
    );
  }
}
