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
      selectedCategories = const {};

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
  ];
}
