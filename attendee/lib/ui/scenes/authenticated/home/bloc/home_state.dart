part of "home_bloc.dart";

final class HomeState extends Equatable {
  final ViewStatusEnum status;
  final String? errorMessage;
  final int? selectedChipId;
  final List<(int, String)> chipData;
  final String currentLocation;
  final String? currentSearchQuery;
  final DateTime? filterStartDate;
  final DateTime? filterEndDate;
  final Set<int> selectedCategories;
  final List<Event> events;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.selectedChipId,
    required this.chipData,
    required this.currentLocation,
    required this.currentSearchQuery,
    required this.filterStartDate,
    required this.filterEndDate,
    required this.selectedCategories,
    required this.events,
  });

  const HomeState.initial()
    : status = ViewStatusEnum.initial,
      errorMessage = null,
      selectedChipId = null,
      currentLocation = "Hanoi",
      currentSearchQuery = null,
      chipData = const [],
      filterStartDate = null,
      filterEndDate = null,
      selectedCategories = const {},
      events = const [];

  HomeState copyWith({
    ViewStatusEnum? status,
    String? errorMessage,
    int? selectedChipId,
    List<(int, String)>? chipData,
    String? currentLocation,
    Nullable<String>? currentSearchQuery,
    Nullable<DateTime>? filterStartDate,
    Nullable<DateTime>? filterEndDate,
    Set<int>? selectedCategories,
    List<Event>? events,
  }) {
    return HomeState(
      currentSearchQuery: currentSearchQuery != null
          ? currentSearchQuery.value
          : this.currentSearchQuery,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedChipId: selectedChipId ?? this.selectedChipId,
      chipData: chipData ?? this.chipData,
      currentLocation: currentLocation ?? this.currentLocation,
      filterStartDate: filterStartDate != null
          ? filterStartDate.value
          : this.filterStartDate,
      filterEndDate: filterEndDate != null
          ? filterEndDate.value
          : this.filterEndDate,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      events: events ?? this.events,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    selectedChipId,
    chipData,
    currentLocation,
    currentSearchQuery,
    filterStartDate,
    filterEndDate,
    selectedCategories,
    events,
  ];
}
