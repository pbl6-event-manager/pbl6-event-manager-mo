import "package:attendee/utils/constants/ui_constants.dart";
import "package:attendee/utils/extensions/context_extension.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";

/// Showing an image with rounded corners and tag
class CommonImageWidget extends StatelessWidget {
  const CommonImageWidget({
    super.key,
    required this.imageUrl,
    this.aspectRatio = 16 / 9,
    this.width,
    this.height,
    this.cornerRadius = UIConstants.cornerRadiusBase,

    this.topRightTag,
  }) : assert(
         !(width != null && height != null),
         "Set either width or height, not both",
       );

  final String imageUrl;
  final double aspectRatio;
  final double? width;
  final double? height;

  final double cornerRadius;

  final Widget? topRightTag;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (topRightTag != null)
          Positioned(top: 12, right: 12, child: topRightTag!),
        SizedBox(
          width: width,
          height: height,
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadius),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    ColoredBox(color: context.colorPalette.surfaceContainer),

                placeholder: (context, url) =>
                    ColoredBox(color: context.colorPalette.surfaceContainer),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
