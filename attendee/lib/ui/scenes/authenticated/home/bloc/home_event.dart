part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeLoad extends HomeEvent {
  const HomeLoad();
}

final class HomeReload extends HomeEvent {
  const HomeReload();
}

final class HomeReturnedFromSearch extends HomeEvent {
  const HomeReturnedFromSearch({this.searchData});

  final (String?, String?, bool)? searchData;

  @override
  List<Object?> get props => [searchData];
}

final class HomeEventSearchCleared extends HomeEvent {
  const HomeEventSearchCleared();
}

final class HomeReturnedFromFilter extends HomeEvent {
  const HomeReturnedFromFilter({this.filterData});

  final (DateTime?, DateTime?, Set<int>)? filterData;

  @override
  List<Object?> get props => [filterData];
}
