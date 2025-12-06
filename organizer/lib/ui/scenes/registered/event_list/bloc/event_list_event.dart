part of 'event_list_bloc.dart';

sealed class EventListEvent extends Equatable {
  const EventListEvent();

  @override
  List<Object?> get props => [];
}

final class EventListSubscriptionRequested extends EventListEvent {
  const EventListSubscriptionRequested();
}

final class EventListRefreshRequested extends EventListEvent {
  const EventListRefreshRequested();
}
