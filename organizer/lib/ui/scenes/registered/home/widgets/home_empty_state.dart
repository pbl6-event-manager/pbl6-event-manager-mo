import 'package:flutter/material.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomeEmptyState extends StatelessWidget {
  const HomeEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_available_outlined,
              size: 48,
              color: context.colorPalette.textPlaceholder,
            ),
            SizedBox(height: 16),
            Text(
              AppStringConstant.home.emptyStateTitle,
              style: context.textPalette.headlineLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              AppStringConstant.home.emptyStateDescription,
              style: context.textPalette.bodyLarge.copyWith(
                color: context.colorPalette.textPlaceholder,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
