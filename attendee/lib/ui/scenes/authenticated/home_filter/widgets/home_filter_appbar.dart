import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class HomeFilterAppBar extends StatelessWidget {
  const HomeFilterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                    AppStringConstants.homeFilter.appBarTitle,
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
