import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/domain/models/event.dart';
import 'package:organizer/domain/repositories/event_repository.dart';
import 'package:organizer/utils/helpers/nullable.dart';
import 'package:organizer/utils/helpers/result.dart';

part 'event_list_event.dart';
part 'event_list_state.dart';

class EventListBloc extends Bloc<EventListEvent, EventListState> {
  EventListBloc({required EventRepository eventRepository})
    : _eventRepository = eventRepository,
      super(const EventListState()) {
    on<EventListSubscriptionRequested>(_onSubscriptionRequested);
    on<EventListRefreshRequested>(_onRefreshRequested);
  }

  final EventRepository _eventRepository;

  Future<void> _onSubscriptionRequested(
    EventListSubscriptionRequested event,
    Emitter<EventListState> emit,
  ) async {
    await _fetchEvents(emit: emit, isRefresh: false);
  }

  Future<void> _onRefreshRequested(
    EventListRefreshRequested event,
    Emitter<EventListState> emit,
  ) async {
    await _fetchEvents(emit: emit, isRefresh: true);
  }

  Future<void> _fetchEvents({
    required Emitter<EventListState> emit,
    required bool isRefresh,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(isRefreshing: true));
    } else {
      emit(state.copyWith(status: EventListStatus.loading, errorMessage: null));
    }

    final Result<List<Event>> result = await _eventRepository.getEvents();

    switch (result) {
      case Ok(value: final events):
        emit(
          state.copyWith(
            status: EventListStatus.success,
            events: events,
            isRefreshing: false,
            errorMessage: null,
          ),
        );
      case Error(error: final error):
        emit(
          state.copyWith(
            status: EventListStatus.failure,
            isRefreshing: false,
            errorMessage: Nullable(error.toString()),
          ),
        );
    }
  }
}
