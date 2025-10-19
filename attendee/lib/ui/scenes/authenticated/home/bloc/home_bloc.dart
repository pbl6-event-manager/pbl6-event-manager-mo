import "dart:developer";

import "package:attendee/domain/models/event.dart";
import "package:attendee/network/datasources/event_datasource.dart";
import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/helpers/nullable.dart";
import "package:bloc/bloc.dart";
import "package:equatable/equatable.dart";
import "package:geolocator/geolocator.dart";

part "home_event.dart";
part "home_state.dart";

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final EventDatasource _eventDatasource;

  HomeBloc({required EventDatasource eventDatasource})
    : _eventDatasource = eventDatasource,
      super(HomeState.initial()) {
    on<HomeLoad>(_onHomeLoad);
    on<HomeReload>(_onHomeReload);
    on<HomeChipSelected>(_onHomeChipSelected);
    on<HomeReturnedFromSearch>(_onHomeReturnedFromSearch);
    on<HomeEventSearchCleared>(_onHomeEventSearchCleared);
    on<HomeReturnedFromFilter>(_onHomeReturnedFromFilter);
  }

  Future<void> _onHomeLoad(HomeLoad event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));

    try {
      final events = await _eventDatasource.getEvents();
      emit(
        state.copyWith(
          status: ViewStatusEnum.success,
          events: events,
          chipData: [
            (1, "All Events"),
            (2, "Conferences"),
            (3, "Workshops"),
            (4, "Networking"),
            (5, "Webinars"),
            (6, "Meetups"),
            (7, "Training"),
            (8, "Social"),
          ],

          selectedChipId: 1,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeReload(HomeReload event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: ViewStatusEnum.loading));

    try {
      final events = await _eventDatasource.getEvents();

      emit(
        state.copyWith(
          status: ViewStatusEnum.success,
          events: events,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeChipSelected(
    HomeChipSelected event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        selectedChipId: event.chipId,
      ),
    );

    try {
      // Fetch events for selected chip/category
      final events = await _eventDatasource.getEvents();

      emit(
        state.copyWith(
          status: ViewStatusEnum.success,
          events: events,
          errorMessage: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onHomeReturnedFromSearch(
    HomeReturnedFromSearch event,
    Emitter<HomeState> emit,
  ) async {
    if (event.searchData == null) {
      return;
    }

    // TODO: Remove demo
    await _getDeviceCurrentPosition();

    final String? eventSearchQuery =
        event.searchData?.$1 != state.currentSearchQuery
        ? event.searchData?.$1
        : null;
    final String? locationSearchQuery =
        event.searchData?.$2 != state.currentLocation
        ? event.searchData?.$2
        : null;

    if (eventSearchQuery == null && locationSearchQuery == null) {
      return;
    }
    emit(
      state.copyWith(
        status: ViewStatusEnum.loading,
        currentSearchQuery: Nullable(eventSearchQuery),
        currentLocation: locationSearchQuery,
      ),
    );

    try {
      // Fetch events with search parameters
      final events = await _eventDatasource.getEvents();
      emit(state.copyWith(status: ViewStatusEnum.success, events: events));
    } catch (error) {
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

    try {
      // Fetch all events when search is cleared
      final events = await _eventDatasource.getEvents();
      emit(state.copyWith(status: ViewStatusEnum.success, events: events));
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
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

    try {
      // Fetch events with filter parameters
      final events = await _eventDatasource.getEvents();
      emit(state.copyWith(status: ViewStatusEnum.success, events: events));
    } catch (error) {
      emit(
        state.copyWith(
          status: ViewStatusEnum.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _getDeviceCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final Position position = await Geolocator.getCurrentPosition();

    log(position.latitude.toString());
    log(position.longitude.toString());
  }
}
