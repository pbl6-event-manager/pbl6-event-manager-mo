import "package:attendee/utils/constants/app_string_constants.dart";

enum DateFilterEnums {
  all,
  today,
  tomorrow,
  custom;

  String get uiLabel => switch (this) {
    DateFilterEnums.all => AppStringConstants.homeFilter.dateFilterAnyDate,
    DateFilterEnums.today => AppStringConstants.homeFilter.dateFilterToday,
    DateFilterEnums.tomorrow =>
      AppStringConstants.homeFilter.dateFilterTomorrow,
    DateFilterEnums.custom =>
      AppStringConstants.homeFilter.dateFilterCustomDate,
  };
}
