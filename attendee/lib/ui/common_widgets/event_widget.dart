import 'package:attendee/domain/models/event.dart';
import 'package:attendee/ui/common_widgets/common_event_tag.dart';
import 'package:attendee/ui/common_widgets/common_image_carousel.dart';
import 'package:attendee/ui/common_widgets/common_image_widget.dart';
import 'package:attendee/utils/constants/app_string_constants.dart';
import 'package:attendee/utils/constants/ui_constants.dart';

import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:attendee/utils/extensions/double_extension.dart';
import 'package:attendee/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

/// A widget showing an event, with ability to share and mark as favourite
///
/// There are two variations:
/// - Normal: Big image with share button: [EventWidget]
/// - Compact: Small image without share button and single image only (first image of the list) [EventWidget.compact]
class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    this.isLoading = false,
    required this.event,
    required this.onTapped,
    this.onSharePressed,
  }) : _isCompact = false;

  const EventWidget.compact({
    super.key,
    this.isLoading = false,
    required this.event,
    required this.onTapped,
    this.onSharePressed,
  }) : _isCompact = true;

  final VoidCallback? onTapped;

  final bool _isCompact;
  final bool isLoading;
  final Event event;
  final VoidCallback? onSharePressed;

  String get title =>
      isLoading ? 'Loading Event Title Here' : (event.title ?? '');

  DateTime get startTime => event.startTime ?? DateTime.now();

  String get location =>
      isLoading ? 'Loading location here' : (event.city ?? event.address ?? '');

  double? get startingPrice => event.startingPrice;

  List<String> get imageUrls {
    if (event.bannerImagePath != null && event.bannerImagePath!.isNotEmpty) {
      return [event.bannerImagePath!];
    }
    return [];
  }

  // TODO: Add favorite feature
  bool get isFavorite => false;

  bool get isFewTicketLeft => event.areFewTicketsLeft;

  String get dateTimeAndLocation =>
      startTime.shortenDateTimeStringWithDot.withDot(location);

  VoidCallback? get onFavoritePressed => () {};

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(UIConstants.cornerRadiusBase),
      onTap: onTapped,
      child: _isCompact
          ? _buildCompactEventItem(context)
          : _buildFullSizeEventItem(context),
    );
  }

  Widget _buildCompactEventItem(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonImageWidget(
          imageUrl: imageUrls.firstOrNull ?? '',
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
                imageUrl: imageUrls.firstOrNull ?? '',
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
    final priceLabel = switch (startingPrice) {
      null => '',
      0 => AppStringConstants.event.freePricing,
      double value => value.formatPriceLabel(),
    };

    return Text(priceLabel, style: context.textPalette.labelLarge);
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
            _isCompact ? '$title\n' : title,
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
