abstract class AppStringConstants {
  static EmailInitialAppStrings get emailInitial => EmailInitialAppStrings._();
  static ButtonAppStrings get buttons => ButtonAppStrings._();
  static TextFieldAppStrings get textFields => TextFieldAppStrings._();
  static GenericErrorAppStrings get genericErrors => GenericErrorAppStrings._();
  static SignInAppStrings get signIn => SignInAppStrings._();
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
  String get emailPlaceholder => 'Email address';

  String get emailValidationError => 'Please enter a valid email address';

  String get fieldIsRequiredValidationError => 'Field is required';
}

final class GenericErrorAppStrings {
  const GenericErrorAppStrings._();

  String get tryAgainMessage => "An error occurred. Please try again.";
}

final class SignInAppStrings {
  const SignInAppStrings._();

  String get changeLabel => 'Change';

  String get forgotPasswordLabel => 'Forgot password?';

  String get signInLabel => 'Sign in';
}
