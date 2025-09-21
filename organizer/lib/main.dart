import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/application/app_router.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/application/service_locator.dart';
import 'package:organizer/ui/themes/app_theme.dart';
import 'package:organizer/ui/themes/color_palette.dart';
import 'package:organizer/ui/themes/text_palette.dart';

void main() {
  ServiceLocator.setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(
        builder: (context) {
          final AuthBloc authBloc = context.read<AuthBloc>();
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: AppTheme(
              colorPalette: ColorPalette.light(),
              textPalette: TextPalette.fromPalette(ColorPalette.light()),
            ).themeData,
            routerConfig: AppRouter(authBloc).router,
          );
        },
      ),
    );
  }
}
