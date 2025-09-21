import "dart:ui";

import "package:attendee/ui/themes/color_palette.dart";
import "package:flutter/material.dart";

enum PasswordStrengthEnum {
  none(indicatorValue: 0, label: ""),
  weak(indicatorValue: 0.25, label: "Weak"),
  average(indicatorValue: 0.5, label: "Average"),
  strong(indicatorValue: 0.75, label: "Strong"),
  veryStrong(indicatorValue: 1, label: "Very strong");

  final String label;
  // On the scale of 0->1
  final double indicatorValue;

  const PasswordStrengthEnum({
    required this.label,
    required this.indicatorValue,
  });
  Color getColor(ColorPalette colorPalette) => colorPalette.branding;
}
