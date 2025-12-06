part of 'event_list_bloc.dart';

enum EventListStatus { initial, loading, success, failure }

final class EventListState extends Equatable {
  const EventListState({
    this.status = EventListStatus.initial,
    this.events = const <Event>[],
    this.isRefreshing = false,
    this.errorMessage,
  });

  final EventListStatus status;
  final List<Event> events;
  final bool isRefreshing;
  final String? errorMessage;

  bool get isLoading => status == EventListStatus.loading;

  EventListState copyWith({
    EventListStatus? status,
    List<Event>? events,
    bool? isRefreshing,
    Nullable<String>? errorMessage,
  }) {
    return EventListState(
      status: status ?? this.status,
      events: events ?? this.events,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: errorMessage != null
          ? errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, events, isRefreshing, errorMessage];
}
