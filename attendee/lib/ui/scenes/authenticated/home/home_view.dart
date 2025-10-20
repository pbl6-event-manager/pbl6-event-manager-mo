import "package:attendee/application/app_router.dart";
import "package:attendee/domain/repositories/event_repository.dart";
import "package:attendee/domain/usecases/search_by_current_location_usecase.dart";
import "package:attendee/ui/scenes/authenticated/home/bloc/home_bloc.dart";
import "package:attendee/ui/scenes/authenticated/home/home_navigator.dart";
import "package:attendee/ui/scenes/authenticated/home/widgets/home_event_section.dart";
import "package:attendee/ui/scenes/authenticated/home/widgets/home_appbar.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:skeletonizer/skeletonizer.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            eventRepository: GetIt.instance<EventRepository>(),
            searchByCurrentLocationUsecase:
                GetIt.instance<SearchByCurrentLocationUsecase>(),
          )..add(HomeLoad()),
        ),
        RepositoryProvider<HomeNavigator>(
          create: (context) => HomeNavigatorImplementation(
            goRouter: GetIt.instance<AppRouter>().router,
          ),
        ),
      ],
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final isLoading = state.status == ViewStatusEnum.loading;
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(const HomeReload());
              },
              child: CustomScrollView(
                slivers: [
                  _buildAppBar(context, state),
                  _buildBody(isLoading, context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(bool isLoading, BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SliverSkeletonizer(
          enabled: isLoading,
          child: SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: UIConstants.horizontalPadding,
            ),
            sliver: SliverMainAxisGroup(
              slivers: [
                ..._buildListSectionWithTitle(
                  context,
                  title: "Popular in Los Angeles",
                  contentWidget: HomeEventSection.compact(
                    isLoading: isLoading,
                    events: state.events,
                  ),
                ),
                const SliverToBoxAdapter(child: Divider(height: 26 * 2)),
                HomeEventSection(isLoading: isLoading, events: state.events),
                const SliverToBoxAdapter(child: Divider(height: 26 * 2)),
                HomeEventSection(isLoading: isLoading, events: state.events),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, HomeState state) {
    return SliverAppBar(
      titleSpacing: 0,
      title: HomeAppbar(
        onEventSearchCleared: () => _onEventSearchCleared(context),
        onSearchTapped: () => _onSearchTapped(
          context,
          currentLocationLabel: state.currentLocation,
          isUsingCurrentLocation: state.isUsingCurrentLocation,
          onSearchSubmitted: (data) => context.read<HomeBloc>().add(
            HomeReturnedFromSearch(searchData: data),
          ),
        ),
        currentEventSearchQuery: state.currentSearchQuery,
        currentLocation: state.currentLocation,
        onFilterTapped: () => _onFilterTapped(context),
      ),

      toolbarHeight: 148,
      pinned: true,
      elevation: 0,
      shadowColor: context.colorPalette.primary,
      surfaceTintColor: Colors.transparent,
    );
  }

  List<Widget> _buildListSectionWithTitle(
    BuildContext context, {
    required String title,
    required Widget contentWidget,
  }) => [
    SliverToBoxAdapter(
      child: Text(title, style: context.textPalette.headlineLarge),
    ),
    SliverToBoxAdapter(child: SizedBox(height: 26)),

    contentWidget,
  ];

  void _onSearchTapped(
    BuildContext context, {

    required String currentLocationLabel,
    required bool isUsingCurrentLocation,

    required Function((String?, String?, bool)) onSearchSubmitted,
  }) {
    context.read<HomeNavigator>().goToSearch(
      currentLocationLabel: currentLocationLabel,
      isUsingCurrentLocation: isUsingCurrentLocation,
      onSearchSubmitted: onSearchSubmitted,
    );
  }

  void _onFilterTapped(BuildContext context) {
    final state = context.read<HomeBloc>().state;
    context.read<HomeNavigator>().goToFilter(
      startDateFilter: state.filterStartDate,
      endDateFilter: state.filterEndDate,
      selectedCategories: state.selectedCategories,
      onFilterApplied: (filterData) {
        context.read<HomeBloc>().add(
          HomeReturnedFromFilter(filterData: filterData),
        );
      },
    );
  }

  void _onEventSearchCleared(BuildContext context) {
    context.read<HomeBloc>().add(HomeEventSearchCleared());
  }
}
