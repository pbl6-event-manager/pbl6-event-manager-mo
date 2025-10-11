import "package:attendee/network/constants/api_endpoint_constants.dart";
import "package:attendee/network/custom_annotations.dart";
import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

part "auth_datasource.g.dart";

@RestApi()
abstract class AuthDatasource {
  factory AuthDatasource(Dio dio) = _AuthDatasource;

  @POST(ApiEndpointConstants.checkEmail)
  @NoAuth()
  Future<bool> checkIfEmailExists({@Body() required Map<String, String> data});
}
