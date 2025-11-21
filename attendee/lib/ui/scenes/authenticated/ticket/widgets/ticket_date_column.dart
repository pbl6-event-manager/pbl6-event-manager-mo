import 'package:flutter/material.dart';

class TicketDateColumn extends StatelessWidget {
  const TicketDateColumn({super.key, required this.date, required this.time});

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text(date), Text(time)],
    );
  }
}
