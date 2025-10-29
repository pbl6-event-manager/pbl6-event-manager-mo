part of 'home_search_bloc.dart';

sealed class HomeSearchEvent extends Equatable {
  const HomeSearchEvent();

  @override
  List<Object?> get props => [];
}

class HomeSearchModeChanged extends HomeSearchEvent {
  const HomeSearchModeChanged(this.mode);
  final HomeSearchMode mode;
  @override
  List<Object?> get props => [mode];
}

class HomeSearchEventQueryChanged extends HomeSearchEvent {
  const HomeSearchEventQueryChanged(this.query);
  final String? query;

  @override
  List<Object?> get props => [query];
}

class HomeSearchLocationQueryChanged extends HomeSearchEvent {
  const HomeSearchLocationQueryChanged(this.query);
  final String? query;
  @override
  List<Object?> get props => [query];
}

class HomeSearchFocusedFieldChanged extends HomeSearchEvent {
  const HomeSearchFocusedFieldChanged(this.modeOfFocusedField);
  final HomeSearchMode modeOfFocusedField;

  @override
  List<Object?> get props => [modeOfFocusedField];
}

class HomeCountrySelected extends HomeSearchEvent {
  const HomeCountrySelected({required this.country});
  final String country;

  @override
  List<Object?> get props => [country];
}

class HomeCitySelected extends HomeSearchEvent {
  const HomeCitySelected({required this.city});
  final String city;

  @override
  List<Object?> get props => [city];
}
