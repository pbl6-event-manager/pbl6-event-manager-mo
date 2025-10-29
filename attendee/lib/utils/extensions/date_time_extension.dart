import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  // Sun, 21 Sep • 17:30
  String get shortenStringWithDot =>
      DateFormat('ccc, dd MMM • hh:mm').format(this);

  bool get isToday {
    final DateTime today = DateTime.now();
    return year == today.year && month == today.month && day == today.day;
  }

  bool get isTomorrow {
    final DateTime today = DateTime.now();
    return year == today.year && month == today.month && day == today.day + 1;
  }

  bool isSameDate(DateTime anotherDateTime) =>
      day == anotherDateTime.day &&
      month == anotherDateTime.month &&
      year == anotherDateTime.year;

  // Get the start and end week days, given a day in the week
  (DateTime, DateTime) get weekdays {
    final DateTime monday = subtract(Duration(days: weekday - 1));
    final DateTime friday = (weekday <= 5)
        ? add(Duration(days: 5 - weekday))
        : subtract(Duration(days: weekday - 5));
    return (monday, friday);
  }

  // Get the start and end weekend days, given a day in the week
  (DateTime, DateTime) get weekends {
    final DateTime sunday = add(Duration(days: 7 - weekday));
    final DateTime saturday = (weekday <= 6)
        ? add(Duration(days: 6 - weekday))
        : subtract(Duration(days: weekday - 6));
    return (saturday, sunday);
  }
}
