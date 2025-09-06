import 'package:flutter/material.dart';
import 'package:organizer/ui/themes/color_palette.dart';
import 'package:organizer/ui/themes/text_palette.dart';

extension ContextExtension on BuildContext {
  ColorPalette get colorPalette => Theme.of(this).extension<ColorPalette>()!;

  TextPalette get textPalette => Theme.of(this).extension<TextPalette>()!;
}
