import 'package:attendee/network/constants/api_endpoint_constants.dart';
import 'package:attendee/network/custom_annotations.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'location_datasource.g.dart';

@RestApi()
abstract class LocationDatasource {
  factory LocationDatasource(Dio dio, {String? baseUrl}) = _LocationDatasource;

  @GET(ApiEndpointConstants.locationCountryList)
  @NoAuth()
  Future<HttpResponse> getCountries();

  @GET(ApiEndpointConstants.locationCityList)
  @NoAuth()
  Future<HttpResponse> getCities({@Query('country') required String country});
}
