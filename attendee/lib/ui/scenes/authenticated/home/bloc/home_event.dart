part of "home_bloc.dart";

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

final class HomeChipSelected extends HomeEvent {
  const HomeChipSelected(this.chipId);

  final int chipId;

  @override
  List<Object?> get props => [chipId];
}

final class HomeReturnedFromSearch extends HomeEvent {
  const HomeReturnedFromSearch({this.searchData});

  final (String?, String?)? searchData;

  @override
  List<Object?> get props => [searchData];
}

final class HomeEventSearchCleared extends HomeEvent {
  const HomeEventSearchCleared();
}
