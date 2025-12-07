part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeEvent {
  const HomeLoaded();
}

class HomeEventSelected extends HomeEvent {
  final Event event;

  const HomeEventSelected({required this.event});

  @override
  List<Object?> get props => [event];
}
