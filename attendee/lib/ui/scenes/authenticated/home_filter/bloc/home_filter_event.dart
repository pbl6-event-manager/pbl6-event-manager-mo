part of "home_filter_bloc.dart";

sealed class HomeFilterEvent extends Equatable {
  const HomeFilterEvent();

  @override
  List<Object?> get props => [];
}

final class HomeFilterLoaded extends HomeFilterEvent {
  final Set<int> selectedCategoryId;
  final DateTime? startDate;
  final DateTime? endDate;

  const HomeFilterLoaded({
    required this.selectedCategoryId,
    required this.startDate,
    required this.endDate,
  });
  @override
  List<Object?> get props => [selectedCategoryId, startDate, endDate];
}

final class HomeFilterCategoryTapped extends HomeFilterEvent {
  final int chosenCategoryId;

  const HomeFilterCategoryTapped({required this.chosenCategoryId});
  @override
  List<Object?> get props => [chosenCategoryId];
}

final class HomeFilterResetCategoryTapped extends HomeFilterEvent {
  const HomeFilterResetCategoryTapped();
}

final class HomeFilterResetTapped extends HomeFilterEvent {
  const HomeFilterResetTapped();
}

final class HomeFilterDayTapped extends HomeFilterEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const HomeFilterDayTapped({required this.startDate, required this.endDate});

  @override
  List<Object?> get props => [startDate, endDate];
}
