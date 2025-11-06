import 'package:attendee/ui/scenes/authenticated/event_detail/bloc/event_detail_bloc.dart';
import 'package:attendee/utils/constants/ui_constants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventDetailImage extends StatelessWidget {
  const EventDetailImage({super.key, required this.state});

  final EventDetailState state;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: UIConstants.imageAspectRatio,
      child: CachedNetworkImage(
        imageUrl: state.event?.bannerImagePath ?? '',
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => SizedBox.shrink(),
      ),
    );
  }
}
