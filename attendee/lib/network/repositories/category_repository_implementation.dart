import 'package:attendee/domain/models/event_category.dart';
import 'package:attendee/domain/repositories/category_repository.dart';
import 'package:attendee/network/datasources/category_datasource.dart';
import 'package:attendee/utils/helpers/cache_object.dart';
import 'package:attendee/utils/helpers/result.dart';

final class CategoryRepositoryImplementation implements CategoryRepository {
  final CategoryDatasource _datasource;
  CacheData<List<EventCategory>>? _categoriesCache;

  CategoryRepositoryImplementation({
    required CategoryDatasource categoryDatasource,
  }) : _datasource = categoryDatasource;
  @override
  Future<Result<List<EventCategory>>> getCategories() async {
    final cached = _categoriesCache?.data;
    if (cached != null) {
      return Result.ok(cached);
    }

    final response = await _datasource.getCategories();

    try {
      _categoriesCache = CacheData<List<EventCategory>>(
        data: response,
        staleTime: DateTime.now().add(Duration(minutes: 5)),
      );
      return Result.ok(response);
    } catch (error) {
      return Result.error(error);
    }
  }

  void clearCache() {
    _categoriesCache = null;
  }
}
