import 'package:attendee/application/app_router.dart';
import 'package:attendee/application/bloc/auth_bloc.dart';
import 'package:attendee/application/service_locator.dart';
import 'package:attendee/ui/themes/app_theme.dart';
import 'package:attendee/ui/themes/color_palette.dart';
import 'package:attendee/ui/themes/text_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() async {
  enableFlutterDriverExtension();
  // Initialize service locator
  ServiceLocator.setupDependencies();
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = GetIt.instance<AuthBloc>();
    final AppRouter appRouter = GetIt.instance<AppRouter>();
    return BlocProvider.value(
      value: authBloc,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: appRouter.router,
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
