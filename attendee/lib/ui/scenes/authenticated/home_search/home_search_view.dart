import "package:attendee/application/app_router.dart";
import "package:attendee/domain/repositories/location_repository.dart";

import "package:attendee/ui/scenes/authenticated/home_search/home_search_navigator.dart";
import "package:attendee/ui/scenes/authenticated/home_search/widgets/home_search_appbar.dart";
import "package:attendee/ui/scenes/authenticated/home_search/widgets/home_search_list_tile.dart";
import "package:attendee/ui/scenes/authenticated/home_search/bloc/home_search_bloc.dart";
import "package:attendee/ui/scenes/authenticated/home_search/widgets/location_dropdown.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

class HomeSearchPage extends StatelessWidget {
  const HomeSearchPage({
    super.key,
    this.currentLocationQuery,
    this.isUsingCurrentLocation,
  });

  final String? currentLocationQuery;
  final bool? isUsingCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeSearchBloc(
            locationRepository: GetIt.instance<LocationRepository>(),
          ),
        ),
        RepositoryProvider<HomeSearchNavigator>(
          create: (context) => HomeSearchNavigatorImplementation(
            goRouter: GetIt.instance<AppRouter>().router,
          ),
        ),
      ],
      child: HomeSearchView(
        initalLocation: currentLocationQuery,
        isInitallyUsingCurrentLocation: isUsingCurrentLocation ?? false,
      ),
    );
  }
}

class HomeSearchView extends StatelessWidget {
  const HomeSearchView({
    super.key,
    this.initalLocation,
    required this.isInitallyUsingCurrentLocation,
  });

  final String? initalLocation;
  final bool isInitallyUsingCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSearchBloc, HomeSearchState>(
      builder: (context, state) {
        final bool isLocationMode = state.mode == HomeSearchMode.location;
        final String? currentLocationLabel = state.currentLocationLabel;

        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: UIConstants.horizontalPadding,
              vertical: 8,
            ),
            child: FilledButton(
              onPressed: state.doesAllowSearch
                  ? () => _onSearchPressed(context)
                  : null,

              child: Text(AppStringConstants.homeSearch.searchButton),
            ),
          ),
          body: SafeArea(
            minimum: EdgeInsets.symmetric(
              horizontal: UIConstants.horizontalPadding,
            ),
            child: CustomScrollView(
              slivers: [
                _buildAppBar(context, state),

                if (isLocationMode)
                  SliverMainAxisGroup(
                    slivers: [
                      if (currentLocationLabel != null)
                        _buildCurrentLocation(
                          context,
                          currentLocationLabel,
                          isInitallyUsingCurrentLocation,
                        ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Divider(height: 20),
                        ),
                      ),
                      _buildLocationSelectWidgets(
                        context,
                        countries: state.selectableCountries ?? [],
                        cities: state.selectableCities ?? [],
                        selectedCountry: state.selectedCountry,
                        selectedCity: state.selectedCity,
                        isCityLoading: state.isCityListLoading,
                        isCountryLoading: state.isCountryListLoading,
                      ),
                    ],
                  ),

                SliverToBoxAdapter(child: SizedBox(height: 4)),
              ],
            ),
          ),
        );
      },
    );
  }

  SliverToBoxAdapter _buildCurrentLocation(
    BuildContext context,
    String currentLocationLabel,
    bool isUsingCurrentLocation,
  ) {
    return SliverToBoxAdapter(
      child: HomeSearchListTile(
        label: currentLocationLabel,
        onClearTapped: null,
        onTapped: isUsingCurrentLocation
            ? null
            : () => context.read<HomeSearchNavigator>().returnToHome(
                eventQuery: null,
                locationQuery: null,
                isUsingCurrentLocation: true,
              ),
        prefixIcon: isUsingCurrentLocation
            ? Icons.navigation
            : Icons.navigation_outlined,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, HomeSearchState state) {
    final String? initialLocationValue = state.locationQuery;
    final String? initialSearchValue = state.eventQuery;
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      shadowColor: context.colorPalette.border.withValues(alpha: 0.1),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      pinned: true,
      toolbarHeight: 200,
      title: HomeSearchAppbar(
        initialLocationValue: initialLocationValue,
        initialSearchValue: initialSearchValue,
        onEventSearchChanged: (value) => onEventSearchChanged(context, value),
        onCloseTapped: () => context.read<HomeSearchNavigator>().returnToHome(
          eventQuery: null,
          locationQuery: null,
          isUsingCurrentLocation: isInitallyUsingCurrentLocation,
        ),
        onLocationSearchChanged: (value) =>
            onLocationSearchChanged(context, value),
      ),
    );
  }

  void onEventSearchChanged(BuildContext context, String? value) {
    context.read<HomeSearchBloc>()
      ..add(const HomeSearchModeChanged(HomeSearchMode.event))
      ..add(HomeSearchEventQueryChanged(value));
  }

  void onLocationSearchChanged(BuildContext context, String? value) {
    context.read<HomeSearchBloc>()
      ..add(const HomeSearchModeChanged(HomeSearchMode.location))
      ..add(HomeSearchLocationQueryChanged(value));
  }

  void _onSearchPressed(BuildContext context) {
    final HomeSearchNavigator navigator = context.read<HomeSearchNavigator>();
    final HomeSearchState state = context.read<HomeSearchBloc>().state;

    switch (state.mode) {
      case HomeSearchMode.event:
        navigator.returnToHome(
          eventQuery: state.eventQuery,
          locationQuery: null,
          isUsingCurrentLocation: isInitallyUsingCurrentLocation,
        );

      case HomeSearchMode.location:
        navigator.returnToHome(
          eventQuery: null,
          locationQuery: state.locationQuery,
          isUsingCurrentLocation: isInitallyUsingCurrentLocation,
        );
    }
  }

  Widget _buildLocationSelectWidgets(
    BuildContext context, {
    required List<String> countries,
    required List<String> cities,
    required String? selectedCountry,
    required String? selectedCity,
    required bool isCountryLoading,
    required bool isCityLoading,
  }) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: [
              Expanded(
                child: LocationDropdown(
                  isLoading: isCountryLoading,
                  hintText:
                      AppStringConstants.homeSearch.countryDropdownPlaceholder,
                  onOptionSelected: (optionalCountry) =>
                      _onCountrySelected(context, country: optionalCountry),
                  values: countries,
                  value: selectedCountry,
                ),
              ),

              SizedBox(width: 16),
              Expanded(
                child: LocationDropdown(
                  isLoading: isCityLoading,
                  hintText:
                      AppStringConstants.homeSearch.cityDropdownPlaceholder,
                  onOptionSelected: (city) => _onCitySelected(context, city),
                  values: cities,
                  value: selectedCity,
                ),
              ),
            ],
          ),
        ),

        // Save button
      ],
    );
  }

  void _onCountrySelected(BuildContext context, {required String? country}) {
    if (country == null) {
      return;
    }
    context.read<HomeSearchBloc>().add(HomeCountrySelected(country: country));
  }

  void _onCitySelected(BuildContext context, String? city) {
    if (city == null) {
      return;
    }
    context.read<HomeSearchBloc>().add(HomeCitySelected(city: city));
  }
}
