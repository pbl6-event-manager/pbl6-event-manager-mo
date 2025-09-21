import 'package:organizer/utils/constants/app_string_constant.dart';

abstract class ValidationUtils {
  static String? validateEmail(String? email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email ?? '')) {
      return AppStringConstant.textFields.emailValidationError;
    }

    return null;
  }

  static String? validateGeneralField(String? text) {
    return (text == null || text.trim().isEmpty)
        ? AppStringConstant.textFields.fieldIsRequiredValidationError
        : null;
  }

  static String? validateConfirmField(
    String? text, {
    required String? originalText,
  }) {
    if (text == null || text.trim().isEmpty) {
      return AppStringConstant.textFields.fieldIsRequiredValidationError;
    }

    if (text != originalText) {
      return AppStringConstant.textFields.fieldsDoNotMatch('Emails');
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return AppStringConstant.textFields.fieldIsRequiredValidationError;
    }

    // Check minimum length
    if (password.length < 10) {
      return AppStringConstant.textFields.passwordValidationError;
    }

    // Check for uppercase letters
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return AppStringConstant.textFields.passwordValidationError;
    }

    // Check for lowercase letters
    if (!password.contains(RegExp(r'[a-z]'))) {
      return AppStringConstant.textFields.passwordValidationError;
    }

    // Check for numbers
    if (!password.contains(RegExp(r'[0-9]'))) {
      return AppStringConstant.textFields.passwordValidationError;
    }

    // Check for special characters
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return AppStringConstant.textFields.passwordValidationError;
    }

    return null;
  }
}
