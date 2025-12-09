import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/domain/models/attendee.dart';
import 'package:organizer/domain/models/event.dart';
import 'package:organizer/domain/models/order_attendee.dart';
import 'package:organizer/domain/repositories/order_repository.dart';
import 'package:organizer/utils/constants/shared_ref_constant.dart';
import 'package:organizer/utils/enums/view_status.dart';
import 'package:organizer/utils/helpers/nullable.dart';
import 'package:organizer/utils/helpers/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPreferences _prefs;
  final OrderRepository _orderRepository;

  HomeBloc({
    required SharedPreferences pref,
    required OrderRepository orderRepository,
  }) : _prefs = pref,
       _orderRepository = orderRepository,
       super(HomeState.init()) {
    on<HomeLoaded>(_onHomeLoaded);
    on<HomeEventSelected>(_onEventSelected);
  }

  Future<void> _onEventSelected(
    HomeEventSelected event,
    Emitter<HomeState> emit,
  ) async {
    _prefs.setString(SharedPrefConstant.eventId, event.event.toJsonString);
    await _fetchAttendees(event: event.event, emit: emit);
  }

  Future<void> _onHomeLoaded(HomeLoaded event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: ViewStatus.loading));

    try {
      final String? storedEvent = _prefs.getString(SharedPrefConstant.eventId);

      if (storedEvent == null || storedEvent.isEmpty) {
        emit(
          state.copyWith(
            status: ViewStatus.success,
            event: const Nullable(null),
            orders: const Nullable(<OrderAttendee>[]),
            errorMessage: const Nullable(null),
          ),
        );
        return;
      }

      final Event parsedEvent = Event.fromJsonString(storedEvent);
      await _fetchAttendees(event: parsedEvent, emit: emit);
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatus.failure,
          event: const Nullable(null),
          orders: const Nullable(<OrderAttendee>[]),
          errorMessage: Nullable(error.toString()),
        ),
      );
    }
  }

  Future<void> _fetchAttendees({
    required Event event,
    required Emitter<HomeState> emit,
  }) async {
    emit(
      state.copyWith(
        status: ViewStatus.loading,
        event: Nullable(event),
        attendee: [],
        errorMessage: const Nullable(null),
      ),
    );

    final result = await _orderRepository.getAttendees(eventId: event.id);

    switch (result) {
      case Ok(value: final attendees):
        emit(
          state.copyWith(
            status: ViewStatus.success,
            attendee: attendees,
            errorMessage: const Nullable(null),
          ),
        );
      case Error(error: final error):
        emit(
          state.copyWith(
            status: ViewStatus.failure,
            attendee: [],
            errorMessage: Nullable(error.toString()),
          ),
        );
    }
  }
}
