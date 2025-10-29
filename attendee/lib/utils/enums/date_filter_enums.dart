import 'package:attendee/utils/constants/app_string_constants.dart';

enum DateFilterEnums {
  any,
  today,
  tomorrow,
  weekdays,
  weekends,
  custom;

  String get uiLabel => switch (this) {
    DateFilterEnums.any => AppStringConstants.homeFilter.dateFilterAnyDate,
    DateFilterEnums.today => AppStringConstants.homeFilter.dateFilterToday,
    DateFilterEnums.tomorrow =>
      AppStringConstants.homeFilter.dateFilterTomorrow,
    DateFilterEnums.weekdays =>
      AppStringConstants.homeFilter.dateFilterWeekdays,
    DateFilterEnums.weekends =>
      AppStringConstants.homeFilter.dateFilterWeekends,
    DateFilterEnums.custom =>
      AppStringConstants.homeFilter.dateFilterCustomDate,
  };
}
