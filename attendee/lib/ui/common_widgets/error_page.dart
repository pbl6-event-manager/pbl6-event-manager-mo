import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

/// A generic error page widget that displays an error title and message
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.title, this.message});

  final String? title;
  final String? message;

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
                  title ?? AppStringConstants.errorPage.defaultTitle,
                  style: context.textPalette.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                Text(
                  message ?? AppStringConstants.errorPage.defaultMessage,
                  style: context.textPalette.bodyLarge.copyWith(
                    color: context.colorPalette.textPlaceholder,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
