import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/enums/app_version_utils.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class AppVersionRow extends StatelessWidget {
  const AppVersionRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStringConstants.account.versionLabel,
          style: context.textPalette.subtitleLarge.copyWith(fontSize: 12),
        ),
        Spacer(),
        FutureBuilder(
          future: AppVersionUtils.appVersion,
          builder: (context, asyncSnapshot) {
            return Text(
              asyncSnapshot.data ?? '',

              style: context.textPalette.subtitleLarge.copyWith(fontSize: 12),
            );
          },
        ),
      ],
    );
  }
}
