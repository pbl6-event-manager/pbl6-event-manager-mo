import 'package:attendee/application/app_router.dart';
import 'package:attendee/application/bloc/auth_bloc.dart';
import 'package:attendee/application/service_locator.dart';
import 'package:attendee/ui/themes/app_theme.dart';
import 'package:attendee/ui/themes/color_palette.dart';
import 'package:attendee/ui/themes/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Initialize service locator
  ServiceLocator.setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(
        builder: (context) {
          final authBloc = context.read<AuthBloc>();
          return MaterialApp.router(
            routerConfig: AppRouter(authBloc).router,
            theme: AppTheme(
              colorPalette: ColorPalette.light(),
              textPalette: TextPalette.fromPalette(ColorPalette.light()),
            ).themeData,
          );
        },
      ),
    );
  }
}
