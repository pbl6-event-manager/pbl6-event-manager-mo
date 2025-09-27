import "package:attendee/ui/scenes/authenticated/home/bloc/home_bloc.dart";
import "package:attendee/ui/scenes/authenticated/home/widgets/home_event_section.dart";
import "package:attendee/ui/scenes/authenticated/home/widgets/home_search_appbar.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/enums/view_status_enum.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:skeletonizer/skeletonizer.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeLoad()),
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
                  SliverAppBar(
                    titleSpacing: 0,
                    title: HomeSearchAppbar(
                      currentLocation: state.currentLocation,
                      onFilterTapped: () {},
                      chipData: state.chipData,
                      onChipTapped: (id) =>
                          context.read<HomeBloc>().add(HomeChipSelected(id)),
                      selectedChipId: state.selectedChipId,
                    ),

                    toolbarHeight: 148,
                    pinned: true,
                    elevation: 0,
                    shadowColor: context.colorPalette.primary,
                    surfaceTintColor: Colors.transparent,
                  ),

                  SliverSkeletonizer(
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
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: Divider(height: 26 * 2),
                          ),
                          HomeEventSection(isLoading: isLoading),
                          const SliverToBoxAdapter(
                            child: Divider(height: 26 * 2),
                          ),
                          HomeEventSection(isLoading: isLoading),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
}
