import 'package:flutter/material.dart';
import 'package:organizer/ui/common_widgets/check_in_button.dart';
import 'package:organizer/utils/extensions/context_extension.dart';

class HomeAttendeeTile extends StatelessWidget {
  final String attendeeName;
  final String ticketName;
  final String ticketPrice;
  final String email;
  final bool? isCheckedIn;
  final VoidCallback onTap;

  const HomeAttendeeTile({
    super.key,
    required this.attendeeName,
    required this.ticketName,
    required this.ticketPrice,
    required this.email,
    required this.isCheckedIn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: isCheckedIn != null
          ? SizedBox(
              width: 120,
              child: CheckInButton(isReserved: isCheckedIn!, onTapped: () {}),
            )
          : null,
      title: Text(attendeeName, style: context.textPalette.headlineLarge),
      subtitle: Text(email, style: context.textPalette.bodyLarge),
    );
  }
}
