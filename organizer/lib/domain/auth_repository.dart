import 'package:organizer/utils/constants/helpers/result.dart';

abstract class AuthRepository {
  Future<Result<String>> signIn({
    required String email,
    required String password,
  });
}
