part of 'home_bloc.dart';

final class HomeState extends Equatable {
  final ViewStatus status;
  final String? errorMessage;
  final Event? event;
  final List<OrderAttendee> orders;
  final List<Attendee> attendee;

  const HomeState({
    required this.status,
    required this.errorMessage,
    required this.event,
    required this.orders,
    required this.attendee,
  });

  const HomeState.init()
    : status = ViewStatus.initial,
      errorMessage = null,
      event = null,
      orders = const [],
      attendee = const [];

  HomeState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    Nullable<Event>? event,
    Nullable<List<OrderAttendee>>? orders,
    List<Attendee>? attendee,
  }) => HomeState(
    status: status ?? this.status,
    errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
    event: event != null ? event.value : this.event,
    orders: orders != null ? orders.value ?? const [] : this.orders,
    attendee: attendee ?? this.attendee,
  );

  @override
  List<Object?> get props => [status, errorMessage, event, orders, attendee];
}
