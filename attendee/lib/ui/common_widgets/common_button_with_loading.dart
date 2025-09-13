import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// Submit button with loading indicator
class CommonButtonWithLoading extends StatelessWidget {
  const CommonButtonWithLoading({
    super.key,
    this.isEnabled = true,
    this.isLoading = false,
    required this.onPressed,
    required this.label,
  });

  final bool isEnabled;
  final bool isLoading;
  final String label;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isEnabled && !isLoading ? onPressed : null,
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.colorPalette.onPrimary,
              ),
            )
          : Text(label),
    );
  }
}
