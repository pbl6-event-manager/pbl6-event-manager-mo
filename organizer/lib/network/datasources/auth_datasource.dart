import 'package:dio/dio.dart';
import 'package:organizer/network/constants/api_endpoint_constants.dart';
import 'package:organizer/network/dtos/response/sign_in_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_datasource.g.dart';

@RestApi()
abstract class AuthDatasource {
  factory AuthDatasource(Dio dio) = _AuthDatasource;

  @POST(ApiEndpointConstants.signIn)
  /// Map{"email": String, "password": String}
  Future<SignInResponseDto> signIn({
    @Body() required Map<String, String> credentials,
  });
}
