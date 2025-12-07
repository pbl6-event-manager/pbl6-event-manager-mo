import 'package:flutter/material.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomeAppBarTitle extends StatelessWidget {
  final String eventName;
  final String eventDateLabel;
  final VoidCallback? onTap;

  const HomeAppBarTitle({
    super.key,
    required this.eventName,
    required this.eventDateLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        radius: 8,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 32),
            Flexible(
              child: Column(
                children: [
                  Text(
                    eventName,
                    style: context.textPalette.headlineLarge.copyWith(
                      color: context.colorPalette.invertedText,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    eventDateLabel,
                    style: context.textPalette.labelLarge.copyWith(
                      color: context.colorPalette.invertedText,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: context.colorPalette.surfaceContainer,
            ),
          ],
        ),
      ),
    );
  }
}
