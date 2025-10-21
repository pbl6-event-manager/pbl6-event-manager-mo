import "package:attendee/domain/models/event.dart";
import "package:attendee/domain/repositories/event_repository.dart";
import "package:attendee/domain/usecases/search_by_current_location_usecase.dart";
import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/helpers/nullable.dart";
import "package:attendee/utils/helpers/result.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EventRepository _eventRepository;
  final SearchByCurrentLocationUsecase _searchByCurrentLocationUsecase;

  HomeBloc({
    required EventRepository eventRepository,
    required SearchByCurrentLocationUsecase searchByCurrentLocationUsecase,
  }) : _eventRepository = eventRepository,
       _searchByCurrentLocationUsecase = searchByCurrentLocationUsecase,
       super(HomeState.initial()) {
    on<HomeLoad>(_onHomeLoad);
    on<HomeReload>(_onHomeReload);

    on<HomeReturnedFromSearch>(_onHomeReturnedFromSearch);
    on<HomeEventSearchCleared>(_onHomeEventSearchCleared);
    on<HomeReturnedFromFilter>(_onHomeReturnedFromFilter);
  }

  Future<void> _onHomeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));
    await _fetchAllEvents(emit);
  }

  Future<void> _onHomeReload(HomeReload event, Emitter<HomeState> emit) async {
    {
      emit(state.copyWith(status: ViewStatusEnum.loading));
      await _fetchAllEvents(emit);
    }
  }

  Future<void> _onHomeReturnedFromSearch(
    HomeReturnedFromSearch event,
    Emitter<HomeState> emit,
  ) async {
    if (event.searchData == null) {
      return;
    }

    final String? eventSearchQuery =
        event.searchData?.$1 != state.currentSearchQuery
        ? event.searchData?.$1
        : null;
    final String? locationSearchQuery =
        event.searchData?.$2 != state.currentLocation
        ? event.searchData?.$2
        : null;

    final bool? isUsingCurrentLocation =
        event.searchData?.$3 != state.isUsingCurrentLocation
        ? event.searchData?.$3
        : null;

    if (eventSearchQuery == null &&
        locationSearchQuery == null &&
        isUsingCurrentLocation == null) {
      return;
    }
    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        currentSearchQuery: Nullable(eventSearchQuery),
        currentLocation: locationSearchQuery,
        isUsingCurrentLocation: locationSearchQuery != null
            ? false
            : isUsingCurrentLocation,
      ),
    );

    final eventsResponse = (isUsingCurrentLocation ?? false)
        ? await _searchByCurrentLocationUsecase.execute()
        : await _eventRepository.searchEvents(
            keyword: eventSearchQuery,
            location: locationSearchQuery,
          );

    switch (eventsResponse) {
      case Ok<List<Event>>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.success,
            events: eventsResponse.value,
          ),
        );
      case Error<List<Event>>(error: final error):
        emit(
          state.copyWith(
            status: ViewStatusEnum.failure,
            errorMessage: error.toString(),
          ),
        );
    }
  }

  Future<void> _onHomeEventSearchCleared(
    HomeEventSearchCleared event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        currentSearchQuery: Nullable(null),
        currentLocation: null,
      ),
    );

    await _fetchAllEvents(emit);
  }

  Future<void> _onHomeReturnedFromFilter(
    HomeReturnedFromFilter event,
    Emitter<HomeState> emit,
  ) async {
    if (event.filterData == null) {
      return;
    }

    final (DateTime? startDate, DateTime? endDate, Set<int> categories) =
        event.filterData!;

    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        filterStartDate: Nullable(startDate),
        filterEndDate: Nullable(endDate),
        selectedCategories: categories,
      ),
    );

    final eventsResponse = await _eventRepository.searchEvents(
      startDate: startDate,
      endDate: endDate,
      categoryIds: categories,
    );

    switch (eventsResponse) {
      case Ok<List<Event>>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.success,
            events: eventsResponse.value,
          ),
        );
      case Error<List<Event>>(error: final error):
        emit(
          state.copyWith(
            status: ViewStatusEnum.failure,
            errorMessage: error.toString(),
          ),
        );
    }
  }

  Future<void> _fetchAllEvents(Emitter<HomeState> emit) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));

    final eventsResponse = await _eventRepository.getEvents();
    switch (eventsResponse) {
      case Ok<List<Event>>():
        emit(
          state.copyWith(
            status: ViewStatusEnum.success,
            events: eventsResponse.value,
          ),
        );
      case Error<List<Event>>(error: Exception error):
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        );
    }
    try {} catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
