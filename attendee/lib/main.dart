import 'package:attendee/ui/scenes/unregistered/sign_in/sign_in_view.dart';
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
    return MaterialApp(
      theme: AppTheme(
        colorPalette: ColorPalette.light(),
        textPalette: TextPalette.fromPalette(ColorPalette.light()),
      ).themeData,
      home: const SingInPage(
        email: "huycodonbit@gmail.com",
        imageUrl:
            "https://images.unsplash.com/photo-1757137910091-1cf071030691?q=80&w=2338&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ),
    );
  }
}
