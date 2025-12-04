import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get string {
    final DateFormat dateFormat = DateFormat("EEE, d MMM yyyy 'at' HH:mm");
    return dateFormat.format(this);
  }
}
