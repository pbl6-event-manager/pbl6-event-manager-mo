import 'package:flutter/material.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required this.isLoading,
    required this.onTapped,
  });

  final VoidCallback? onTapped;

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = (onTapped != null && isLoading == false);
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(2),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            isEnabled
                ? context.colorPalette.branding
                : context.colorPalette.disabled,
          ),
        ),
        onPressed: onTapped,
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              )
            : Text(
                'Sign in',
                style: context.textPalette.button.copyWith(
                  color: isEnabled
                      ? context.colorPalette.onPrimary
                      : context.colorPalette.disabledText,
                ),
              ),
      ),
    );
  }
}
