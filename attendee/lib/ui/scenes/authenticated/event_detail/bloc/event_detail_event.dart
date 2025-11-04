part of 'event_detail_bloc.dart';

sealed class EventDetailEvent extends Equatable {
  const EventDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Initial loads with event id and optional event object
final class EventDetailLoad extends EventDetailEvent {
  const EventDetailLoad({required this.eventId, this.event});

  final int eventId;
  final Event? event;

  @override
  List<Object?> get props => [eventId, event];
}

/// Refresh
final class EventDetailRefresh extends EventDetailEvent {
  const EventDetailRefresh();
}

/// Address copy pressed
final class EventDetailAddressCopyPressed extends EventDetailEvent {
  const EventDetailAddressCopyPressed({this.eventId, this.event});

  final int? eventId;
  final Event? event;

  @override
  List<Object?> get props => [eventId, event];
}

/// Share pressed
final class EventDetailSharePressed extends EventDetailEvent {
  const EventDetailSharePressed({this.eventId, this.event});

  final int? eventId;
  final Event? event;

  @override
  List<Object?> get props => [eventId, event];
}

/// Favorite pressed
final class EventDetailFavoritePressed extends EventDetailEvent {
  const EventDetailFavoritePressed({this.eventId, this.event});

  final int? eventId;
  final Event? event;

  @override
  List<Object?> get props => [eventId, event];
}

/// Get ticket pressed

/// Clear UI message (after showing to user)
final class EventDetailUiMessageCleared extends EventDetailEvent {
  const EventDetailUiMessageCleared();
}
