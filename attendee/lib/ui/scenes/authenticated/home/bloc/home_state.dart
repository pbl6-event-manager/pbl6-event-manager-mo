part of "home_bloc.dart";

final class HomeState extends Equatable {
  final ViewStatusEnum status;
  final String? errorMessage;
  final String currentLocation;
  final String? currentSearchQuery;
  final DateTime? filterStartDate;
  final DateTime? filterEndDate;
  final Set<int> selectedCategories;
  final List<Event> events;
  final bool isUsingCurrentLocation;

  const HomeState({
    required this.status,
    required this.errorMessage,

    required this.currentLocation,
    required this.currentSearchQuery,
    required this.filterStartDate,
    required this.filterEndDate,
    required this.selectedCategories,
    required this.events,
    required this.isUsingCurrentLocation,
  });

  const HomeState.initial()
    : status = ViewStatusEnum.initial,
      errorMessage = null,

      currentLocation = "Hanoi",
      currentSearchQuery = null,

      filterStartDate = null,
      filterEndDate = null,
      selectedCategories = const {},
      isUsingCurrentLocation = false,
      events = const [];

  HomeState copyWith({
    ViewStatusEnum? status,
    String? errorMessage,
    List<(int, String)>? chipData,
    String? currentLocation,
    Nullable<String>? currentSearchQuery,
    Nullable<DateTime>? filterStartDate,
    Nullable<DateTime>? filterEndDate,
    Set<int>? selectedCategories,
    List<Event>? events,
    bool? isUsingCurrentLocation,
  }) {
    return HomeState(
      currentSearchQuery: currentSearchQuery != null
          ? currentSearchQuery.value
          : this.currentSearchQuery,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,

      currentLocation: currentLocation ?? this.currentLocation,
      filterStartDate: filterStartDate != null
          ? filterStartDate.value
          : this.filterStartDate,
      filterEndDate: filterEndDate != null
          ? filterEndDate.value
          : this.filterEndDate,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      events: events ?? this.events,
      isUsingCurrentLocation:
          isUsingCurrentLocation ?? this.isUsingCurrentLocation,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    currentLocation,
    currentSearchQuery,
    filterStartDate,
    filterEndDate,
    selectedCategories,
    events,
    isUsingCurrentLocation,
  ];
}
