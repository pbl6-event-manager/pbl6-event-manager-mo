part of 'event_detail_bloc.dart';

final class EventDetailState extends Equatable {
  final ViewStatusEnum status;
  final String? errorMessage;
  final String? uiMessage;

  final Event? event;
  final AsyncValue<Organizer> organizer;
  final AsyncValue<List<Event>> suggestedEvents;

  const EventDetailState({
    required this.status,
    required this.errorMessage,
    required this.uiMessage,
    required this.event,
    required this.organizer,
    required this.suggestedEvents,
  });
  EventDetailState.inital()
    : status = ViewStatusEnum.initial,
      event = null,
      organizer = AsyncValue.loading(),
      suggestedEvents = AsyncValue.loading(),
      errorMessage = null,
      uiMessage = null;

  @override
  List<Object?> get props => [
    event,
    organizer,
    suggestedEvents,
    status,
    errorMessage,
    uiMessage,
  ];

  EventDetailState copyWith({
    ViewStatusEnum? status,
    Nullable<String>? errorMessage,
    Nullable<String>? uiMessage,
    Nullable<Event>? event,
    AsyncValue<Organizer>? organizer,
    AsyncValue<List<Event>>? suggestedEvents,
  }) {
    return EventDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage?.value,
      uiMessage: uiMessage?.value,
      event: event != null ? event.value : this.event,
      organizer: organizer ?? this.organizer,
      suggestedEvents: suggestedEvents ?? this.suggestedEvents,
    );
  }
}
