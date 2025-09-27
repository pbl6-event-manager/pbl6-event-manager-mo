import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class HomeSearchAppbar extends StatelessWidget {
  const HomeSearchAppbar({
    super.key,
    this.onFilterTapped,
    required this.onChipTapped,
    required this.selectedChipId,
    required this.chipData,
    required this.currentLocation,
  });

  final VoidCallback? onFilterTapped;
  final ValueChanged<int> onChipTapped;
  final int? selectedChipId;
  final List<(int, String)> chipData;

  final String? currentLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: UIConstants.horizontalPadding,
          ),
          child: _buildSearchButton(context),
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
          Icon(Icons.search, size: 28),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (currentLocation != null)
                  Text(
                    AppStringConstants.home.searchAppBarLabel,
                    style: context.textPalette.subtitleLarge,
                  ),

                Text(
                  currentLocation != null
                      ? AppStringConstants.home.searchAppBarTitle(
                          currentLocation!,
                        )
                      : AppStringConstants.home.searchAppBarLabel,
                  style: context.textPalette.labelLarge,
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
