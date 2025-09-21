import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/application/bloc/auth_bloc.dart';
import 'package:organizer/ui/themes/color_palette.dart';
import 'package:organizer/ui/themes/text_palette.dart';

extension ContextExtension on BuildContext {
  ColorPalette get colorPalette => Theme.of(this).extension<ColorPalette>()!;

  TextPalette get textPalette => Theme.of(this).extension<TextPalette>()!;

  AuthBloc get authBloc => read<AuthBloc>();
}
