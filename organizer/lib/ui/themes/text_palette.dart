import 'package:flutter/material.dart';
import 'package:organizer/ui/themes/color_palette.dart';
import 'package:organizer/utils/constants/text_constant.dart';

class TextPalette extends ThemeExtension<TextPalette> {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  // Additional semantic styles
  final TextStyle button;
  final TextStyle caption;
  final TextStyle overline;

  // Supplementary styles (smaller than body)
  final TextStyle subtitleLarge;
  final TextStyle subtitleMedium;
  final TextStyle subtitleSmall;

  const TextPalette({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.button,
    required this.caption,
    required this.overline,
    required this.subtitleLarge,
    required this.subtitleMedium,
    required this.subtitleSmall,
  });

  factory TextPalette.fromPalette(ColorPalette colorPalette) => TextPalette(
    displayLarge: TextConstant.display4XL,
    displayMedium: TextConstant.display3XL,
    displaySmall: TextConstant.display2XL,

    headlineLarge: TextConstant.displayXL,
    headlineMedium: TextConstant.displayLG,
    headlineSmall: TextConstant.displayMD,

    titleLarge: TextConstant.displayMD.copyWith(fontWeight: FontWeight.w700),
    titleMedium: TextConstant.textLG.copyWith(fontWeight: FontWeight.w600),
    titleSmall: TextConstant.textBase.copyWith(fontWeight: FontWeight.w600),

    bodyLarge: TextConstant.textLG.copyWith(color: colorPalette.text),
    bodyMedium: TextConstant.textBase.copyWith(color: colorPalette.text),
    bodySmall: TextConstant.textSM.copyWith(color: colorPalette.text),

    labelLarge: TextConstant.textLGBold,
    labelMedium: TextConstant.textBaseBold,
    labelSmall: TextConstant.textSMBold,

    // Additional semantic styles
    button: TextConstant.displayLG.copyWith(
      height: 0,
      fontWeight: FontWeight.bold,
    ),
    caption: TextConstant.textSM,
    overline: TextConstant.textSM.copyWith(
      letterSpacing: 1.5,
      textBaseline: TextBaseline.alphabetic,
    ),

    // Supplementary styles (smaller than body)
    subtitleLarge: TextStyle(
      fontFamily: TextConstant.fontFamilyText,
      color: colorPalette.textPlaceholder,
      fontSize: 11,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
    subtitleMedium: TextStyle(
      fontFamily: TextConstant.fontFamilyText,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
    subtitleSmall: TextStyle(
      fontFamily: TextConstant.fontFamilyText,
      fontSize: 9,
      fontWeight: FontWeight.w400,
      height: 1.4,
    ),
  );

  @override
  ThemeExtension<TextPalette> lerp(
    covariant ThemeExtension<TextPalette>? other,
    double t,
  ) {
    if (other is! TextPalette) {
      return this;
    }

    return TextPalette(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      overline: TextStyle.lerp(overline, other.overline, t)!,
      subtitleLarge: TextStyle.lerp(subtitleLarge, other.subtitleLarge, t)!,
      subtitleMedium: TextStyle.lerp(subtitleMedium, other.subtitleMedium, t)!,
      subtitleSmall: TextStyle.lerp(subtitleSmall, other.subtitleSmall, t)!,
    );
  }

  @override
  TextPalette copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? button,
    TextStyle? caption,
    TextStyle? overline,
    TextStyle? subtitleLarge,
    TextStyle? subtitleMedium,
    TextStyle? subtitleSmall,
  }) {
    return TextPalette(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      button: button ?? this.button,
      caption: caption ?? this.caption,
      overline: overline ?? this.overline,
      subtitleLarge: subtitleLarge ?? this.subtitleLarge,
      subtitleMedium: subtitleMedium ?? this.subtitleMedium,
      subtitleSmall: subtitleSmall ?? this.subtitleSmall,
    );
  }
}
