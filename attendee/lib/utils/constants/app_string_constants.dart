abstract class AppStringConstants {
  static BottomNavigationAppString get bottomNavigation =>
      BottomNavigationAppString._();

  static EmailInitialAppStrings get emailInitial => EmailInitialAppStrings._();
  static ButtonAppStrings get buttons => ButtonAppStrings._();
  static TextFieldAppStrings get textFields => TextFieldAppStrings._();
  static GenericErrorAppStrings get genericErrors => GenericErrorAppStrings._();
  static SignInAppStrings get signIn => SignInAppStrings._();
  static SignUpAppStrings get signUp => SignUpAppStrings._();
  static EventAppStrings get event => EventAppStrings._();

  static HomeAppStrings get home => HomeAppStrings._();
  static HomeSearchAppStrings get homeSearch => HomeSearchAppStrings._();
  static HomeFilterAppStrings get homeFilter => HomeFilterAppStrings._();
}

final class BottomNavigationAppString {
  const BottomNavigationAppString._();

  String get homeTab => "Home";
  String get ticketTab => "Tickets";
  String get accountTab => "Account";
}

final class EmailInitialAppStrings {
  const EmailInitialAppStrings._();

  String get title => "Sign in or sign up";

  String get bannerMessage =>
      "Use the same email address you used to buy your tickets";
}

final class ButtonAppStrings {
  const ButtonAppStrings._();

  String get nextLabel => "Next";
}

final class TextFieldAppStrings {
  const TextFieldAppStrings._();

  String get passwordPlaceholder => "Password";
  String get emailPlaceholder => "Email address";
  String get confirmEmailPlaceholder => "Confirm email address";
  String get firstNamePlaceholder => "First name";
  String get lastNamePlaceholder => "Last name";

  String get emailValidationError => "Please enter a valid email address";

  String get fieldIsRequiredValidationError => "Field is required";

  String get passwordValidationError =>
      "Password must be at least 10 characters long and contain uppercase letters, lowercase letters, numbers, and special characters";

  String fieldsDoNotMatch(String fieldName) => "$fieldName must match";
}

final class GenericErrorAppStrings {
  const GenericErrorAppStrings._();

  String get tryAgainMessage => "An error occurred. Please try again.";
}

final class SignInAppStrings {
  const SignInAppStrings._();

  String get changeLabel => "Change";

  String get forgotPasswordLabel => "Forgot password?";

  String get signInLabel => "Sign in";
}

final class SignUpAppStrings {
  const SignUpAppStrings._();

  String get signUpLabel => "Sign up";
  String get title => "Create an account";
  String get passwordStrengthLabel => "Password strength";

  String get policiesAndTermsLabel =>
      "By signing up or signing in, I accept the <u>Eventbrite Terms of Service</u> and have read the <u>Privacy Policy</u>";
}

final class EventAppStrings {
  const EventAppStrings._();
  String get fewTicketsLeftTag => "FEW TICKETS LEFT";
  String get freePricing => "Free";
}

final class HomeAppStrings {
  const HomeAppStrings._();

  String get searchAppBarLabel => "Find things to do";

  String searchAppBarTitle(String location) => "In $location";

  String get personalizedEvents => "Events for you";
}

final class HomeSearchAppStrings {
  const HomeSearchAppStrings._();

  String get appBarTitle => "Search";
  String get searchButton => "Search";
  String get countryDropdownPlaceholder => "Country";
  String get cityDropdownPlaceholder => "City";
}

final class HomeFilterAppStrings {
  String get appBarTitle => "Filter";

  const HomeFilterAppStrings._();

  // Date filter
  String get dateFilter => "Date";
  String get dateFilterAnyDate => "Any date";
  String get dateFilterToday => "Today";
  String get dateFilterTomorrow => "Tomorrow";
  String get dateFilterWeekdays => "Week days";
  String get dateFilterWeekends => "Weekends";
  String get dateFilterCustomDate => "Custom date";

  // Category filter
  String get categoryFilter => "Category";

  // Buttons
  String get resetButton => "Reset";
  String get applyFiltersButton => "Apply Filters";
}
