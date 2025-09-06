import 'package:attendee/ui/themes/color_palette.dart';
import 'package:attendee/ui/themes/text_palette.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorPalette get colorPalette => Theme.of(this).extension<ColorPalette>()!;
  TextPalette get textPalette => Theme.of(this).extension<TextPalette>()!;
}
