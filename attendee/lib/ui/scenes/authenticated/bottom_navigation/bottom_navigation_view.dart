import "package:attendee/ui/scenes/authenticated/bottom_navigation/bottom_navigation_tab_enum.dart";
import "package:attendee/ui/themes/color_palette.dart";
import "package:attendee/ui/themes/text_palette.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationView(navigationShell: navigationShell);
  }
}

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _buildBottomNavigationBar(
        context,
        onDestinationPressed: (index) {
          widget.navigationShell.goBranch(index);
        },
        selectedIndex: widget.navigationShell.currentIndex,
      ),
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context, {
    required void Function(int selectedIndex) onDestinationPressed,
    required int selectedIndex,
  }) {
    final ColorPalette colorPalette = context.colorPalette;
    final TextPalette textPalette = context.textPalette;

    return Container(
      height: 60,
      decoration: BoxDecoration(color: colorPalette.surface),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: BottomNavigationTabEnum.values.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == selectedIndex;

          return Expanded(
            child: Material(
              child: InkWell(
                onTap: () => onDestinationPressed(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Divider(height: 0),

                    // Top indicator
                    Container(
                      width: 48,
                      height: 3,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorPalette.branding
                            : Colors.transparent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Icon
                    Icon(
                      isSelected ? tab.selectedIcon : tab.defaultIcon,
                      color: isSelected
                          ? colorPalette.text
                          : colorPalette.border,
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    // Label
                    Text(
                      tab.title,
                      style: textPalette.labelSmall.copyWith(
                        color: isSelected
                            ? colorPalette.text
                            : colorPalette.border,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
