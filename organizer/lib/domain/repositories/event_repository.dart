import 'package:organizer/domain/models/event.dart';
import 'package:organizer/utils/helpers/result.dart';

abstract class EventRepository {
  Future<Result<List<Event>>> getEvents();
}
