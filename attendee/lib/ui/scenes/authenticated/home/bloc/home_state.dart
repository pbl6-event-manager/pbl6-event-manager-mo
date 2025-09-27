part of "home_bloc.dart";

final class HomeState extends Equatable {
  final ViewStatusEnum status;
  final String? errorMessage;
  final int? selectedChipId;
  final List<(int, String)> chipData;
  final String? currentLocation;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.selectedChipId,
    required this.chipData,
    required this.currentLocation,
  });

  const HomeState.initial()
    : status = ViewStatusEnum.initial,
      errorMessage = null,
      selectedChipId = null,
      currentLocation = null,
      chipData = const [];

  HomeState copyWith({
    ViewStatusEnum? status,
    String? errorMessage,
    int? selectedChipId,
    List<(int, String)>? chipData,
    String? currentLocation,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedChipId: selectedChipId ?? this.selectedChipId,
      chipData: chipData ?? this.chipData,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    selectedChipId,
    chipData,
    currentLocation,
  ];
}
