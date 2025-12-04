abstract class AppStringConstant {
  static ButtonAppStrings get buttons => ButtonAppStrings._();
  static TextFieldAppStrings get textFields => TextFieldAppStrings._();
  static GenericErrorAppStrings get genericErrors => GenericErrorAppStrings._();
  static ErrorPageAppStrings get errorPage => ErrorPageAppStrings._();
  static SignInAppStrings get signIn => SignInAppStrings._();
  static TicketAppStrings get ticket => TicketAppStrings._();
  static HomeAppStrings get home => HomeAppStrings._();
}

final class ButtonAppStrings {
  const ButtonAppStrings._();

  String get nextLabel => 'Next';
}

final class TextFieldAppStrings {
  const TextFieldAppStrings._();

  String get passwordPlaceholder => 'Password';
  String get emailPlaceholder => 'Email address';
  String get confirmEmailPlaceholder => 'Confirm email address';
  String get firstNamePlaceholder => 'First name';
  String get lastNamePlaceholder => 'Last name';

  String get emailValidationError => 'Please enter a valid email address';

  String get fieldIsRequiredValidationError => 'Field is required';

  String get passwordValidationError =>
      'Password must be at least 10 characters long and contain uppercase letters, lowercase letters, numbers, and special characters';

  String fieldsDoNotMatch(String fieldName) => '$fieldName must match';
}

final class GenericErrorAppStrings {
  const GenericErrorAppStrings._();

  String get tryAgainMessage => 'An error occurred. Please try again.';
}

final class SignInAppStrings {
  const SignInAppStrings._();

  String get changeLabel => 'Change';

  String get signInLabel => 'Sign in';

  // Screen-specific labels and hints
  String get emailLabel => 'Email*';
  String get passwordLabel => 'Password*';
  String get emailHint => 'Enter email address';
  String get passwordHint => 'Enter password';

  // Password visibility toggle
  String get passwordToggleShow => 'Show';
  String get passwordToggleHide => 'Hide';

  // Temporary placeholder for the error banner
  String get errorBanner => 'Cannot sign in, please try again.';
}

final class ErrorPageAppStrings {
  const ErrorPageAppStrings._();

  String get defaultTitle => 'Oops! Something went wrong';
  String get defaultMessage =>
      'We encountered an unexpected error. Please try again later.';

  String get tryAgain => 'Try again';
}

final class TicketAppStrings {
  const TicketAppStrings._();

  String get checkInLabel => 'Check in';
  String get checkedInLabel => 'Checked in';
  String get attendeeDetailsTitle => 'Attendee Details';
  String get attendeeLabel => 'Attendee';
  String get orderNumberLabel => 'Order no.';
  String get ticketTypeLabel => 'Ticket type';
}

final class HomeAppStrings {
  const HomeAppStrings._();
  String get scanQrFABLabel => 'Scan QR';
}
