abstract class AppStringConstants {
  static EmailInitialAppStrings get emailInitial => EmailInitialAppStrings._();

  static ButtonAppStrings get buttons => ButtonAppStrings._();

  static  TextFieldAppStrings get textFields => TextFieldAppStrings._();


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

  String get emailPlaceholder => 'Email address';

  String get emailValidationError => 'Please enter a valid email address';
}
