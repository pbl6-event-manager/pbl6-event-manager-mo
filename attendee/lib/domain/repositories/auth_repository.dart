import "package:attendee/utils/helpers/result.dart";

abstract class AuthRepository {
  Future<Result<bool>> checkIfEmailExists({required String email});

  /// (Access token, refresh token)
  Future<Result<(String, String)>> signIn({
    required String email,
    required String password,
  });
}
