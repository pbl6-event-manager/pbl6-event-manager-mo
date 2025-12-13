extension DoubleExtension on double {
  /// Get formated string from double
  ///
  /// If number is a whole number => return only the whole part
  ///
  /// Else, limit the decimal point to 2
  String parseString() {
    return toStringAsFixed(toInt() == this ? 0 : 2);
  }
}
