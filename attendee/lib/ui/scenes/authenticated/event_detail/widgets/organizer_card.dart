import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrganizerCard extends StatelessWidget {
  const OrganizerCard({
    super.key,
    required this.organizer,
    required this.onContactTapped,
    required this.onFollowTapped,
  });

  final Organizer organizer;

  final VoidCallback? onFollowTapped;
  final VoidCallback? onContactTapped;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: context.colorPalette.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: organizer.logoUrl ?? '',
                    height: 80,
                    width: 80,
                    errorWidget: (context, url, error) => Container(
                      color: context.colorPalette.disabled,
                      child: Icon(
                        Icons.person,
                        color: context.colorPalette.onPrimary,
                        size: 32,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        organizer.name ?? '',
                        style: context.textPalette.headlineLarge,
                      ),

                      if (organizer.yearsHosted != null &&
                          organizer.yearsHosted! > 0) ...[
                        SizedBox(height: 4),
                        Text(
                          AppStringConstants.eventDetail.hostedForYears(
                            organizer.yearsHosted!,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Skeleton.leaf(
                    child: FilledButton(
                      onPressed: onContactTapped,
                      child: Text(AppStringConstants.eventDetail.followButton),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Skeleton.leaf(
                    child: OutlinedButton(
                      onPressed: onContactTapped,
                      child: Text(AppStringConstants.eventDetail.contactButton),
                    ),
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
