import 'package:flutter/material.dart';
import 'package:organizer/ui/themes/color_palette.dart';
import 'package:organizer/ui/themes/text_palette.dart';

final class AppTheme {
  final ColorPalette colorPalette;
  final TextPalette textPalette;
  final ThemeData themeData;

  AppTheme({required this.colorPalette, required this.textPalette})
    : themeData = ThemeData(
        extensions: [colorPalette, textPalette],
        scaffoldBackgroundColor: colorPalette.surface,
        dividerColor: colorPalette.divider,
        disabledColor: colorPalette.invertedDisabledText,
        primaryTextTheme: TextTheme(
          displayLarge: textPalette.displayLarge,
          displayMedium: textPalette.displayMedium,
          displaySmall: textPalette.displaySmall,
          headlineLarge: textPalette.headlineLarge,
          headlineMedium: textPalette.headlineMedium,
          headlineSmall: textPalette.headlineSmall,
          titleLarge: textPalette.titleLarge,
          titleMedium: textPalette.titleMedium,
          titleSmall: textPalette.titleSmall,
          bodyLarge: textPalette.bodyLarge,
          bodyMedium: textPalette.bodyMedium,
          bodySmall: textPalette.bodySmall,
          labelLarge: textPalette.labelLarge,
          labelMedium: textPalette.labelMedium,
          labelSmall: textPalette.labelSmall,
        ),

        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: colorPalette.branding,
          onPrimary: colorPalette.invertedText,
          secondary: colorPalette.secondary,
          onSecondary: colorPalette.invertedText,
          error: colorPalette.error,
          onError: colorPalette.onError,
          surface: colorPalette.surface,
          onSurface: colorPalette.text,
        ),
      );
}
