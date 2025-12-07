import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/domain/models/event.dart';
import 'package:organizer/utils/constants/shared_ref_constant.dart';

import 'package:organizer/utils/enums/view_status.dart';
import 'package:organizer/utils/helpers/nullable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPreferences _prefs;
  HomeBloc({required SharedPreferences pref})
    : _prefs = pref,
      super(HomeState.init()) {
    on<HomeLoaded>(_onHomeLoaded);
    on<HomeEventSelected>(_onEventSelected);
  }

  void _onEventSelected(HomeEventSelected event, Emitter<HomeState> emit) {
    _prefs.setString(SharedPrefConstant.eventId, event.event.toJsonString);
    emit(
      state.copyWith(
        status: ViewStatus.success,
        event: Nullable(event.event),
        errorMessage: Nullable(null),
      ),
    );
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
            errorMessage: const Nullable(null),
          ),
        );
        return;
      }

      final Event parsedEvent = Event.fromJsonString(storedEvent);

      emit(
        state.copyWith(
          status: ViewStatus.success,
          event: Nullable(parsedEvent),
          errorMessage: const Nullable(null),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatus.failure,
          event: const Nullable(null),
          errorMessage: Nullable(error.toString()),
        ),
      );
    }
  }
}
