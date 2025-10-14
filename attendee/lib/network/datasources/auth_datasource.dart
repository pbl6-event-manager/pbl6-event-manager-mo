import "package:attendee/network/constants/api_endpoint_constants.dart";
import "package:attendee/network/custom_annotations.dart";
import "package:attendee/network/dtos/sign_in_response_dto.dart";
import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

part "auth_datasource.g.dart";

@RestApi()
abstract class AuthDatasource {
  factory AuthDatasource(Dio dio) = _AuthDatasource;

  @POST(ApiEndpointConstants.checkEmail)
  @NoAuth()
  Future<bool> checkIfEmailExists({@Body() required Map<String, String> data});

  @POST(ApiEndpointConstants.signIn)
  /// Map{"email": String, "password": String}
  Future<SignInResponseDto> signIn({
    @Body() required Map<String, String> credentials,
  });
  @POST(ApiEndpointConstants.signUp)
  Future<void> signUp({@Body() required Map<String, String> credentials});
}
