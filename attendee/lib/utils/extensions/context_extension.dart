import "package:attendee/ui/themes/color_palette.dart";
import "package:attendee/ui/themes/text_palette.dart";
import "package:flutter/material.dart";

extension ContextExtension on BuildContext {
  // Theme extensions
  // Quick access to color palette
  ColorPalette get colorPalette => Theme.of(this).extension<ColorPalette>()!;

  // Quick access to text palette
  TextPalette get textPalette => Theme.of(this).extension<TextPalette>()!;
}
