import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/enums/date_filter_enums.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:attendee/utils/extensions/date_time_extension.dart";
import "package:flutter/material.dart";

class HomeFilterDateFilterList extends StatelessWidget {
  const HomeFilterDateFilterList({
    super.key,
    required this.dateType,
    required this.onDateFilterSelected,
  });

  final DateFilterEnums dateType;

  final void Function(DateTime? startDate, DateTime? endDate)
  onDateFilterSelected;

  @override
  Widget build(BuildContext context) {
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
            groupValue: dateType,
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

              onDateFilterSelected(startDate, endDate);
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
      onDateFilterSelected(dateRange.start, dateRange.end);
    }
  }
}
