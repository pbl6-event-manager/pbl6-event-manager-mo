import "package:attendee/domain/models/event.dart";
import "package:attendee/utils/helpers/result.dart";

abstract class EventRepository {
  Future<Result<List<Event>>> getEvents();
}
