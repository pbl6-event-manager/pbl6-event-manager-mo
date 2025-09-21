import "package:attendee/utils/enums/password_strength_enum.dart";

abstract class StringUtils {
  static PasswordStrengthEnum calculatePasswordStrength(String password) {
    if (password.isEmpty) return PasswordStrengthEnum.none;

    int score = 0;

    // Length check
    if (password.length >= 10) score += 1;

    // Numbers check
    if (password.contains(RegExp(r"[0-9]"))) score += 1;

    // Special characters check
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) score += 1;

    // Uppercase check
    if (password.contains(RegExp(r"[A-Z]"))) score += 1;

    // Lowercase check
    if (password.contains(RegExp(r"[a-z]"))) score += 1;

    switch (score) {
      case 0:
      case 1:
        return PasswordStrengthEnum.weak;
      case 2:
      case 3:
        return PasswordStrengthEnum.average;
      case 4:
        return PasswordStrengthEnum.strong;
      case 5:
        return PasswordStrengthEnum.veryStrong;
      default:
        return PasswordStrengthEnum.weak;
    }
  }
}
