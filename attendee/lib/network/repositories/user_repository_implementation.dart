import "package:attendee/domain/models/user.dart";
import "package:attendee/domain/repositories/user_repository.dart";
import "package:attendee/network/datasources/user_datasource.dart";
import "package:attendee/utils/helpers/result.dart";

final class UserRepositoryImplementation implements UserRepository {
  final UserDatasource _userDatasource;

  const UserRepositoryImplementation({required UserDatasource userDatasource})
    : _userDatasource = userDatasource;
  @override
  Future<Result<User>> getUserInfo() async {
    try {
      final user = await _userDatasource.getUserInfo();
      return Result.ok(user);
    } catch (error) {
      return Result.error(error);
    }
  }
}
