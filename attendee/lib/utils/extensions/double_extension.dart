extension DoubleExtension on double {
  /// Get formated string from double
  ///
  /// If number is a whole number => return only the whole part
  ///
  /// Else, limit the decimal point to 2
  String parseString() {
    return toStringAsFixed(toInt() == this ? 0 : 2);
  }

  String get withCurrency => '\$$parseString()';

  String formatPriceLabel() {
    if (this == 0) {
      return 'Free';
    }

    return 'From \$${parseString()}';
  }
}
