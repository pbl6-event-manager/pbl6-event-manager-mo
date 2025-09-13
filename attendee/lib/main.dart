import 'package:attendee/application/app_router.dart';
import 'package:attendee/ui/themes/app_theme.dart';
import 'package:attendee/ui/themes/color_palette.dart';
import 'package:attendee/ui/themes/text_palette.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      theme: AppTheme(
        colorPalette: ColorPalette.light(),
        textPalette: TextPalette.fromPalette(ColorPalette.light()),
      ).themeData,
    );
  }
}
