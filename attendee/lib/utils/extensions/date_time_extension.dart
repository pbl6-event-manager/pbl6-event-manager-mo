import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  // Sun, 21 Sep • 17:30
  String get shortenDateTimeStringWithDot =>
      DateFormat('ccc, dd MMM • hh:mm').format(this);

  // Sun, 21 Sep
  String get shortenDateString => DateFormat('ccc, dd MMM').format(this);

  String get dateStringWithoutYear => DateFormat('dd MMM').format(this);

  String get dateString => DateFormat('ccc, dd MMM yyyy').format(this);

  String get timeString => DateFormat(DateFormat.HOUR_MINUTE).format(this);

  // 1 Nov at 13:20 PST
  String get shortString {
    final String dateString = DateFormat('d MMM \'at\' HH:mm').format(this);
    final String timezone = _getTimezoneAbbreviation();
    return '$dateString $timezone';
  }

  String _getTimezoneAbbreviation() {
    // Get the timezone offset
    final offset = timeZoneOffset;
    final hours = offset.inHours;
    final minutes = (offset.inMinutes % 60).abs();

    // Try to get a proper timezone abbreviation
    final tzName = timeZoneName;

    // If timeZoneName is already a readable abbreviation (not just numbers), use it
    if (tzName.isNotEmpty &&
        !tzName.startsWith('+') &&
        !tzName.startsWith('-')) {
      return tzName;
    }

    // Otherwise, format as GMT+X or GMT-X
    final sign = hours >= 0 ? '+' : '-';
    final absHours = hours.abs();
    if (minutes == 0) {
      return 'GMT$sign$absHours';
    } else {
      return 'GMT$sign$absHours:${minutes.toString().padLeft(2, '0')}';
    }
  }

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

  int yearsBetween(DateTime to) {
    return (to.difference(this).inDays / 365).floor();
  }
}
