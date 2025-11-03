import 'package:attendee/domain/models/organizer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(createToJson: false)
class Event {
  final int id;
  final String? title;
  final String? summary;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final String? address;
  final String? city;
  final String? country;
  final String? language;
  final int? ownerId;
  final Organizer? organizer;
  final String? status;
  final String? bannerImagePath;

  const Event({
    required this.id,
    this.title,
    this.summary,
    this.date,
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
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  int? get organizerId => organizer?.id;

  String get cityAndCountryLabel => [
    city,
    country,
  ].where((string) => string != null && string.isNotEmpty).join(', ');

  static Event dummyEvent = Event(
    id: 1,
    title: 'Sample Event',
    summary: 'This is a sample event for demonstration purposes.',
    date: DateTime.now(),
    startTime: '18:00',
    endTime: '21:00',
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
