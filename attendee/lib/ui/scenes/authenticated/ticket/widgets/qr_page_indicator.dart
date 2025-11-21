import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class QrPageIndicator extends StatelessWidget {
  const QrPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  final int currentPage;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: context.colorPalette.primary.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(UIConstants.cornerRadiusBase),
        ),
        child: Text(
          '${currentPage + 1}/$totalPages',
          textAlign: TextAlign.center,
          style: context.textPalette.labelMedium.copyWith(
            color: context.colorPalette.invertedText,
          ),
        ),
      ),
    );
  }
}
