import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "home_search_event.dart";
part "home_search_state.dart";

class HomeSearchBloc extends Bloc<HomeSearchEvent, HomeSearchState> {
  HomeSearchBloc() : super(HomeSearchState.initial()) {
    on<HomeSearchLoaded>(_onLoaded);
    on<HomeSearchModeChanged>(_onModeChanged);
    on<HomeSearchFocusedFieldChanged>(_onFocusedFieldChanged);
    on<HomeSearchEventQueryChanged>(_onEventQueryChanged);
    on<HomeSearchLocationQueryChanged>(_onLocationQueryChanged);
    on<HomeSearchClearRecentItem>(_onClearRecentItem);
  }

  void _onLoaded(HomeSearchLoaded event, Emitter<HomeSearchState> emit) {
    emit(
      state.copyWith(
        eventQuery: event.currentEventSearchQuery,
        locationQuery: event.currentLocation,
      ),
    );
  }

  void _onModeChanged(
    HomeSearchModeChanged event,
    Emitter<HomeSearchState> emit,
  ) {
    final bool switchingToEvent = event.mode == HomeSearchMode.event;
    final String? activeQuery = switchingToEvent
        ? state.eventQuery
        : state.locationQuery;
    final bool showHistory =
        (activeQuery == null || activeQuery.trim().isEmpty);
    emit(
      state.copyWith(
        mode: event.mode,
        isShowingHistory: showHistory,
        shownResults: showHistory
            ? (switchingToEvent ? state.eventHistory : state.locationHistory)
            : _filterDummyResults(activeQuery, event.mode),
      ),
    );
  }

  void _onFocusedFieldChanged(
    HomeSearchFocusedFieldChanged event,
    Emitter<HomeSearchState> emit,
  ) {
    // Treat focusing a field as changing the mode
    _onModeChanged(HomeSearchModeChanged(event.modeOfFocusedField), emit);
  }

  void _onEventQueryChanged(
    HomeSearchEventQueryChanged event,
    Emitter<HomeSearchState> emit,
  ) {
    final String? query = event.query;
    final bool isEmpty = query == null || query.trim().isEmpty;
    emit(
      state.copyWith(
        eventQuery: query,
        isShowingHistory: isEmpty,
        shownResults: isEmpty
            ? state.eventHistory
            : _filterDummyResults(query, HomeSearchMode.event),
      ),
    );
  }

  void _onLocationQueryChanged(
    HomeSearchLocationQueryChanged event,
    Emitter<HomeSearchState> emit,
  ) {
    final String? query = event.query;
    final bool isEmpty = query == null || query.trim().isEmpty;
    emit(
      state.copyWith(
        locationQuery: query,
        isShowingHistory: isEmpty,
        shownResults: isEmpty
            ? state.locationHistory
            : _filterDummyResults(query, HomeSearchMode.location),
        setSelectedLocationLabelToNull: !isEmpty,
      ),
    );
  }

  void _onClearRecentItem(
    HomeSearchClearRecentItem event,
    Emitter<HomeSearchState> emit,
  ) {
    if (state.mode == HomeSearchMode.event) {
      final updated = List<String>.from(state.eventHistory)
        ..remove(event.value);
      emit(state.copyWith(eventHistory: updated, shownResults: updated));
    } else {
      final updated = List<String>.from(state.locationHistory)
        ..remove(event.value);
      emit(state.copyWith(locationHistory: updated, shownResults: updated));
    }
  }

  List<String> _filterDummyResults(String? query, HomeSearchMode mode) {
    final List<String> base = mode == HomeSearchMode.event
        ? <String>[
            "Flutter Conf",
            "Tech Meetup",
            "Music Festival",
            "Food Carnival",
            "AI Summit",
          ]
        : <String>[
            "Las Vegas, NV",
            "San Jose, CA",
            "New York, NY",
            "Austin, TX",
            "Denver, CO",
          ];
    final q = (query ?? "").toLowerCase();
    return base
        .where((e) => e.toLowerCase().contains(q))
        .toList(growable: false);
  }
}
