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
}
