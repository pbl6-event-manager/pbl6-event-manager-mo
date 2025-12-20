extension StringExtension on String {
  String withDot(String otherString) => '$this • $otherString';

  String get withCurrency => '\$$this';
}
