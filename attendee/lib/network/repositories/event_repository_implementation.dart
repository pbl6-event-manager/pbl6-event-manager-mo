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
}
