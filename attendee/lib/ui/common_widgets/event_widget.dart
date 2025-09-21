import "package:attendee/ui/common_widgets/common_event_tag.dart";
import "package:attendee/ui/common_widgets/common_image_carousel.dart";
import "package:attendee/ui/common_widgets/common_image_widget.dart";
import "package:attendee/utils/constants/app_string_constants.dart";

import "package:attendee/utils/extensions/context_extension.dart";
import "package:attendee/utils/extensions/date_time_extension.dart";
import "package:attendee/utils/extensions/string_extension.dart";
import "package:flutter/material.dart";

/// A widget showing an event, with ability to share and mark as favourite
///
/// There are two variations:
/// - Normal: Big image with share button: [EventWidget]
/// - Compact: Small image without share button and single image only (first image of the list) [EventWidget.compact]
class EventWidget extends StatelessWidget {
  const EventWidget({super.key}) : _isCompact = false;

  const EventWidget.compact({super.key}) : _isCompact = true;

  final bool _isCompact;

  // TODO: Apply model later

  String get title => "FREE Gaming and Bartending ";
  DateTime get startTime => DateTime.now();
  String get location => "This is a location";
  bool get isFree => false;
  int get pricing => 90;
  List<String> get imageUrls => [
    "https://images.unsplash.com/photo-1755357667384-adec9e5cdf84?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1511795409834-ef04bbd61622?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.1.0",
    "https://images.unsplash.com/photo-1505373877841-8d25f7d46678?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.1.0",
    "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.1.0",
    "https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.1.0",
    "https://images.unsplash.com/photo-1429962714451-bb934ecdc4ec?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.1.0",
  ];

  bool get isFavorite => false;
  bool get isFewTicketLeft => true;

  VoidCallback? get onSharePressed => () {};

  String get dateTimeAndLocation =>
      startTime.shortenStringWithDot.withDot(location);

  VoidCallback? get onFavoritePressed => () {};

  @override
  Widget build(BuildContext context) {
    return _isCompact
        ? _buildCompactEventItem(context)
        : _buildFullSizeEventItem(context);
  }

  Widget _buildCompactEventItem(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonImageWidget(
          imageUrl: imageUrls.isNotEmpty ? imageUrls.first : "",
          aspectRatio: 1,
          width: 90,
        ),
        SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleAndButtonsRow(context),
              _buildTimeAndLocationLabel(context),
              Row(
                children: [
                  _buildPricingLabel(context),
                  SizedBox(width: 8),
                  if (isFewTicketLeft) Flexible(child: CommonEventTag()),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFullSizeEventItem(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageUrls.length > 1
            ? CommonImageCarousel(
                imageUrls: imageUrls,
                topRightTag: isFewTicketLeft ? CommonEventTag() : null,
              )
            : CommonImageWidget(
                imageUrl: imageUrls.first,
                topRightTag: isFewTicketLeft ? CommonEventTag() : null,
              ),
        SizedBox(height: 16),
        _titleAndButtonsRow(context),
        SizedBox(height: 8),
        _buildTimeAndLocationLabel(context),
        SizedBox(height: 8),
        _buildPricingLabel(context),
      ],
    );
  }

  Widget _buildPricingLabel(BuildContext context) {
    return Text(
      isFree ? AppStringConstants.event.freePricing : pricing.toString(),
      style: context.textPalette.labelLarge,
    );
  }

  Widget _buildTimeAndLocationLabel(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      dateTimeAndLocation,
      style: context.textPalette.labelLarge.copyWith(
        color: context.colorPalette.textPlaceholder,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  /// Making two lines always if compact
  Widget _titleAndButtonsRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            _isCompact ? "$title\n" : title,
            style: _isCompact
                ? context.textPalette.headlineSmall
                : context.textPalette.headlineLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        if (!_isCompact)
          IconButton(
            onPressed: onSharePressed,
            icon: Icon(Icons.file_upload_outlined),
          )
        else
          SizedBox(width: 16),
        IconButton(
          onPressed: onFavoritePressed,
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        ),
      ],
    );
  }
}
