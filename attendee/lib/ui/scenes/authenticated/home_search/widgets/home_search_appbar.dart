import 'package:attendee/ui/scenes/authenticated/home_search/widgets/focus_aware_text_field.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:attendee/ui/scenes/authenticated/home_search/bloc/home_search_bloc.dart';

class HomeSearchAppbar extends StatelessWidget {
  const HomeSearchAppbar({
    super.key,
    this.onCloseTapped,
    required this.onEventSearchChanged,
    required this.onLocationSearchChanged,
    this.initialSearchValue,
    this.initialLocationValue,
    this.isEnabled = true,
  });

  final VoidCallback? onCloseTapped;

  final ValueChanged<String?> onEventSearchChanged;
  final ValueChanged<String?> onLocationSearchChanged;

  final String? initialSearchValue;

  final String? initialLocationValue;

  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: Text('Search', style: context.textPalette.displayMedium),
            ),

            IconButton(
              onPressed: onCloseTapped,
              icon: Icon(Icons.close),
              iconSize: 32,
            ),
          ],
        ),
        SizedBox(height: 16),
        FocusAwareTextField(
          initialValue: initialSearchValue,
          prefixIcon: Icons.search,
          hintText: 'Search',
          onChanged: (value) => onEventSearchChanged(value),
          onFocusChanged: (hasFocus) {
            if (hasFocus) {
              // switch to event search mode when focused
              context.read<HomeSearchBloc>().add(
                HomeSearchFocusedFieldChanged(HomeSearchMode.event),
              );
            }
          },
        ),

        SizedBox(height: 8),
        FocusAwareTextField(
          initialValue: initialLocationValue,
          prefixIcon: Icons.location_on_outlined,
          hintText: 'Search for a city...',

          onChanged: (value) => onLocationSearchChanged(value),
          onFocusChanged: (hasFocus) {
            if (hasFocus) {
              // switch to location search mode when focused
              context.read<HomeSearchBloc>().add(
                HomeSearchFocusedFieldChanged(HomeSearchMode.location),
              );
            }
          },
        ),

        SizedBox(height: 16),
      ],
    );
  }
}
