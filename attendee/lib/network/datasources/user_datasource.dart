import "package:attendee/domain/models/user.dart";
import "package:attendee/network/constants/api_endpoint_constants.dart";
import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";
part "user_datasource.g.dart";

@RestApi()
abstract class UserDatasource {
  factory UserDatasource(Dio dio) = _UserDatasource;

  @GET(ApiEndpointConstants.account)
  Future<User> getUserInfo();

  @PATCH(ApiEndpointConstants.account)
  @MultiPart()
  Future<User> updateUserInfo({@Body() required FormData formData});
}
