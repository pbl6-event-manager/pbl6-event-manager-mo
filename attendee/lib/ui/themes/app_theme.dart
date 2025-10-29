import 'package:attendee/ui/themes/color_palette.dart';
import 'package:attendee/ui/themes/text_palette.dart';
import 'package:flutter/material.dart';

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
          onPrimary: colorPalette.onPrimary,
          secondary: colorPalette.secondary,
          onSecondary: colorPalette.invertedText,
          error: colorPalette.error,
          onError: colorPalette.onError,
          surface: colorPalette.surface,
          onSurface: colorPalette.text,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity(
              vertical: VisualDensity.minimumDensity,
              horizontal: VisualDensity.minimumDensity,
            ),
          ),
        ),

        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            disabledBackgroundColor: colorPalette.disabled,
            disabledForegroundColor: colorPalette.disabledText,
            textStyle: textPalette.button,
            backgroundColor: colorPalette.primary,
            foregroundColor: colorPalette.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        dividerTheme: DividerThemeData(color: colorPalette.divider),
      );
}
