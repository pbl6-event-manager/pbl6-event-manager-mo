import 'package:attendee/ui/common_widgets/option_list.dart';
import 'package:attendee/ui/scenes/authenticated/ticket/enums/ticket_option.dart';
import 'package:flutter/material.dart';

class TicketOptionSection extends StatelessWidget {
  const TicketOptionSection({super.key, required this.onOptionTapped});

  final ValueChanged<TicketOption> onOptionTapped;

  @override
  Widget build(BuildContext context) {
    return OptionList(
      options: TicketOption.values,
      onOptionTapped: onOptionTapped,
    );
  }
}
