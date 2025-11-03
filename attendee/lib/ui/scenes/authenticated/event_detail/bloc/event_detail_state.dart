part of 'event_detail_bloc.dart';

final class EventDetailState extends Equatable {
  final ViewStatusEnum status;
  final String? errorMessage;

  final Event? event;
  final AsyncValue<Organizer> organizer;
  final AsyncValue<List<Event>> suggestedEvents;

  const EventDetailState({
    required this.status,
    required this.errorMessage,
    required this.event,
    required this.organizer,
    required this.suggestedEvents,
  });
  EventDetailState.inital()
    : status = ViewStatusEnum.initial,
      event = null,
      organizer = AsyncValue.loading(),
      suggestedEvents = AsyncValue.loading(),
      errorMessage = null;

  @override
  List<Object?> get props => [
    event,
    organizer,
    suggestedEvents,
    status,
    errorMessage,
  ];

  EventDetailState copyWith({
    ViewStatusEnum? status,
    Nullable<String>? errorMessage,
    Nullable<Event>? event,
    AsyncValue<Organizer>? organizer,
    AsyncValue<List<Event>>? suggestedEvents,
  }) {
    return EventDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage?.value,
      event: event != null ? event.value : this.event,
      organizer: organizer ?? this.organizer,
      suggestedEvents: suggestedEvents ?? this.suggestedEvents,
    );
  }
}
