import "package:attendee/utils/constants/app_string_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:attendee/utils/string_utils.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

class AccountGeneralInfoCard extends StatelessWidget {
  const AccountGeneralInfoCard({
    super.key,
    required this.firstName,
    required this.address,
    required this.attendedEventCount,
    required this.imageUrl,
    required this.lastName,
  });

  final String firstName;
  final String lastName;
  final String? address;
  final int? attendedEventCount;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorPalette.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          children: [
            (imageUrl != null)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageUrl!,
                      height: 80,
                      width: 80,
                      errorWidget: (context, url, error) =>
                          _buildDefaultAvatar(context),
                    ),
                  )
                : _buildDefaultAvatar(context),
            SizedBox(width: 16),
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$firstName $lastName",
                  style: context.textPalette.headlineLarge,
                ),
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

  Widget _buildDefaultAvatar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorPalette.primary,
        borderRadius: BorderRadius.circular(40),
      ),
      width: 80,
      height: 80,
      child: Center(
        child: Text(
          StringUtils.getNameInitals(firstName: firstName, lastName: lastName),
          style: context.textPalette.displayLarge.copyWith(
            fontSize: 28,
            color: context.colorPalette.onPrimary,
          ),
        ),
      ),
    );
  }
}
