part of "home_search_bloc.dart";

sealed class HomeSearchEvent extends Equatable {
  const HomeSearchEvent();

  @override
  List<Object?> get props => [];
}

class HomeSearchLoaded extends HomeSearchEvent {
  final String? currentLocation;
  final String? currentEventSearchQuery;

  const HomeSearchLoaded({
    required this.currentLocation,
    required this.currentEventSearchQuery,
  });

  @override
  List<Object?> get props => [currentLocation, currentEventSearchQuery];
}

class HomeSearchModeChanged extends HomeSearchEvent {
  const HomeSearchModeChanged(this.mode);
  final HomeSearchMode mode;
}

class HomeSearchEventQueryChanged extends HomeSearchEvent {
  const HomeSearchEventQueryChanged(this.query);
  final String? query;
}

class HomeSearchLocationQueryChanged extends HomeSearchEvent {
  const HomeSearchLocationQueryChanged(this.query);
  final String? query;
}

class HomeSearchFocusedFieldChanged extends HomeSearchEvent {
  const HomeSearchFocusedFieldChanged(this.modeOfFocusedField);
  final HomeSearchMode modeOfFocusedField;
}

class HomeSearchClearRecentItem extends HomeSearchEvent {
  const HomeSearchClearRecentItem({required this.value});
  final String value;
}
