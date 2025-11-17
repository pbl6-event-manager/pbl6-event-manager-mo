import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class TicketHeader extends StatelessWidget {
  const TicketHeader({
    super.key,
    required this.width,
    this.height = 16,
    required this.containerColor,
    this.borderRadius = UIConstants.cornerRadiusBase,
  }) : isBottomUp = false;

  const TicketHeader.bottomUp({
    super.key,
    required this.width,
    this.height = 16,
    required this.containerColor,
    this.borderRadius = UIConstants.cornerRadiusBase,
  }) : isBottomUp = true;

  final double width;
  final double height;
  final Color containerColor;
  final double borderRadius;
  final bool isBottomUp;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketHeaderClipper(isBottomUp: isBottomUp),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: isBottomUp
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
        ),
      ),
    );
  }
}

/// Custom clipper to cut out ticket notches
class TicketHeaderClipper extends CustomClipper<Path> {
  final bool isBottomUp;

  const TicketHeaderClipper({super.reclip, required this.isBottomUp});
  @override
  Path getClip(Size size) {
    // Rectangle
    // Rectangle
    final Path path = Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 0);

    final double ovalHeight = size.height * 2;
    final double ovalWidth = size.height * 4;
    final double verticalCenter = isBottomUp ? size.height : 0;

    // Top oval
    final oval = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(size.width / 2, verticalCenter),
          width: ovalWidth,
          height: ovalHeight,
        ),
      );

    return Path.combine(PathOperation.difference, path, oval);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
