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

  static Organizer dummyOrganizer = Organizer(
    id: 123,
    name: 'Event Masters',
    description: 'A leading organization hosting incredible events.',
    contactEmail: 'contact@eventmasters.com',
    contactPhone: '+1 123-456-7890',
    website: 'https://eventmasters.com',
    logoUrl:
        'https://images.unsplash.com/photo-1761828122700-11b752d69a88?ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&q=80&w=1287',
    isActive: true,
    ownerId: 1000,
    createdAt: DateTime(1970),
  );
}
