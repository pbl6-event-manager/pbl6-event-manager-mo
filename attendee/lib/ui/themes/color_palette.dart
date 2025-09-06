// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:attendee/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ColorPalette extends ThemeExtension<ColorPalette> {
  final Color primary;
  final Color secondary;
  final Color territory;
  final Color branding;

  final Color text;
  final Color disabledText;

  final Color invertedText;
  final Color invertedDisabledText;

  final Color textPlaceholder;

  final Color border;
  final Color divider;

  final Color surface;
  final Color surfaceContainer;

  final Color error;
  final Color onError;

  final Color success;
  final Color onSuccess;

  const ColorPalette({
    required this.primary,
    required this.secondary,
    required this.territory,
    required this.branding,
    required this.text,
    required this.disabledText,
    required this.invertedText,
    required this.invertedDisabledText,
    required this.textPlaceholder,
    required this.border,
    required this.divider,
    required this.surface,
    required this.surfaceContainer,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
  });

  factory ColorPalette.light() => ColorPalette(
    primary: ColorConstants.black,
    secondary: ColorConstants.brandingBlue,
    territory: ColorConstants.brandingBlue,
    branding: ColorConstants.brandingColor,
    text: ColorConstants.black,
    disabledText: ColorConstants.grey600,
    invertedText: ColorConstants.white,
    invertedDisabledText: ColorConstants.grey200,
    textPlaceholder: ColorConstants.grey700,
    border: ColorConstants.grey400,
    divider: ColorConstants.grey200,
    surface: ColorConstants.grey100,
    surfaceContainer: ColorConstants.white,
    error: ColorConstants.semanticRed,
    onError: ColorConstants.white,
    success: ColorConstants.semanticGreen,
    onSuccess: ColorConstants.white,
  );

  @override
  ThemeExtension<ColorPalette> lerp(
    covariant ThemeExtension<ColorPalette>? other,
    double t,
  ) {
    if (other is! ColorPalette) {
      return this;
    }

    return ColorPalette(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      territory: Color.lerp(territory, other.territory, t)!,
      branding: Color.lerp(branding, other.branding, t)!,
      text: Color.lerp(text, other.text, t)!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
      invertedText: Color.lerp(invertedText, other.invertedText, t)!,
      invertedDisabledText: Color.lerp(
        invertedDisabledText,
        other.invertedDisabledText,
        t,
      )!,
      textPlaceholder: Color.lerp(textPlaceholder, other.textPlaceholder, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceContainer: Color.lerp(
        surfaceContainer,
        other.surfaceContainer,
        t,
      )!,
      error: Color.lerp(error, other.error, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
    );
  }

  @override
  ColorPalette copyWith({
    Color? primary,
    Color? secondary,
    Color? territory,
    Color? branding,
    Color? text,
    Color? disabledText,
    Color? invertedText,
    Color? invertedDisabledText,
    Color? textPlaceholder,
    Color? border,
    Color? divider,
    Color? surface,
    Color? surfaceContainer,
    Color? error,
    Color? onError,
    Color? success,
    Color? onSuccess,
  }) {
    return ColorPalette(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      territory: territory ?? this.territory,
      branding: branding ?? this.branding,
      text: text ?? this.text,
      disabledText: disabledText ?? this.disabledText,
      invertedText: invertedText ?? this.invertedText,
      invertedDisabledText: invertedDisabledText ?? this.invertedDisabledText,
      textPlaceholder: textPlaceholder ?? this.textPlaceholder,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      surface: surface ?? this.surface,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
    );
  }
}
