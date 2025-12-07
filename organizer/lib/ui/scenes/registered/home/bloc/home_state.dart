part of 'home_bloc.dart';

final class HomeState extends Equatable {
  final ViewStatus status;
  final String? errorMessage;
  final Event? event;
  final List<OrderAttendee> attendees;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.event,
    required this.attendees,
  });

  const HomeState.init()
    : status = ViewStatus.initial,
      errorMessage = null,
      event = null,
      attendees = const [];

  HomeState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    Nullable<Event>? event,
    Nullable<List<OrderAttendee>>? attendees,
  }) => HomeState(
    status: status ?? this.status,
    errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
    event: event != null ? event.value : this.event,
    attendees: attendees != null ? attendees.value ?? const [] : this.attendees,
  );

  @override
  List<Object?> get props => [status, errorMessage, event, attendees];
}
