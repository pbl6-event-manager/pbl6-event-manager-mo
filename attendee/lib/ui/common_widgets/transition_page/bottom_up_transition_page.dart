import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom transition page with animation from bottom to the top
class BottomUpTransitionPage<T> extends CustomTransitionPage<T> {
  BottomUpTransitionPage({required Widget destination})
    : super(
        transitionDuration: Duration(milliseconds: 500),
        child: destination,
        transitionsBuilder: _transitionsBuilder,
      );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final tween = Tween(
      begin: begin,
      end: end,
    ).chain(CurveTween(curve: Curves.easeInOut));
    return SlideTransition(position: animation.drive(tween), child: child);
  }
}
