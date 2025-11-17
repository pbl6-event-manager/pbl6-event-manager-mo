import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A image carousel with page indicator
///
/// Show dot indicator for a few images, or a counter if there are many
///
/// A complex version of [CommonImageWidget]
class CommonImageCarousel extends StatefulWidget {
  const CommonImageCarousel({
    super.key,

    required this.imageUrls,
    this.aspectRatio = 16 / 9,
    this.width,
    this.height,
    this.cornerRadius = UIConstants.cornerRadiusBase,
    this.topRightTag,
    this.boxFit = BoxFit.cover,
    this.enableSizeAnimation = false,
    this.activePageScale = 1,
    this.inactivePageScale = 0.9,
    this.sizeAnimationDuration = const Duration(milliseconds: 250),
    this.sizeAnimationCurve = Curves.easeOut,
    this.showIndicator = true,
    this.onPageChanged,
  });

  final List<String> imageUrls;
  final double aspectRatio;
  final double? width;
  final double? height;
  final double cornerRadius;
  final Widget? topRightTag;
  final BoxFit boxFit;
  final bool enableSizeAnimation;
  final double activePageScale;
  final double inactivePageScale;
  final Duration sizeAnimationDuration;
  final Curve sizeAnimationCurve;
  final bool showIndicator;
  final ValueChanged<int>? onPageChanged;

  @override
  State<CommonImageCarousel> createState() => _CommonImageCarouselState();
}

class _CommonImageCarouselState extends State<CommonImageCarousel> {
  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.imageUrls;

    if (images.isEmpty) {
      return SizedBox(
        height: widget.height,
        child: AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.cornerRadius),
            child: Container(
              color: context.colorPalette.surface,
              child: Icon(
                Icons.image,
                size: 50,
                color: context.colorPalette.textPlaceholder,
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: widget.height,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.cornerRadius),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    widget.onPageChanged?.call(index);
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) => _buildItem(
                  context,
                  index,
                  images: images,
                  pageController: _pageController,
                ),
              ),
            ),
            if (widget.topRightTag != null)
              Positioned(top: 12, right: 12, child: widget.topRightTag!),

            if (widget.showIndicator)
              Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: Skeleton.ignore(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 6,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorPalette.primary.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(
                          UIConstants.cornerRadiusBase,
                        ),
                      ),
                      child: _buildIndicators(context, images.length),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    int index, {
    required List<String> images,
    required PageController? pageController,
  }) {
    final image = CachedNetworkImage(
      imageUrl: images[index],
      fit: widget.boxFit,
      errorWidget: (context, url, error) =>
          ColoredBox(color: context.colorPalette.surfaceContainer),
      placeholder: (context, url) =>
          ColoredBox(color: context.colorPalette.surfaceContainer),
    );

    if (!widget.enableSizeAnimation) {
      return image;
    }

    final pageController = _pageController;
    if (pageController == null) {
      return image;
    }

    return AnimatedBuilder(
      animation: pageController,
      child: image,
      builder: (context, child) {
        double page = pageController.page ?? _currentIndex.toDouble();
        double swipeProgressPercent = (page - index).abs().clamp(0, 1);

        double scaleFactor =
            widget.activePageScale -
            (widget.activePageScale - widget.inactivePageScale) *
                swipeProgressPercent;

        return AnimatedScale(
          scale: scaleFactor,
          duration: widget.sizeAnimationDuration,
          curve: widget.sizeAnimationCurve,
          child: child,
        );
      },
    );
  }

  Widget _buildIndicators(BuildContext context, int imageCount) {
    const maxIndicators = 6;

    // If we have few images, show all dots
    if (imageCount <= maxIndicators) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          imageCount,
          (index) => Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentIndex == index
                  ? context.colorPalette.invertedText
                  : context.colorPalette.invertedDisabledText,
            ),
          ),
        ),
      );
    }

    // For many images, show counter text instead
    return Text(
      '${_currentIndex + 1}/$imageCount',
      style: TextStyle(
        color: context.colorPalette.invertedText,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
