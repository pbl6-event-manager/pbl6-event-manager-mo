import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({
    super.key,
    required this.onNotificationTapped,
    required this.onSettingTapped,
  });
  final void Function() onNotificationTapped;
  final void Function() onSettingTapped;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: context.colorPalette.border.withValues(alpha: 0.2),
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          AppStringConstants.account.appBarTitle,
          style: context.textPalette.displayMedium,
        ),
      ),
      actionsPadding: EdgeInsets.only(
        right: UIConstants.horizontalPadding,
        top: 20,
        bottom: 10,
      ),
      actions: [
        IconButton(
          onPressed: onNotificationTapped,
          icon: Icon(Icons.notifications),
        ),
        IconButton(onPressed: onSettingTapped, icon: Icon(Icons.settings)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
