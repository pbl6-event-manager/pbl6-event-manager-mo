import "package:attendee/application/app_router.dart";
import "package:attendee/domain/models/event_category.dart";
import "package:attendee/domain/repositories/category_repository.dart";
import "package:attendee/ui/scenes/authenticated/home_filter/bloc/home_filter_bloc.dart";
import "package:attendee/ui/scenes/authenticated/home_filter/home_filter_navigator.dart";
import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/enums/date_filter_enums.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:attendee/utils/extensions/date_time_extension.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:get_it/get_it.dart";
import "package:skeletonizer/skeletonizer.dart";

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
                _buildAppBar(context),
                _buildDateFilter(context),
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
            child: Flexible(
              child: Text(
                "Reset",
                style: context.textPalette.labelLarge.copyWith(
                  decoration: TextDecoration.underline,
                  color: state.hasFilterChanged
                      ? context.colorPalette.text
                      : context.colorPalette.textPlaceholder,
                ),
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
                "Apply Filters",
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
                        "Reset",
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

  SliverMainAxisGroup _buildDateFilter(BuildContext context) {
    final state = context.read<HomeFilterBloc>().state;

    return SliverMainAxisGroup(
      slivers: [
        SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              AppStringConstants.homeFilter.dateFilter,
              style: context.textPalette.headlineLarge,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: RadioGroup<DateFilterEnums>(
            groupValue: state.dateType,
            onChanged: (DateFilterEnums? value) {
              if (value == null) return;

              DateTime? startDate;
              DateTime? endDate;

              switch (value) {
                case DateFilterEnums.any:
                  startDate = null;
                  endDate = null;
                  break;
                case DateFilterEnums.today:
                  startDate = DateTime.now();
                  endDate = null;
                  break;
                case DateFilterEnums.tomorrow:
                  startDate = DateTime.now().add(Duration(days: 1));
                  endDate = null;
                  break;
                case DateFilterEnums.custom:
                  _showDatePicker(context);
                  return;
                case DateFilterEnums.weekdays:
                  final weekDays = DateTime.now().weekdays;
                  startDate = weekDays.$1;
                  endDate = weekDays.$2;
                case DateFilterEnums.weekends:
                  final weekends = DateTime.now().weekends;
                  startDate = weekends.$1;
                  endDate = weekends.$2;
              }

              context.read<HomeFilterBloc>().add(
                HomeFilterDayTapped(startDate: startDate, endDate: endDate),
              );
            },
            child: Column(
              children: DateFilterEnums.values
                  .map((option) => _buildDateTile(context, option))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTile(BuildContext context, DateFilterEnums option) {
    return ListTile(
      visualDensity: VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      contentPadding: EdgeInsets.zero,
      title: Text(option.uiLabel, style: context.textPalette.bodyMedium),
      trailing: Radio<DateFilterEnums>(
        value: option,
        activeColor: context.colorPalette.primary,
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final dateRange = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );

    if (dateRange != null && context.mounted) {
      context.read<HomeFilterBloc>().add(
        HomeFilterDayTapped(startDate: dateRange.start, endDate: dateRange.end),
      );
    }
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

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.transparent,
      shadowColor: context.colorPalette.border.withValues(alpha: 0.1),
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      pinned: true,
      toolbarHeight: 60,

      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Filter",
                    style: context.textPalette.displayLarge,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                  iconSize: 32,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
