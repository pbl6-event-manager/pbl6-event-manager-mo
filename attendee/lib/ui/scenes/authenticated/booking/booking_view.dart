import 'package:attendee/ui/common_widgets/error_page.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.id});

  final int? id;

  @override
  Widget build(BuildContext context) {
    return id != null ? const BookingView() : const ErrorPage();
  }
}

class BookingView extends StatelessWidget {
  const BookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Placeholder());
  }
}
