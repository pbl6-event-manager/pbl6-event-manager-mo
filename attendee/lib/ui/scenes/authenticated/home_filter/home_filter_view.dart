import 'package:attendee/application/app_router.dart';
import 'package:attendee/domain/models/event_category.dart';
import 'package:attendee/domain/repositories/category_repository.dart';
import 'package:attendee/ui/scenes/authenticated/home_filter/bloc/home_filter_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/home_filter/home_filter_navigator.dart';
import 'package:attendee/ui/scenes/authenticated/home_filter/widgets/home_filter_appbar.dart';
import 'package:attendee/ui/scenes/authenticated/home_filter/widgets/home_filter_date_filter_list.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeFilterPage extends StatelessWidget {
  const HomeFilterPage({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    this.initialSelectedCategories,
  });

  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Set<int>? initialSelectedCategories;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeFilterBloc(
                categoryRepository: GetIt.instance<CategoryRepository>(),
              )..add(
                HomeFilterLoaded(
                  selectedCategoryId: initialSelectedCategories ?? {},
                  startDate: initialStartDate,
                  endDate: initialEndDate,
                ),
              ),
        ),
        RepositoryProvider<HomeFilterNavigator>(
          create: (context) => HomeFilterNavigatorImplementation(
            goRouter: GetIt.instance<AppRouter>().router,
          ),
        ),
      ],
      child: const HomeFilterView(),
    );
  }
}

class HomeFilterView extends StatelessWidget {
  const HomeFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeFilterBloc, HomeFilterState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: _buildBottomBar(context),
          body: SafeArea(
            minimum: EdgeInsets.symmetric(
              horizontal: UIConstants.horizontalPadding,
            ),
            child: CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                HomeFilterAppBar(),
                HomeFilterDateFilterList(
                  dateType: state.dateType,
                  onDateFilterSelected: (startDate, endDate) =>
                      context.read<HomeFilterBloc>().add(
                        HomeFilterDayTapped(
                          startDate: startDate,
                          endDate: endDate,
                        ),
                      ),
                ),

                SliverToBoxAdapter(child: Divider()),
                _buildCategoryFilter(context, state.allCategories),
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildBottomBar(BuildContext context) {
    final state = context.read<HomeFilterBloc>().state;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: state.hasFilterChanged
                ? () {
                    context.read<HomeFilterBloc>().add(HomeFilterResetTapped());
                  }
                : null,
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(
                context.colorPalette.primary.withValues(alpha: 0.4),
              ),
            ),
            child: Text(
              AppStringConstants.homeFilter.resetButton,
              style: context.textPalette.labelLarge.copyWith(
                decoration: TextDecoration.underline,
                color: state.hasFilterChanged
                    ? context.colorPalette.text
                    : context.colorPalette.textPlaceholder,
              ),
            ),
          ),
          Spacer(),

          Flexible(
            child: FilledButton(
              onPressed: () {
                context.read<HomeFilterNavigator>().returnToHome(
                  filterData: (
                    state.selectedStartDate,
                    state.selectedEndDate,
                    state.selectedCategories,
                  ),
                );
              },
              child: Text(
                AppStringConstants.homeFilter.applyFiltersButton,
                style: context.textPalette.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(
    BuildContext context,
    List<EventCategory>? categories,
  ) {
    final state = context.read<HomeFilterBloc>().state;
    final List<EventCategory> uiCategories = categories ?? EventCategory.dummy;
    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    AppStringConstants.homeFilter.categoryFilter,
                    style: context.textPalette.headlineLarge,
                  ),
                ),

                if (!state.isSelectedCategoryEmpty)
                  Flexible(
                    child: GestureDetector(
                      onTap: () {
                        context.read<HomeFilterBloc>().add(
                          HomeFilterResetCategoryTapped(),
                        );
                      },
                      child: Text(
                        AppStringConstants.homeFilter.resetButton,
                        style: context.textPalette.labelMedium.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) => Skeletonizer(
            enabled: categories == null,
            child: _buildCategoryTile(context, uiCategories[index]),
          ),
          itemCount: uiCategories.length,
        ),
      ],
    );
  }

  Widget _buildCategoryTile(BuildContext context, EventCategory category) {
    final state = context.read<HomeFilterBloc>().state;
    final isSelected = state.selectedCategories.contains(category.id);

    return Skeleton.leaf(
      child: CheckboxListTile(
        activeColor: context.colorPalette.primary,
        visualDensity: VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
        contentPadding: EdgeInsets.zero,
        value: isSelected,
        onChanged: (bool? value) {
          context.read<HomeFilterBloc>().add(
            HomeFilterCategoryTapped(chosenCategoryId: category.id),
          );
        },
        title: Text(category.name, style: context.textPalette.bodyMedium),
      ),
    );
  }
}
