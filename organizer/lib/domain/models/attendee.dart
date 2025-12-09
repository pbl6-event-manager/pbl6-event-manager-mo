import 'package:json_annotation/json_annotation.dart';

part 'attendee.g.dart';

@JsonSerializable(createToJson: false)
class Attendee {
  final String fullName;
  final String email;
  @JsonKey(name: 'isCheckin')
  final bool? isCheckedIn;
  final String ticketName;
  final String? ticketPrice;

  const Attendee({
    required this.fullName,
    required this.email,
    required this.isCheckedIn,
    required this.ticketName,
    this.ticketPrice,
  });

  factory Attendee.fromJson(Map<String, dynamic> json) =>
      _$AttendeeFromJson(json);
}
