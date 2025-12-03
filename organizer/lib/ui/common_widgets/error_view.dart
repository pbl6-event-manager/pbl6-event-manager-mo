import 'package:flutter/material.dart';
import 'package:organizer/utils/constants/app_string_constant.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

/// A generic error page widget that displays an error title and message
class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    this.title,
    this.message,
    this.buttonTitle,
    this.onButtonTapped,
  });

  final String? title;
  final String? message;
  final String? buttonTitle;

  final VoidCallback? onButtonTapped;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 80,
                  color: context.colorPalette.error,
                ),
                const SizedBox(height: 24),

                Text(
                  title ?? AppStringConstant.errorPage.defaultTitle,
                  style: context.textPalette.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                Text(
                  message ?? AppStringConstant.errorPage.defaultMessage,
                  style: context.textPalette.bodyLarge.copyWith(
                    color: context.colorPalette.textPlaceholder,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),
                if (onButtonTapped != null)
                  FilledButton(
                    onPressed: onButtonTapped,
                    child: Text(
                      buttonTitle ?? AppStringConstant.errorPage.tryAgain,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
