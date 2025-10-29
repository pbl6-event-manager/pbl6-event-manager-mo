import 'dart:io';

import 'package:attendee/ui/common_widgets/tappable_text_with_underline.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingAvatarWidget extends StatelessWidget {
  const AccountSettingAvatarWidget({
    super.key,
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.onUpdatePictureTapped,
    this.selectedImage,
  });

  final String? avatarUrl;
  final String? firstName;
  final String? lastName;
  final XFile? selectedImage;

  final VoidCallback onUpdatePictureTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Center(child: _buildAvatar(context)),

        TappableTextWithUnderline(
          label: AppStringConstants.account.updatePictureLabel,
          style: context.textPalette.subtitleLarge.copyWith(
            color: context.colorPalette.text,
          ),
          onTapped: onUpdatePictureTapped,
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    // Priority: 1. Local file, 2. Network image, 3. Default avatar
    if (selectedImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.file(
          File(selectedImage!.path),
          fit: BoxFit.cover,
          height: 80,
          width: 80,
          errorBuilder: (context, error, stackTrace) =>
              _buildDefaultAvatar(context),
        ),
      );
    } else if (avatarUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: avatarUrl!,
          height: 80,
          width: 80,
          errorWidget: (context, url, error) => _buildDefaultAvatar(context),
        ),
      );
    } else {
      return _buildDefaultAvatar(context);
    }
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
          StringUtils.getNameInitals(
            firstName: firstName ?? '',
            lastName: lastName ?? '',
          ),
          style: context.textPalette.displayLarge.copyWith(
            fontSize: 28,
            color: context.colorPalette.onPrimary,
          ),
        ),
      ),
    );
  }
}
