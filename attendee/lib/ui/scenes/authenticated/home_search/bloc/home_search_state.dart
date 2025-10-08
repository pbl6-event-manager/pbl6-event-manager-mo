part of "home_search_bloc.dart";

enum HomeSearchMode { event, location }

class HomeSearchState extends Equatable {
  const HomeSearchState({
    required this.mode,
    required this.eventQuery,
    required this.locationQuery,
    required this.shownResults,
    required this.isShowingHistory,
    required this.eventHistory,
    required this.locationHistory,
    required this.selectedLocationLabel,
    required this.currentLocationLabel,
  });

  factory HomeSearchState.initial() {
    return HomeSearchState(
      mode: HomeSearchMode.event,
      eventQuery: null,
      locationQuery: null,
      shownResults: const <String>[],
      isShowingHistory: true,
      eventHistory: const <String>["Flutter", "Music", "Tech"],
      locationHistory: const <String>[
        "Las Vegas, NV",
        "San Jose, CA",
        "New York, NY",
      ],
      selectedLocationLabel: null,
      currentLocationLabel: "Current location",
    );
  }

  final HomeSearchMode mode;
  final String? eventQuery;
  final String? locationQuery;
  final List<String> shownResults;
  final bool isShowingHistory;

  final List<String> eventHistory;
  final List<String> locationHistory;

  final String? selectedLocationLabel;
  final String? currentLocationLabel;

  bool get isUsingCurrentLocation => true;

  HomeSearchState copyWith({
    HomeSearchMode? mode,
    String? eventQuery,
    bool setEventQueryToNull = false,
    String? locationQuery,
    bool setLocationQueryToNull = false,
    List<String>? shownResults,
    bool? isShowingHistory,
    List<String>? eventHistory,
    List<String>? locationHistory,
    String? selectedLocationLabel,
    bool setSelectedLocationLabelToNull = false,
    String? currentLocationLabel,
  }) {
    return HomeSearchState(
      mode: mode ?? this.mode,
      eventQuery: setEventQueryToNull ? null : (eventQuery ?? this.eventQuery),
      locationQuery: setLocationQueryToNull
          ? null
          : (locationQuery ?? this.locationQuery),
      shownResults: shownResults ?? this.shownResults,
      isShowingHistory: isShowingHistory ?? this.isShowingHistory,
      eventHistory: eventHistory ?? this.eventHistory,
      locationHistory: locationHistory ?? this.locationHistory,
      selectedLocationLabel: setSelectedLocationLabelToNull
          ? null
          : (selectedLocationLabel ?? this.selectedLocationLabel),
      currentLocationLabel: currentLocationLabel ?? this.currentLocationLabel,
    );
  }

  @override
  List<Object?> get props => [
    mode,
    eventQuery,
    locationQuery,
    shownResults,
    isShowingHistory,
    eventHistory,
    locationHistory,
    selectedLocationLabel,
    currentLocationLabel,
  ];
}
