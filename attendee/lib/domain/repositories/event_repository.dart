import "package:attendee/domain/models/event.dart";
import "package:attendee/utils/helpers/result.dart";

abstract class EventRepository {
  Future<Result<List<Event>>> getEvents();

  Future<Result<List<Event>>> getEventsNearby({
    required double lat,
    required double long,
  });
}
