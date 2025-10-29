import 'package:attendee/domain/models/event_category.dart';
import 'package:attendee/utils/helpers/result.dart';

abstract class CategoryRepository {
  Future<Result<List<EventCategory>>> getCategories();
}
