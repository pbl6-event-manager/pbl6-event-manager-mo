import 'package:flutter/material.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: context.colorPalette.error,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Padding for text baseline
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              size: 16,
              Icons.error_outline,
              color: context.colorPalette.onError,
            ),
          ),
          SizedBox(width: 6),
          Flexible(
            child: Text(
              message,
              style: context.textPalette.labelMedium.copyWith(
                color: context.colorPalette.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
