import 'package:attendee/utils/extensions/date_time_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organizer.g.dart';

@JsonSerializable(createToJson: false)
class Organizer {
  final int id;
  final String? name;
  final String? description;
  final String? contactEmail;
  final String? contactPhone;
  final String? website;
  final String? logoUrl;
  final bool? isActive;
  final int? ownerId;
  final DateTime? createdAt;

  const Organizer({
    required this.id,
    this.name,
    this.description,
    this.contactEmail,
    this.contactPhone,
    this.website,
    this.logoUrl,
    this.isActive,
    this.ownerId,
    this.createdAt,
  });
  factory Organizer.fromJson(Map<String, dynamic> json) =>
      _$OrganizerFromJson(json);

  int? get yearsHosted => createdAt?.yearsBetween(DateTime.now());
}
