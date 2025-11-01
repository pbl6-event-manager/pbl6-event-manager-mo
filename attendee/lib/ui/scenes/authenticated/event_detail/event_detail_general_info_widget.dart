import 'package:attendee/utils/extensions/context_extension.dart';
import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:attendee/utils/extensions/string_extension.dart';
import 'package:flutter/widgets.dart';

class EventDetailGeneralInfoWidget extends StatelessWidget {
  const EventDetailGeneralInfoWidget({
    super.key,
    required this.title,
    required this.city,
    required this.address,
    required this.date,
  });
  final String? title;
  final String? city;
  final String? address;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title ?? '', style: context.textPalette.displayLarge),
        // Date time, location
        if (city != null) ...[
          SizedBox(height: 8),
          Text(
            overflow: TextOverflow.ellipsis,
            address != null ? address!.withDot(city!) : city!,
            style: context.textPalette.labelLarge.copyWith(
              color: context.colorPalette.textPlaceholder,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (date != null) ...[
            SizedBox(height: 4),
            Text(
              overflow: TextOverflow.ellipsis,

              date!.shortString,
              style: context.textPalette.labelLarge.copyWith(
                color: context.colorPalette.textPlaceholder,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ],
    );
  }
}
