import 'dart:math';

import 'package:attendee/domain/models/organizer.dart';
import 'package:attendee/domain/models/ticket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(createToJson: false)
class Event {
  final int id;
  final String? title;
  final String? summary;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? address;
  final String? city;
  final String? country;
  final String? language;
  final int? ownerId;
  final Organizer? organizer;
  final String? status;
  final String? bannerImagePath;
  final double? latitude;
  final double? longitude;
  final List<Ticket>? tickets;

  const Event({
    required this.id,
    this.title,
    this.summary,
    this.startTime,
    this.endTime,
    this.address,
    this.city,
    this.country,
    this.language,
    this.ownerId,
    this.organizer,
    this.status,
    this.bannerImagePath,
    this.latitude,
    this.longitude,
    this.tickets,
  });

  int? get organizerId => organizer?.id;

  /// If there are only 10% of the total tickets available for sale
  bool get areFewTicketsLeft {
    final totals = tickets?.fold<({int total, int remaining})>(
      (total: 0, remaining: 0),
      (previousValue, element) {
        return (
          total: previousValue.total + element.quantity,
          remaining: previousValue.remaining + element.remainingQuantity,
        );
      },
    );
    if (totals == null || totals.total == 0) return false;

    return totals.remaining / totals.total <= 0.1;
  }

  double? get staringPrice {
    if (tickets == null) {
      return null;
    }

    return tickets!.map<double>((ticket) => ticket.price).toList().reduce(min);
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  ({double lat, double long})? get coordiates =>
      latitude != null && longitude != null
      ? (lat: latitude!, long: longitude!)
      : null;

  String get cityAndCountryLabel => [
    city,
    country,
  ].where((string) => string != null && string.isNotEmpty).join(', ');

  static Event dummyEvent = Event(
    id: 1,
    title: 'Sample Event',
    summary: 'This is a sample event for demonstration purposes.',
    startTime: DateTime(1970),
    endTime: DateTime(1970),
    address: '123 Main Street',
    city: 'Sample City',
    country: 'Sample Country',
    language: 'English',
    ownerId: 100,
    organizer: null,
    status: 'active',
    bannerImagePath:
        'https://images.unsplash.com/photo-1761828122700-11b752d69a88?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1287',
  );
}
