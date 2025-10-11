// lib/network/repositories/check_email_repository.dart
import "package:attendee/domain/repositories/check_email_repository.dart";
import "package:attendee/network/datasources/auth_datasource.dart";
import "package:attendee/utils/helpers/result.dart";

final class CheckEmailRepositoryImplementation implements CheckEmailRepository {
  final AuthDatasource _authDatasource;

  const CheckEmailRepositoryImplementation({
    required AuthDatasource authDatasource,
  }) : _authDatasource = authDatasource;

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
}
