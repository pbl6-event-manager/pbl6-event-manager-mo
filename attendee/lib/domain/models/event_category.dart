import 'package:json_annotation/json_annotation.dart';

part 'event_category.g.dart';

@JsonSerializable(createToJson: false)
class EventCategory {
  const EventCategory({
    required this.id,
    required this.name,
    required this.description,
  });
  final int id;
  final String name;
  final String? description;

  factory EventCategory.fromJson(Map<String, dynamic> json) =>
      _$EventCategoryFromJson(json);

  static List<EventCategory> dummy = List.filled(
    5,
    EventCategory(id: 1, name: 'Data', description: null),
  );
}
