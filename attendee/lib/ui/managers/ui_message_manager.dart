import "package:attendee/ui/themes/color_palette.dart";
import "package:attendee/ui/themes/text_palette.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

/// A centralized class that show dialog and snack bar
class UiMessageManager {
  UiMessageManager._();

  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    String? title,
    Widget? content,
    List<Widget>? actions,
    bool barrierDismissible = true,
  }) {
    final colorPalette = Theme.of(context).extension<ColorPalette>()!;
    final textPalette = Theme.of(context).extension<TextPalette>()!;

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: colorPalette.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: title != null
              ? Text(
                  title,
                  style: textPalette.titleLarge.copyWith(
                    color: colorPalette.text,
                  ),
                )
              : null,
          content: content,
          actions: actions,
        );
      },
    );
  }

  /// Shows a confirmation dialog with Yes/No buttons
  ///
  /// Returns true if user confirms, false otherwise
  static Future<bool> showConfirmationDialog({
    required BuildContext context,
    String? title,
    required String message,
    String confirmText = "Yes",
    String cancelText = "No",
    bool barrierDismissible = true,
  }) async {
    final colorPalette = Theme.of(context).extension<ColorPalette>()!;
    final textPalette = Theme.of(context).extension<TextPalette>()!;

    final result = await showCustomDialog<bool>(
      context: context,
      title: title,
      content: Text(
        message,
        style: textPalette.bodyMedium.copyWith(color: colorPalette.text),
      ),
      barrierDismissible: barrierDismissible,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            cancelText,
            style: textPalette.labelLarge.copyWith(color: colorPalette.text),
          ),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmText),
        ),
      ],
    );

    return result ?? false;
  }

  /// Shows a loading dialog in the center of the screen
  ///
  /// This dialog cannot be dismissed by tapping outside
  /// Call [Navigator.pop(context)] to dismiss it programmatically
  static void showLoadingDialog({required BuildContext context}) {
    final colorPalette = context.colorPalette;

    showDialog(
      barrierColor: Colors.black.withValues(alpha: 0.2),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: colorPalette.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(24),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorPalette.branding,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Dismisses the currently displayed loading dialog
  static void dismissLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// Shows a simple snackbar with a message
  ///
  /// [context] - The BuildContext to show the snackbar in
  /// [message] - The message to display
  /// [duration] - How long to show the snackbar (default: 4 seconds)
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    final colorPalette = Theme.of(context).extension<ColorPalette>()!;
    final textPalette = Theme.of(context).extension<TextPalette>()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textPalette.bodyMedium.copyWith(
            color: colorPalette.invertedText,
          ),
        ),
        backgroundColor: colorPalette.text,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Shows a success snackbar with a green background
  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    final colorPalette = Theme.of(context).extension<ColorPalette>()!;
    final textPalette = Theme.of(context).extension<TextPalette>()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: colorPalette.onSuccess),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: textPalette.bodyMedium.copyWith(
                  color: colorPalette.onSuccess,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colorPalette.success,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// Shows an error snackbar with a red background
  static void showErrorSnackBar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    final colorPalette = Theme.of(context).extension<ColorPalette>()!;
    final textPalette = Theme.of(context).extension<TextPalette>()!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: colorPalette.onError),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: textPalette.bodyMedium.copyWith(
                  color: colorPalette.onError,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colorPalette.error,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
