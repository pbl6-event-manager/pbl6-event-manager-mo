import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

/// A tappable text with adjustable height between the text and underline
class TappableTextWithUnderline extends StatelessWidget {
  const TappableTextWithUnderline({
    super.key,
    required this.label,
    this.style,
    this.spacing = 1,
    this.onTapped,
    this.underlineColor,
  });

  final String label;
  final TextStyle? style;

  final VoidCallback? onTapped;

  /// Spacing betwen text and underline
  final double spacing;

  /// By default: use primary color
  final Color? underlineColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: IntrinsicWidth(
        child: Column(
          spacing: spacing,
          children: [
            Text(label, style: style),
            Container(
              height: 1,
              color: underlineColor ?? context.colorPalette.primary,
            ),
          ],
        ),
      ),
    );
  }
}
