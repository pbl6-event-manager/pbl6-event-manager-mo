import "package:attendee/domain/models/user.dart";
import "package:attendee/utils/helpers/result.dart";

abstract class UserRepository {
  Future<Result<User>> getUserInfo();
}
