import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:flutter/material.dart";

class AccountGeneralInfoCard extends StatelessWidget {
  const AccountGeneralInfoCard({
    super.key,
    required this.name,
    required this.address,
    required this.attendedEventCount,
  });

  final String name;
  final String? address;
  final int? attendedEventCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorPalette.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              color: context.colorPalette.primary,
            ),
            SizedBox(width: 16),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: context.textPalette.headlineLarge),
                if (address != null) Text(address!),

                if (attendedEventCount != null)
                  Text(
                    AppStringConstants.account.eventsAttended(
                      attendedEventCount!,
                    ),
                    style: context.textPalette.subtitleLarge.copyWith(
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
