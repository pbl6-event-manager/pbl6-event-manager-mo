part of 'home_bloc.dart';

final class HomeState extends Equatable {
  final ViewStatus status;
  final String? errorMessage;
  final Event? event;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.event,
  });

  const HomeState.init()
    : status = ViewStatus.initial,
      errorMessage = null,
      event = null;

  HomeState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    Nullable<Event>? event,
  }) => HomeState(
    status: status ?? this.status,
    errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
    event: event != null ? event.value : this.event,
  );

  @override
  List<Object?> get props => [status, errorMessage, event];
}
