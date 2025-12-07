import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:organizer/application/app_router.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/application/service_locator.dart';
import 'package:organizer/ui/themes/app_theme.dart';
import 'package:organizer/ui/themes/color_palette.dart';
import 'package:organizer/ui/themes/text_palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await ServiceLocator.setupDependencies();

  runApp(BlocProvider(create: (context) => AuthBloc(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    final authBloc = context.read<AuthBloc>();
    _appRouter = AppRouter(authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme(
        colorPalette: ColorPalette.light(),
        textPalette: TextPalette.fromPalette(ColorPalette.light()),
      ).themeData,
      routerConfig: _appRouter.router,
    );
  }
}
