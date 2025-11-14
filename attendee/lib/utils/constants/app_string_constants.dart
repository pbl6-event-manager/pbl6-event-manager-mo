abstract class AppStringConstants {
  static BottomNavigationAppString get bottomNavigation =>
      BottomNavigationAppString._();

  static EmailInitialAppStrings get emailInitial => EmailInitialAppStrings._();
  static ButtonAppStrings get buttons => ButtonAppStrings._();
  static TextFieldAppStrings get textFields => TextFieldAppStrings._();
  static GenericErrorAppStrings get genericErrors => GenericErrorAppStrings._();
  static ErrorPageAppStrings get errorPage => ErrorPageAppStrings._();
  static SignInAppStrings get signIn => SignInAppStrings._();
  static SignUpAppStrings get signUp => SignUpAppStrings._();
  static EventAppStrings get event => EventAppStrings._();

  static HomeAppStrings get home => HomeAppStrings._();
  static HomeSearchAppStrings get homeSearch => HomeSearchAppStrings._();
  static HomeFilterAppStrings get homeFilter => HomeFilterAppStrings._();
  static AccountAppStrings get account => AccountAppStrings._();

  static EventDetailAppStrings get eventDetail => EventDetailAppStrings();
  static BookingAppStrings get booking => BookingAppStrings._();
  static CheckoutAppStrings get checkout => CheckoutAppStrings._();
  static CheckoutSuccessAppStrings get checkoutSuccess =>
      CheckoutSuccessAppStrings._();
}

final class BottomNavigationAppString {
  const BottomNavigationAppString._();

  String get homeTab => 'Home';
  String get ticketTab => 'Tickets';
  String get accountTab => 'Account';
}

final class EmailInitialAppStrings {
  const EmailInitialAppStrings._();

  String get title => 'Sign in or sign up';

  String get bannerMessage =>
      'Use the same email address you used to buy your tickets';
}

final class ButtonAppStrings {
  const ButtonAppStrings._();

  String get nextLabel => 'Next';
}

final class TextFieldAppStrings {
  const TextFieldAppStrings._();

  String get passwordPlaceholder => 'Password';
  String get currentPasswordPlaceholder => 'Current password';
  String get confirmPasswordPlaceholder => 'Confirm password';
  String get newPasswordPlaceholder => 'New password';

  String get emailPlaceholder => 'Email address';
  String get confirmEmailPlaceholder => 'Confirm email address';
  String get firstNamePlaceholder => 'First name';
  String get lastNamePlaceholder => 'Last name';
  String get phoneNumberPlaceHolder => 'Phone number';

  String get emailValidationError => 'Please enter a valid email address';

  String get fieldIsRequiredValidationError => 'Field is required';

  String get passwordValidationError =>
      'Password must be at least 10 characters long and contain uppercase letters, lowercase letters, numbers, and special characters';

  String get phoneNumberValidationError =>
      'Phone number must start with +84 or 0 and have 9 digits';

  String fieldsDoNotMatch(String fieldName) => '$fieldName must match';
}

final class GenericErrorAppStrings {
  const GenericErrorAppStrings._();

  String get tryAgainMessage => 'An error occurred. Please try again.';
}

final class ErrorPageAppStrings {
  const ErrorPageAppStrings._();

  String get defaultTitle => 'Oops! Something went wrong';
  String get defaultMessage =>
      'We encountered an unexpected error. Please try again later.';
}

final class SignInAppStrings {
  const SignInAppStrings._();

  String get changeLabel => 'Change';

  String get forgotPasswordLabel => 'Forgot password?';

  String get signInLabel => 'Sign in';
}

final class SignUpAppStrings {
  const SignUpAppStrings._();

  String get signUpLabel => 'Sign up';
  String get title => 'Create an account';
  String get passwordStrengthLabel => 'Password strength';

  String get policiesAndTermsLabel =>
      'By signing up or signing in, I accept the <u>Eventbrite Terms of Service</u> and have read the <u>Privacy Policy</u>';
}

final class EventAppStrings {
  const EventAppStrings._();
  String get fewTicketsLeftTag => 'FEW TICKETS LEFT';
  String get freePricing => 'Free';
}

final class HomeAppStrings {
  const HomeAppStrings._();

  String get searchAppBarLabel => 'Find things to do';

  String searchAppBarTitle(String location) => 'In $location';

  String get personalizedEvents => 'Events for you';
}

final class HomeSearchAppStrings {
  const HomeSearchAppStrings._();

  String get appBarTitle => 'Search';
  String get searchButton => 'Search';
  String get countryDropdownPlaceholder => 'Country';
  String get cityDropdownPlaceholder => 'City';
}

final class HomeFilterAppStrings {
  String get appBarTitle => 'Filter';

  const HomeFilterAppStrings._();

  // Date filter
  String get dateFilter => 'Date';
  String get dateFilterAnyDate => 'Any date';
  String get dateFilterToday => 'Today';
  String get dateFilterTomorrow => 'Tomorrow';
  String get dateFilterWeekdays => 'Week days';
  String get dateFilterWeekends => 'Weekends';
  String get dateFilterCustomDate => 'Custom date';

  // Category filter
  String get categoryFilter => 'Category';

  // Buttons
  String get resetButton => 'Reset';
  String get applyFiltersButton => 'Apply Filters';
}

final class AccountAppStrings {
  const AccountAppStrings._();

  // App bar
  String get appBarTitle => 'Account';

  // Section titles
  String get preferencesSection => 'Preferences';
  String get helpSection => 'Help';
  String get legalSection => 'Legal';

  // General info
  String eventsAttended(int count) => '$count events attended';

  // Preference options
  String get interestOption => 'Interest';
  String get friendsOption => 'Friends';
  String get followingOrganizersOption => 'Organizers you follow';
  String get manageNotificationOption => 'Manage notifications';
  String get linkedAccountsOption => 'Linked accounts';

  // Help options
  String get browseHelpCenter => 'Browse Help Center';

  // Legal options
  String get termsOfServiceOption => 'Terms of service';
  String get privacyOption => 'Privacy';
  String get accessibilityOption => 'Accessibility';
  String get cookiesOption => 'Cookies';

  // Account settings
  String get updatePictureLabel => 'Update picture';
  String get changePasswordLabel => 'Change password';
  String get closeAccountLabel => 'Close account';

  // Other
  String get signOutLabel => 'Sign out';
  String get versionLabel => 'Version';

  // Photo setting
  String get takePhotoLabel => 'Take a photo';
  String get photoLibraryLabel => 'Choose from library';
  String get deteleLabel => 'Delete';
  String get cancelLabel => 'Cancel';
}

final class EventDetailAppStrings {
  String get overviewSection => 'Overview';
  String get locationSection => 'Location';
  String get organizerSection => 'Organizer';
  String get relatedEventsSection => 'You may also like ...';

  // Organizer card
  String get followButton => 'Follow';
  String get contactButton => 'Contact';
  String hostedForYears(int years) => 'Hosted for $years years';

  // Payment
  String get getTicketButton => 'Get ticket';
}

final class BookingAppStrings {
  const BookingAppStrings._();

  // Buttons
  String get registerButton => 'Register';
  String get applyButton => 'Apply';

  String get showMoreButton => 'Show more';
  String get showLessButton => 'Show less';

  // Text fields
  String get promoCodePlaceholder => 'Promo code';

  // Promo code errors
  String get promoCodeEmptyError => 'Promo code cannot be empty.';
  String get promoCodeRequirePaidTicketError =>
      'Add at least one paid ticket to apply a promo code.';
  String get promoCodeEventUnavailableError =>
      'Unable to apply promo code for this event.';
}

final class CheckoutAppStrings {
  const CheckoutAppStrings._();

  String get checkoutTitle => 'Checkout';
  String get orderSummarySectionTitle => 'Order summary';
  String get paymentMethodSectionTitle => 'Payment method';
  String get stripePaymentLabel => 'Stripe';
  String get promoCodeSectionTitle => 'Promo code';
  String get clearButtonLabel => 'Clear';

  String discountedPricingLabel({
    required double payableAmount,
    required double discountPercentage,
  }) {
    return '\$${payableAmount.toStringAsFixed(2)} '
        '(Discount ${discountPercentage.toStringAsFixed(0)}%)';
  }

  String discountAppliedBannerMessage({
    required double discountPercentage,
    required double payableAmount,
    required double originalAmount,
  }) {
    return 'Discount applied: ${discountPercentage.toStringAsFixed(0)}% - '
        'You pay \$${payableAmount.toStringAsFixed(2)} '
        '(was \$${originalAmount.toStringAsFixed(2)})';
  }
}

final class CheckoutSuccessAppStrings {
  const CheckoutSuccessAppStrings._();

  String get title => 'Your order is confirmed';
  String get subtitle => 'See you there!';
  String get viewTicketButtonLabel => 'View your ticket';
  String get returnHomeButtonLabel => 'Return home';
}
