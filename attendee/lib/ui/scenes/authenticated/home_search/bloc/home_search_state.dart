part of "home_search_bloc.dart";

enum HomeSearchMode { event, location }

class HomeSearchState extends Equatable {
  const HomeSearchState({
    required this.mode,
    required this.eventQuery,
    // Text in search box
    required this.locationQuery,

    // Selected location
    required this.selectedCountry,
    required this.selectedCity,

    // Current location based on GPS
    required this.currentLocationLabel,

    // Countries and cities selection list
    required this.selectableCountries,
    required this.selectableCities,

    // Status of country and city list
    required this.isCountryListLoading,
    required this.isCityListLoading,
  });

  factory HomeSearchState.initial() {
    return HomeSearchState(
      mode: HomeSearchMode.event,
      eventQuery: null,
      locationQuery: null,
      selectedCountry: null,
      selectedCity: null,
      selectableCities: null,
      selectableCountries: null,
      currentLocationLabel: "Current location",
      isCityListLoading: false,
      isCountryListLoading: false,
    );
  }

  final HomeSearchMode mode;
  final String? eventQuery;
  final String? locationQuery;

  final String? selectedCountry;
  final String? selectedCity;

  final bool isCountryListLoading;
  final bool isCityListLoading;

  final String? currentLocationLabel;

  bool get isUsingCurrentLocation => true;

  bool get doesAllowSearch =>
      (mode == HomeSearchMode.event && eventQuery != null) ||
      (mode == HomeSearchMode.location && locationQuery != null);

  // Countries and cities selection list

  final List<String>? selectableCountries;
  final List<String>? selectableCities;

  HomeSearchState copyWith({
    HomeSearchMode? mode,
    String? eventQuery,
    bool setEventQueryToNull = false,
    String? locationQuery,
    bool setLocationQueryToNull = false,

    Nullable<String>? selectedCountry,
    Nullable<String>? selectedCity,

    String? currentLocationLabel,

    List<String>? selectableCountries,
    List<String>? selectableCities,

    bool? isCountryListLoading,
    bool? isCityListLoading,
  }) {
    return HomeSearchState(
      mode: mode ?? this.mode,
      eventQuery: setEventQueryToNull ? null : (eventQuery ?? this.eventQuery),
      locationQuery: setLocationQueryToNull
          ? null
          : (locationQuery ?? this.locationQuery),

      selectedCountry: selectedCountry != null
          ? selectedCountry.value
          : this.selectedCountry,
      selectedCity: selectedCity != null
          ? selectedCity.value
          : this.selectedCity,
      currentLocationLabel: currentLocationLabel ?? this.currentLocationLabel,
      selectableCountries: selectableCountries ?? this.selectableCountries,
      selectableCities: selectableCities ?? this.selectableCities,
      isCityListLoading: isCityListLoading ?? this.isCityListLoading,
      isCountryListLoading: isCountryListLoading ?? this.isCountryListLoading,
    );
  }

  @override
  List<Object?> get props => [
    mode,
    eventQuery,
    locationQuery,

    selectedCountry,
    selectedCity,
    selectableCities,
    selectableCountries,
    currentLocationLabel,
    isCityListLoading,
    isCountryListLoading,
  ];
}
