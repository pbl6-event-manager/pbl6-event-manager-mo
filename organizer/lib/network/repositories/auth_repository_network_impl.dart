import 'package:organizer/domain/auth_repository.dart';
import 'package:organizer/network/datasources/auth_datasource.dart';
import 'package:organizer/network/dtos/response/sign_in_response_dto.dart';
import 'package:organizer/utils/constants/helpers/result.dart';

final class AuthRepositoryNetworkImpl implements AuthRepository {
  const AuthRepositoryNetworkImpl({required this.datasource});
  final AuthDatasource datasource;

  @override
  Future<Result<String>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final SignInResponseDto responseDto = await datasource.signIn(
        credentials: {'email': email, 'password': password},
      );

      return Result.ok(responseDto.accessToken);
    } catch (error) {
      return Result.error(error);
    }
  }
}
