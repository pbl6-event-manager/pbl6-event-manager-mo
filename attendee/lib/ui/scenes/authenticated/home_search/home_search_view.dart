import "package:attendee/application/app_router.dart";
import "package:attendee/domain/repositories/location_repository.dart";
import "package:attendee/ui/scenes/authenticated/home_search/home_search_navigator.dart";
import "package:attendee/ui/scenes/authenticated/home_search/widgets/home_search_appbar.dart";
import "package:attendee/ui/scenes/authenticated/home_search/widgets/home_search_list_tile.dart";
import "package:attendee/ui/scenes/authenticated/home_search/bloc/home_search_bloc.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";

class HomeSearchPage extends StatelessWidget {
  const HomeSearchPage({
    super.key,
    this.currentLocationQuery,
    this.currentEventQuery,
  });

  final String? currentLocationQuery;
  final String? currentEventQuery;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              HomeSearchBloc(
                locationRepository: GetIt.instance<LocationRepository>(),
              )..add(
                HomeSearchLoaded(
                  currentLocation: currentLocationQuery,
                  currentEventSearchQuery: currentEventQuery,
                ),
              ),
        ),
        RepositoryProvider<HomeSearchNavigator>(
          create: (context) => HomeSearchNavigatorImplementation(
            goRouter: GetIt.instance<AppRouter>().router,
          ),
        ),
      ],
      child: const HomeSearchView(),
    );
  }
}

class HomeSearchView extends StatelessWidget {
  const HomeSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeSearchBloc, HomeSearchState>(
      builder: (context, state) {
        final bool isLocationMode = state.mode == HomeSearchMode.location;
        final String? selectedLocationString = state.selectedLocationLabel;
        final String? currentLocationLabel = state.currentLocationLabel;

        return Scaffold(
          body: SafeArea(
            minimum: EdgeInsets.symmetric(
              horizontal: UIConstants.horizontalPadding,
            ),
            child: CustomScrollView(
              slivers: [
                _buildAppBar(context, state),

                if (isLocationMode && selectedLocationString != null)
                  _buildSelectedLocation(selectedLocationString),

                if (isLocationMode && currentLocationLabel != null)
                  _buildCurrentLocation(
                    currentLocationLabel,
                    state.isUsingCurrentLocation,
                  ),

                SliverToBoxAdapter(child: SizedBox(height: 4)),
                if (state.isShowingHistory)
                  SliverToBoxAdapter(
                    child: Text(
                      "Recent",
                      style: context.textPalette.labelLarge.copyWith(
                        color: context.colorPalette.textPlaceholder,
                      ),
                    ),
                  ),

                _buildSearchResults(context, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(BuildContext context, HomeSearchState state) {
    final List<String> items = state.isShowingHistory
        ? (state.mode == HomeSearchMode.event
              ? state.eventHistory
              : state.locationHistory)
        : state.shownResults;

    return SliverList.builder(
      itemBuilder: (context, index) {
        final String label = items[index];
        if (state.isShowingHistory) {
          return HomeSearchListTile.recent(
            label: label,
            onTapped: () => onSearchItemPressed(
              context,
              type: state.mode,
              searchValue: label,
            ),
            onClearTapped: () {
              context.read<HomeSearchBloc>().add(
                HomeSearchClearRecentItem(value: label),
              );
            },
          );
        }

        if (state.mode == HomeSearchMode.location) {
          return HomeSearchListTile.location(
            label: label,
            onTapped: () => onSearchItemPressed(
              context,
              type: HomeSearchMode.location,
              searchValue: items[index],
            ),
          );
        }
        return HomeSearchListTile.search(
          label: label,
          onTapped: () => onSearchItemPressed(
            context,
            type: HomeSearchMode.event,
            searchValue: items[index],
          ),
        );
      },
      itemCount: items.length,
    );
  }

  SliverToBoxAdapter _buildCurrentLocation(
    String currentLocationLabel,
    bool isUsingCurrentLocation,
  ) {
    return SliverToBoxAdapter(
      child: HomeSearchListTile(
        label: currentLocationLabel,
        onClearTapped: null,
        onTapped: () {},
        prefixIcon: isUsingCurrentLocation
            ? Icons.navigation
            : Icons.navigation_outlined,
      ),
    );
  }

  SliverToBoxAdapter _buildSelectedLocation(String selectedLocationString) {
    return SliverToBoxAdapter(
      child: HomeSearchListTile(
        label: selectedLocationString,
        onClearTapped: null,
        onTapped: () {},
        prefixIcon: Icons.my_location_sharp,
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
        isUsingCurrentLocation: state.isUsingCurrentLocation,
        initialLocationValue: initialLocationValue,
        initialSearchValue: initialSearchValue,
        onEventSearchChanged: (value) => onEventSearchChanged(context, value),
        onCloseTapped: () => context.read<HomeSearchNavigator>().returnToHome(
          eventQuery: null,
          locationQuery: null,
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

  void onSearchItemPressed(
    BuildContext context, {
    required HomeSearchMode type,
    required String searchValue,
  }) {
    final HomeSearchNavigator navigator = context.read<HomeSearchNavigator>();

    switch (type) {
      case HomeSearchMode.event:
        navigator.returnToHome(eventQuery: searchValue, locationQuery: null);

      case HomeSearchMode.location:
        navigator.returnToHome(eventQuery: null, locationQuery: searchValue);
    }
  }
}
