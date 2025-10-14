import "package:attendee/domain/models/event_category.dart";
import "package:attendee/domain/repositories/category_repository.dart";
import "package:attendee/network/datasources/category_datasource.dart";
import "package:attendee/utils/helpers/result.dart";

final class CategoryRepositoryImplementation implements CategoryRepository {
  final CategoryDatasource _datasource;

  CategoryRepositoryImplementation({
    required CategoryDatasource categoryDatasource,
  }) : _datasource = categoryDatasource;
  @override
  Future<Result<List<EventCategory>>> getCategories() async {
    try {
      final List<EventCategory> categoryListResult = await _datasource
          .getCategories();
      return Result.ok(categoryListResult);
    } catch (error) {
      return Result.error(error);
    }
  }
}
