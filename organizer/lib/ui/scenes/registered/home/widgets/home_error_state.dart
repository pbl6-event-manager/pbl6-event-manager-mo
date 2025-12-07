import 'package:flutter/material.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomeErrorState extends StatelessWidget {
  final String? message;

  const HomeErrorState({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: context.colorPalette.error,
            ),
            SizedBox(height: 16),
            Text(
              message ?? AppStringConstant.genericErrors.tryAgainMessage,
              style: context.textPalette.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

