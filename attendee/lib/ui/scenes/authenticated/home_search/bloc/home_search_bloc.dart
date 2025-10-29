import 'package:attendee/domain/repositories/location_repository.dart';
import 'package:attendee/utils/helpers/nullable.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_search_event.dart';
part 'home_search_state.dart';

class HomeSearchBloc extends Bloc<HomeSearchEvent, HomeSearchState> {
  final LocationRepository _locationRepository;
  HomeSearchBloc({required LocationRepository locationRepository})
    : _locationRepository = locationRepository,
      super(HomeSearchState.initial()) {
    on<HomeSearchModeChanged>(_onModeChanged);
    on<HomeSearchFocusedFieldChanged>(_onFocusedFieldChanged);
    on<HomeSearchEventQueryChanged>(_onEventQueryChanged);
    on<HomeSearchLocationQueryChanged>(_onLocationQueryChanged);
    on<HomeCountrySelected>(_onCountrySelected);
    on<HomeCitySelected>(_onCitySelected);
  }

  Future<void> _onModeChanged(
    HomeSearchModeChanged event,
    Emitter<HomeSearchState> emit,
  ) async {
    final bool switchingToEvent = event.mode == HomeSearchMode.event;

    emit(state.copyWith(mode: event.mode));

    if (!switchingToEvent && state.selectableCountries == null) {
      emit(state.copyWith(isCountryListLoading: true));
      final List<String> countries = await _fetchCountries();
      if (!emit.isDone) {
        emit(
          state.copyWith(
            selectableCountries: countries,
            isCountryListLoading: false,
          ),
        );
      }
    }
  }

  Future<void> _onFocusedFieldChanged(
    HomeSearchFocusedFieldChanged event,
    Emitter<HomeSearchState> emit,
  ) async {
    // Treat focusing a field as changing the mode
    await _onModeChanged(HomeSearchModeChanged(event.modeOfFocusedField), emit);
  }

  void _onEventQueryChanged(
    HomeSearchEventQueryChanged event,
    Emitter<HomeSearchState> emit,
  ) {
    final String? query = event.query;
    emit(state.copyWith(eventQuery: query));
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
        selectedCountry: isEmpty ? null : Nullable(null),
      ),
    );
  }

  Future<void> _onCountrySelected(
    HomeCountrySelected event,
    Emitter<HomeSearchState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCountry: Nullable(event.country),
        selectedCity: Nullable(null),
        selectableCities: [],

        locationQuery: event.country,
        isCityListLoading: true,
      ),
    );
    final List<String> cities = await _fetchCities(country: event.country);
    if (!emit.isDone) {
      emit(state.copyWith(selectableCities: cities, isCityListLoading: false));
    }
  }

  Future<List<String>> _fetchCities({required String country}) async {
    final Result<List<String>> citiesResult = await _locationRepository
        .getCities(country: country);
    switch (citiesResult) {
      case Ok<List<String>>():
        return citiesResult.value;
      case Error<List<String>>():
        return const <String>[];
    }
  }

  Future<List<String>> _fetchCountries() async {
    final Result<List<String>> countriesResult = await _locationRepository
        .getCountries();
    switch (countriesResult) {
      case Ok<List<String>>():
        return countriesResult.value;
      case Error<List<String>>():
        return const <String>[];
    }
  }

  void _onCitySelected(HomeCitySelected event, Emitter<HomeSearchState> emit) {
    emit(
      state.copyWith(
        selectedCity: Nullable(event.city),
        locationQuery: '${event.city}, ${state.selectedCountry}',
      ),
    );
  }
}
