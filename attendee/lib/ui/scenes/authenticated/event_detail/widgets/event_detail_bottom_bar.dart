import 'package:attendee/utils/constants/ui_constants.dart';
import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class EventDetailBottomBar extends StatelessWidget {
  const EventDetailBottomBar({
    super.key,
    required this.onPrimaryButtonTapped,
    required this.dateTimeString,
    required this.pricingString,
    required this.isHidden,
    required this.primaryButtonLabel,
  }) : _isPrimaryButtonExpanded = false;

  const EventDetailBottomBar.expanded({
    super.key,
    required this.onPrimaryButtonTapped,
    this.dateTimeString,
    required this.pricingString,
    required this.isHidden,
    required this.primaryButtonLabel,
  }) : _isPrimaryButtonExpanded = true;

  final VoidCallback? onPrimaryButtonTapped;
  final String? dateTimeString;
  final String pricingString;
  final bool isHidden;
  final String primaryButtonLabel;

  final bool _isPrimaryButtonExpanded;

  @override
  Widget build(BuildContext context) {
    final double barHeight = _isPrimaryButtonExpanded ? 120 : 80;
    return AnimatedContainer(
      curve: Curves.easeOutSine,
      duration: Duration(milliseconds: 800),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: UIConstants.horizontalPadding),
      height: isHidden ? 0 : barHeight,

      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 16),
        child: _isPrimaryButtonExpanded
            ? _buildExpandedBar(context)
            : _buildNormalBar(context),
      ),
    );
  }

  Widget _buildNormalBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pricingString,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textPalette.labelLarge,
              ),
              if (dateTimeString != null)
                Text(
                  dateTimeString!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: Align(
            alignment: AlignmentGeometry.centerRight,
            child: FilledButton(
              onPressed: onPrimaryButtonTapped,
              child: Text(primaryButtonLabel),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          pricingString,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textPalette.labelLarge,
        ),
        SizedBox(height: 12),

        FilledButton(
          onPressed: onPrimaryButtonTapped,
          child: Text(primaryButtonLabel),
        ),
      ],
    );
  }
}
