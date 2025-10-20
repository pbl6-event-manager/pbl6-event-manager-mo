import "package:attendee/domain/models/event.dart";
import "package:attendee/domain/repositories/event_repository.dart";
import "package:attendee/network/datasources/event_datasource.dart";
import "package:attendee/utils/helpers/result.dart";

final class EventRepositoryImplementation implements EventRepository {
  final EventDatasource _eventDatasource;

  const EventRepositoryImplementation({
    required EventDatasource eventDatasource,
  }) : _eventDatasource = eventDatasource;

  @override
  Future<Result<List<Event>>> getEvents() async {
    try {
      final List<Event> fetchedEventList = await _eventDatasource.getEvents();

      return Result.ok(fetchedEventList);
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Event>>> getEventsNearby({
    required double lat,
    required double long,
  }) async {
    try {
      final List<Event> fetchedEventList = await _eventDatasource
          .getEventsNearby(
            latitude: lat,
            longitude: long,
            radiusInMeter: 10000,
          );

      return Result.ok(fetchedEventList);
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<Event>>> searchEvents({
    String? keyword,

    String? location,
    DateTime? startDate,
    DateTime? endDate,
    Set<int>? categoryIds,
  }) async {
    final (country, city) = _parseLocation(location);
    try {
      final List<Event> fetchedEventList = await _eventDatasource.searchEvents(
        keyword: keyword,
        city: city,
        country: country,
        startDate: startDate?.toIso8601String(),
        endDate: endDate?.toIso8601String(),
        categoryIds: categoryIds?.toList(),
      );

      return Result.ok(fetchedEventList);
    } catch (error) {
      return Result.error(error);
    }
  }

  /// Receives a location, split it into optional country and optional city
  ///
  /// A location from VM could be:
  /// - `null`
  /// - A country only ("Vietnam")
  /// - A country and city,  splitted by a comma ("Danang, Vietnam")
  (String?, String?) _parseLocation(String? location) {
    if (location == null || location.isEmpty) {
      return (null, null);
    }

    final parts = location.split(", ");
    return (parts.firstOrNull, parts.length >= 2 ? parts[1] : null);
  }
}
