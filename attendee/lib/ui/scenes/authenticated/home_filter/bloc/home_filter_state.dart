part of "home_filter_bloc.dart";

final class HomeFilterState extends Equatable {
  const HomeFilterState({
    required this.status,
    required this.errorMessage,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.selectedCategories,
  });

  const HomeFilterState.initial()
    : status = ViewStatusEnum.initial,
      errorMessage = null,
      selectedEndDate = null,
      selectedStartDate = null,
      selectedCategories = const {};

  final ViewStatusEnum status;
  final String? errorMessage;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Set<int> selectedCategories;

  DateFilterEnums get dateType {
    if (selectedEndDate == null) {
      if (selectedStartDate == null) {
        return DateFilterEnums.any;
      }
      if (selectedStartDate!.isToday) {
        return DateFilterEnums.today;
      }

      if (selectedStartDate!.isTomorrow) {
        return DateFilterEnums.tomorrow;
      }
    }

    // Check for weekdays (Monday to Friday)
    final (DateTime weekdayStart, DateTime weekdayEnd) =
        selectedStartDate!.weekdays;
    if (selectedStartDate!.isSameDate(weekdayStart) &&
        selectedEndDate!.isSameDate(weekdayEnd)) {
      return DateFilterEnums.weekdays;
    }

    // Check for weekends (Saturday to Sunday)
    final (DateTime weekendStart, DateTime weekendEnd) =
        selectedStartDate!.weekends;
    if (selectedStartDate!.isSameDate(weekendStart) &&
        selectedEndDate!.isSameDate(weekendEnd)) {
      return DateFilterEnums.weekends;
    }

    return DateFilterEnums.custom;
  }

  bool get isSelectedCategoryEmpty => selectedCategories.isEmpty;
  bool get hasFilterChanged =>
      selectedCategories.isNotEmpty || dateType != DateFilterEnums.any;

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    selectedStartDate,
    selectedEndDate,
    selectedCategories,
  ];

  HomeFilterState copyWith({
    ViewStatusEnum? status,
    Nullable<String>? errorMessage,
    Nullable<DateTime>? selectedStartDate,
    Nullable<DateTime>? selectedEndDate,
    Set<int>? selectedCategories,
  }) {
    return HomeFilterState(
      status: status ?? this.status,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
      selectedStartDate: selectedStartDate != null
          ? selectedStartDate.value
          : this.selectedStartDate,
      selectedEndDate: selectedEndDate != null
          ? selectedEndDate.value
          : this.selectedEndDate,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }
}
