import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  const CircularAvatar({
    super.key,
    this.size = 56,
    this.padding = 4,
    required this.url,
  });
  final double size;
  final double padding;

  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: url ?? '',
          placeholder: (context, string) => _buildDefaultAvatar(context),
          errorWidget: (context, string, object) =>
              _buildDefaultAvatar(context),
        ),
      ),
    );
  }

  Container _buildDefaultAvatar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      color: context.colorPalette.primary,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Icon(Icons.person, color: context.colorPalette.onPrimary),
      ),
    );
  }
}
