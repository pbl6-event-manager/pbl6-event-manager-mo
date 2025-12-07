abstract class AppStringConstant {
  static ButtonAppStrings get buttons => ButtonAppStrings._();
  static TextFieldAppStrings get textFields => TextFieldAppStrings._();
  static GenericErrorAppStrings get genericErrors => GenericErrorAppStrings._();
  static ErrorPageAppStrings get errorPage => ErrorPageAppStrings._();
  static SignInAppStrings get signIn => SignInAppStrings._();
  static TicketAppStrings get ticket => TicketAppStrings._();
  static HomeAppStrings get home => HomeAppStrings._();
  static EventListAppStrings get eventList => EventListAppStrings._();
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
  String get ticketNumberLabel => 'Ticket no.';
  String get attendeeEmailLabel => 'Email';
  String get unknownAttendeeLabel => 'Unknown attendee';
  String get unknownTicketLabel => 'Unnamed ticket';
  String get noEmailLabel => 'No email provided';
  String get noEmailShortLabel => 'No email';
  String orderBadgeLabel(int orderId) => 'Order #$orderId';
  String orderNumberValue(int orderId) => '#$orderId';
  String ticketSummaryLabel(String ticketName, int ticketId) =>
      'Ticket: $ticketName (#$ticketId)';
}

final class HomeAppStrings {
  const HomeAppStrings._();
  String get scanQrFABLabel => 'Scan QR';
  String get placeholderEventName => 'Select an event';
  String get placeholderEventDate => 'Tap to choose an event';
  String get emptyStateTitle => 'No event selected';
  String get emptyStateDescription =>
      'Tap the header above to choose an event and see attendees.';
  String get noAttendeesLabel => 'No attendees yet';
}

final class EventListAppStrings {
  const EventListAppStrings._();

  String get appBarTitle => 'Select an event';
  String get emptyStateTitle => 'No events available yet.';
  String get emptyStateDescription =>
      'Pull down to refresh once events are assigned.';
  String get untitledEventPlaceholder => 'Untitled event';
}
