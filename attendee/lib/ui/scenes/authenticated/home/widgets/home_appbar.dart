import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    super.key,
    this.onFilterTapped,
    required this.onChipTapped,
    required this.onSearchTapped,
    required this.onEventSearchCleared,
    required this.selectedChipId,
    required this.chipData,
    required this.currentLocation,
    required this.currentEventSearchQuery,
  });

  final VoidCallback? onFilterTapped;
  final VoidCallback? onSearchTapped;

  /// Only clear event search, location search remains the same
  final VoidCallback? onEventSearchCleared;
  final ValueChanged<int> onChipTapped;
  final int? selectedChipId;
  final List<(int, String)> chipData;

  final String currentLocation;
  final String? currentEventSearchQuery;

  bool get hasSearchQuery => currentEventSearchQuery != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.horizontalPadding,
          ),
          child: InkWell(
            onTap: onSearchTapped,
            child: _buildSearchButton(context),
          ),
        ),
        SizedBox(height: 20),
        _buildScrollableChips(context),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),

        color: context.colorPalette.surfaceContainer,
      ),
      child: Row(
        children: [
          // If contains search query => back button
          // Else => show search button
          IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            onPressed: hasSearchQuery ? onEventSearchCleared : onSearchTapped,
            icon: Icon(
              hasSearchQuery ? Icons.arrow_back : Icons.search,
              size: 28,
            ),
          ),

          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentEventSearchQuery ??
                      AppStringConstants.home.searchAppBarLabel,
                  style: hasSearchQuery
                      ? context.textPalette.labelLarge
                      : context.textPalette.subtitleLarge,
                ),

                Text(
                  AppStringConstants.home.searchAppBarTitle(currentLocation),

                  style: hasSearchQuery
                      ? context.textPalette.subtitleLarge
                      : context.textPalette.labelLarge,
                ),
              ],
            ),
          ),

          // Filter
          InkWell(
            onTap: onFilterTapped,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: BoxBorder.all(color: context.colorPalette.border),
              ),

              child: Icon(Icons.tune),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableChips(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: UIConstants.horizontalPadding,
        ),
        itemCount: chipData.length,
        separatorBuilder: (context, index) => SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = chipData[index].$1 == selectedChipId;
          return FilterChip(
            side: BorderSide(color: Colors.transparent),
            label: Text(chipData[index].$2),
            selected: isSelected,
            onSelected: (bool selected) {
              onChipTapped(chipData[index].$1);
            },

            color: WidgetStatePropertyAll(
              isSelected
                  ? context.colorPalette.primary
                  : context.colorPalette.surfaceContainer,
            ),

            selectedColor: context.colorPalette.primary,
            showCheckmark: false,
            labelStyle: context.textPalette.labelMedium.copyWith(
              color: isSelected
                  ? context.colorPalette.onPrimary
                  : context.colorPalette.text,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          );
        },
      ),
    );
  }
}
