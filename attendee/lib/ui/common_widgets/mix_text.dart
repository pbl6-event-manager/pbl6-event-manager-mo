import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

/// A widget takes in a string formatted in HTML style and output the styles accordingly
///
/// Sample input: `Hello, <u>World!</u>
///
/// Currently supporting underline only
class MixText extends StatelessWidget {
  const MixText({
    super.key,
    required this.text,
    this.style,
    this.underlineStyle,
  });

  final String text;
  final TextStyle? style;
  final TextStyle? underlineStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _parseText(
          text,
          underlineStyle:
              underlineStyle ??
              context.textPalette.bodyMedium.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: context.colorPalette.text,
              ),
        ),
        style: style ?? context.textPalette.bodyMedium,
      ),
    );
  }
}

List<TextSpan> _parseText(String text, {required TextStyle underlineStyle}) {
  final spans = <TextSpan>[];
  final regex = RegExp(r"<u>(.*?)</u>");
  int lastEnd = 0;

  for (final match in regex.allMatches(text)) {
    // Add text before the underlined part
    if (match.start > lastEnd) {
      spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
    }

    // Add underlined text
    spans.add(TextSpan(text: match.group(1), style: underlineStyle));

    lastEnd = match.end;
  }

  // Add remaining text
  if (lastEnd < text.length) {
    spans.add(TextSpan(text: text.substring(lastEnd)));
  }

  return spans;
}
