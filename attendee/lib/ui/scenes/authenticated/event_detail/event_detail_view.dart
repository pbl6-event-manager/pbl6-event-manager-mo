import 'package:attendee/domain/models/event.dart';
import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({
    super.key,
    required this.eventId,
    required this.event,
  });

  final int? eventId;
  final Event? event;

  @override
  Widget build(BuildContext context) {
    return const EventDetailView();
  }
}

class EventDetailView extends StatelessWidget {
  const EventDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Scaffold());
  }
}
