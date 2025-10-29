import 'package:attendee/domain/models/event_category.dart';
import 'package:attendee/network/constants/api_endpoint_constants.dart';
import 'package:attendee/network/custom_annotations.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'category_datasource.g.dart';

@RestApi()
abstract class CategoryDatasource {
  factory CategoryDatasource(Dio dio) = _CategoryDatasource;

  @GET(ApiEndpointConstants.categories)
  @NoAuth()
  Future<List<EventCategory>> getCategories();
}
