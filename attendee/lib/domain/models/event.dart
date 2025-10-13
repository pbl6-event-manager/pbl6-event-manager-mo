import "package:attendee/domain/models/organizer.dart";
import "package:json_annotation/json_annotation.dart";

part "event.g.dart";

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
}
