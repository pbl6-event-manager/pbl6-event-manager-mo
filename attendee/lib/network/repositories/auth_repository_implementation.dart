// lib/network/repositories/check_email_repository.dart
import "package:attendee/domain/repositories/auth_repository.dart";
import "package:attendee/network/datasources/auth_datasource.dart";
import "package:attendee/network/dtos/sign_in_response_dto.dart";
import "package:attendee/utils/helpers/result.dart";

final class AuthRepositoryImplementation implements AuthRepository {
  final AuthDatasource _authDatasource;

  const AuthRepositoryImplementation({required AuthDatasource authDatasource})
    : _authDatasource = authDatasource;

  @override
  Future<Result<bool>> checkIfEmailExists({required String email}) async {
    try {
      final result = await _authDatasource.checkIfEmailExists(
        data: {"email": email},
      );
      return Result.ok(result);
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<(String, String)>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final SignInResponseDto tokenData = await _authDatasource.signIn(
        credentials: {"email": email, "password": password},
      );

      return Result.ok(tokenData.toDomain());
    } catch (error) {
      return Result.error(error);
    }
  }

  @override
  Future<Result<void>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      await _authDatasource.signUp(
        credentials: {
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
        },
      );

      return const Result.ok(null);
    } catch (error) {
      return Result.error(error);
    }
  }
}
