import 'package:attendee/utils/constants/app_string_constants.dart';

abstract class ValidationUtils {
  static String? validateEmail(String? email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(email ?? '')) {
      return AppStringConstants.textFields.emailValidationError;
    }

    return null;
  }

  static String? validateGeneralField(String? text) {
    return (text == null || text.trim().isEmpty)
        ? AppStringConstants.textFields.fieldIsRequiredValidationError
        : null;
  }

  static String? validateConfirmField(
    String? text, {
    required String? originalText,
  }) {
    if (text == null || text.trim().isEmpty) {
      return AppStringConstants.textFields.fieldIsRequiredValidationError;
    }

    if (text != originalText) {
      return AppStringConstants.textFields.fieldsDoNotMatch('Emails');
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return AppStringConstants.textFields.fieldIsRequiredValidationError;
    }

    // Check minimum length
    if (password.length < 10) {
      return AppStringConstants.textFields.passwordValidationError;
    }

    // Check for uppercase letters
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return AppStringConstants.textFields.passwordValidationError;
    }

    // Check for lowercase letters
    if (!password.contains(RegExp(r'[a-z]'))) {
      return AppStringConstants.textFields.passwordValidationError;
    }

    // Check for numbers
    if (!password.contains(RegExp(r'[0-9]'))) {
      return AppStringConstants.textFields.passwordValidationError;
    }

    // Check for special characters
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return AppStringConstants.textFields.passwordValidationError;
    }

    return null;
  }

  static String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.trim().isEmpty) {
      return AppStringConstants.textFields.fieldIsRequiredValidationError;
    }

    final phoneRegex = RegExp(r'^(\+84|0)\d{9}$');

    if (!phoneRegex.hasMatch(phoneNumber.trim())) {
      return AppStringConstants.textFields.phoneNumberValidationError;
    }

    return null;
  }
}
