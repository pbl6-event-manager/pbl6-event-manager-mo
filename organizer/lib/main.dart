import 'package:flutter/material.dart';
import 'package:organizer/ui/scenes/unregistered/sign_in/sign_in_view.dart';
import 'package:organizer/ui/themes/app_theme.dart';
import 'package:organizer/ui/themes/color_palette.dart';
import 'package:organizer/ui/themes/text_palette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme(
        colorPalette: ColorPalette.light(),
        textPalette: TextPalette.fromPalette(ColorPalette.light()),
      ).themeData,
      home: const SignInPage(),
    );
  }
}
