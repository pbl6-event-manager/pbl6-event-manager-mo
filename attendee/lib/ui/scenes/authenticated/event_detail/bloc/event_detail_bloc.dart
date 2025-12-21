import 'package:attendee/domain/models/event.dart';
import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/domain/repositories/event_repository.dart';
import 'package:attendee/domain/usecases/copy_string_to_clipboard_usecase.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/enums/view_status_enum.dart';
import 'package:attendee/utils/helpers/async_value.dart';
import 'package:attendee/utils/helpers/nullable.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_detail_event.dart';
part 'event_detail_state.dart';

class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final EventRepository _eventRepository;

  final CopyStringToClipboardUsecase _copyStringToClipboardUsecase;

  int? eventId;

  EventDetailBloc({
    required EventRepository eventRepository,
    required CopyStringToClipboardUsecase copyStringToClipboardUsecase,
  }) : _eventRepository = eventRepository,

       _copyStringToClipboardUsecase = copyStringToClipboardUsecase,

       super(EventDetailState.inital()) {
    on<EventDetailLoad>(_onLoaded);
    on<EventDetailRefresh>(_onRefresh);
    on<EventDetailAddressCopyPressed>(_onCopyAddressToClipboard);
    on<EventDetailUiMessageCleared>(_onUiMessageCleared);
  }

  /// If event is given => update that event to current state and show immediately
  ///
  /// Else, load using given id
  Future<void> _onLoaded(
    EventDetailLoad event,
    Emitter<EventDetailState> emit,
  ) async {
    eventId = event.eventId;
    // If event is not null => use that event
    if (event.event != null) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.success,
          event: Nullable(event.event),
        ),
      );

      final int idToLoad = event.event!.id;
      final Result<Event> fullEventResponse = await _eventRepository
          .getEventById(id: idToLoad);
      switch (fullEventResponse) {
        case Ok<Event>():
          emit(
            state.copyWith(
              event: Nullable(fullEventResponse.value),
              organizer: fullEventResponse.value.organizer != null
                  ? AsyncValue.data(fullEventResponse.value.organizer!)
                  : null,
            ),
          );
        case Error<Event>():
          emit(
            state.copyWith(
              errorMessage: Nullable(
                AppStringConstants.genericErrors.tryAgainMessage,
              ),
            ),
          );
      }

      await Future.wait([_fetchSuggestedEvents(emit)]);

      // Otherwise, load event through ID
    } else {
      final Result<Event> eventResponse = await _eventRepository.getEventById(
        id: event.eventId,
      );

      switch (eventResponse) {
        case Ok<Event>():
          emit(
            state.copyWith(
              status: ViewStatusEnum.success,
              event: Nullable(eventResponse.value),
            ),
          );
          await Future.wait([_fetchSuggestedEvents(emit)]);
        case Error<Event>():
          emit(
            state.copyWith(
              status: ViewStatusEnum.failure,
              errorMessage: Nullable(
                AppStringConstants.genericErrors.tryAgainMessage,
              ),
            ),
          );
      }
    }
  }

  Future<void> _onRefresh(
    EventDetailRefresh event,
    Emitter<EventDetailState> emit,
  ) async {
    if (eventId == null) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: Nullable(
            AppStringConstants.genericErrors.tryAgainMessage,
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(status: ViewStatusEnum.loading));

    final Result<Event> eventResponse = await _eventRepository.getEventById(
      id: eventId!,
    );

    switch (eventResponse) {
      case Ok<Event>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.success,
            event: Nullable(eventResponse.value),
          ),
        );
        await Future.wait([_fetchSuggestedEvents(emit)]);
      case Error<Event>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.failure,
            errorMessage: Nullable(
              AppStringConstants.genericErrors.tryAgainMessage,
            ),
          ),
        );
    }
  }

  Future<void> _onCopyAddressToClipboard(
    EventDetailAddressCopyPressed event,
    Emitter<EventDetailState> emit,
  ) async {
    final hasCopySuccess = await _copyStringToClipboardUsecase.execute(
      dataToCopy:
          '${state.event?.address} - ${state.event?.cityAndCountryLabel}',
    );

    emit(
      state.copyWith(
        errorMessage: hasCopySuccess == false
            ? Nullable('Cannot copy address')
            : null,
        uiMessage: hasCopySuccess == true
            ? Nullable('Copied to clipboard')
            : null,
      ),
    );
  }

  void _onUiMessageCleared(
    EventDetailUiMessageCleared event,
    Emitter<EventDetailState> emit,
  ) {
    emit(state.copyWith(uiMessage: const Nullable(null)));
  }

  Future<void> _fetchSuggestedEvents(Emitter<EventDetailState> emit) async {
    if (state.event?.organizerId == null) {
      emit(
        state.copyWith(
          suggestedEvents: const AsyncValue.error('No organizer available'),
        ),
      );
      return;
    }

    emit(state.copyWith(suggestedEvents: AsyncValue.loading()));
    final Result<List<Event>> suggestedEventsResult = await _eventRepository
        .getEventsByOrganizerId(organizerId: state.event!.organizerId!);

    switch (suggestedEventsResult) {
      case Ok<List<Event>>():
        emit(
          state.copyWith(
            suggestedEvents: AsyncValue.data(
              suggestedEventsResult.value
                  .where((event) => event.id != state.event?.id)
                  .toList(),
            ),
          ),
        );

      case Error<List<Event>>():
        emit(
          state.copyWith(
            suggestedEvents: const AsyncValue.error(
              'Failed to load suggested events',
            ),
          ),
        );
    }
  }
}
