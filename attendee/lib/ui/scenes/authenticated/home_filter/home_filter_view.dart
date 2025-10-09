import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/enums/date_filter_enums.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class HomeFilterPage extends StatelessWidget {
  const HomeFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeFilterView();
  }
}

class HomeFilterView extends StatelessWidget {
  const HomeFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> dummyCategories = [
      "One, two, three",
      "One",
      "two",
      "three",
      "four",
      "five",
      "five",
      "five",
      "five",
      "five",
    ];
    return Scaffold(
      bottomNavigationBar: _buildBottomBar(context),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
        ),
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            _buildDateFilter(context),
            SliverToBoxAdapter(child: Divider()),
            _buildCategoryFilter(context, dummyCategories),
          ],
        ),
      ),
    );
  }

  Container _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(
                context.colorPalette.primary.withValues(alpha: 0.4),
              ),
            ),
            child: Flexible(
              child: Text(
                "Reset",
                style: context.textPalette.bodyLarge.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Spacer(),

          Flexible(
            child: FilledButton(
              onPressed: () {},
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

  SliverMainAxisGroup _buildCategoryFilter(
    BuildContext context,
    List<String> dummyCategories,
  ) {
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

                Flexible(
                  child: Text(
                    "Reset",
                    style: context.textPalette.bodyLarge.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList.builder(
          itemBuilder: (context, index) =>
              _buildCategoryTile(context, dummyCategories[index]),
          itemCount: dummyCategories.length,
        ),
      ],
    );
  }

  SliverMainAxisGroup _buildDateFilter(BuildContext context) {
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
        SliverList.list(
          children: DateFilterEnums.values
              .map((option) => _buildDateTile(context, option))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildDateTile(BuildContext context, DateFilterEnums option) {
    return RadioListTile(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

      controlAffinity: ListTileControlAffinity.trailing,
      activeColor: context.colorPalette.primary,

      visualDensity: VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      contentPadding: EdgeInsets.zero,
      title: Text(option.uiLabel, style: context.textPalette.bodyMedium),

      value: option,
    );
  }

  Widget _buildCategoryTile(BuildContext context, String option) {
    return CheckboxListTile(
      activeColor: context.colorPalette.primary,
      visualDensity: VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      contentPadding: EdgeInsets.zero,
      value: false,
      onChanged: (bool? value) {},
      title: Text(option, style: context.textPalette.bodyMedium),
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
                  onPressed: () {},
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
