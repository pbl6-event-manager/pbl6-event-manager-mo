import "package:intl/intl.dart";

extension DateTimeExtension on DateTime {
  // Sun, 21 Sep • 17:30
  String get shortenStringWithDot =>
      DateFormat("ccc, dd MMM • hh:mm").format(this);
}
