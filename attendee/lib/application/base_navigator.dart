import 'package:go_router/go_router.dart';

/// A base for all navigator, with demand of providing an instance of goRouter
mixin BaseNavigator {
  GoRouter get goRouter;
}
