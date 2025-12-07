import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
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
  final String? status;
  final String? bannerImagePath;
  final double? latitude;
  final double? longitude;

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
    this.status,
    this.bannerImagePath,
    this.latitude,
    this.longitude,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> get toJson => _$EventToJson(this);

  String get toJsonString {
    return jsonEncode(toJson);
  }

  factory Event.fromJsonString(String jsonString) =>
      Event.fromJson(jsonDecode(jsonString));
}
