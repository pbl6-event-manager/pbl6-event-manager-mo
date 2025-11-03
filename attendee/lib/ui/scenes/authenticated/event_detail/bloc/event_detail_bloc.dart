import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/helpers/async_value.dart';
import 'package:attendee/utils/helpers/nullable.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  EventDetailBloc() : super(EventDetailState.inital()) {
    on<EventDetailLoad>(_onLoaded);
    on<EventDetailRefresh>(_onRefresh);
  }

  /// If event is given => update that event to current state and show immediately
  ///
  /// Else, load using given id
  Future<void> _onLoaded(
    EventDetailLoad event,
    Emitter<EventDetailState> emit,
  ) async {
    // If event is not null => use that event
    if (event.event != null) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.success,
          event: Nullable(Event.dummyEvent),
        ),
      );

      await Future.wait([_fetchOrganizer(emit), _fetchSuggestedEvents(emit)]);

      // Otherwise, load event through ID
    } else {
      // TODO: REMOVE DUMMY AND CALL API HERE
      emit(state.copyWith(status: ViewStatusEnum.loading));
      await Future.delayed(Duration(seconds: 5));
      emit(
        state.copyWith(
          status: ViewStatusEnum.success,
          event: Nullable(Event.dummyEvent),
        ),
      );
      await Future.wait([_fetchOrganizer(emit), _fetchSuggestedEvents(emit)]);
    }
  }

  Future<void> _onRefresh(
    EventDetailRefresh event,
    Emitter<EventDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ViewStatusEnum.success,
        event: Nullable(Event.dummyEvent),
      ),
    );
    await Future.wait([_fetchOrganizer(emit), _fetchSuggestedEvents(emit)]);
  }

  Future<void> _fetchOrganizer(Emitter<EventDetailState> emit) async {
    final ownerId = state.event?.ownerId;
    if (ownerId == null) {
      emit(
        state.copyWith(
          errorMessage: Nullable(
            AppStringConstants.genericErrors.tryAgainMessage,
          ),
          organizer: AsyncValue.error(
            AppStringConstants.genericErrors.tryAgainMessage,
          ),
        ),
      );
      return;
    }

    // Set loading state
    emit(state.copyWith(organizer: AsyncValue.loading()));

    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(organizer: AsyncValue.data(Organizer.dummyOrganizer)));
  }

  Future<void> _fetchSuggestedEvents(Emitter<EventDetailState> emit) async {
    emit(state.copyWith(suggestedEvents: AsyncValue.loading()));
    await Future.delayed(Duration(seconds: 2));
    emit(
      state.copyWith(
        suggestedEvents: AsyncValue.data([
          Event.dummyEvent,
          Event.dummyEvent,
          Event.dummyEvent,
        ]),
      ),
    );
  }
}
