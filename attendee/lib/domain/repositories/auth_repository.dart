import 'package:attendee/utils/helpers/result.dart';

abstract class AuthRepository {
  Future<Result<bool>> checkIfEmailExists({required String email});

  /// Returns access token and refresh token
  Future<Result<({String accessToken, String refreshToken})>> signIn({
    required String email,
    required String password,
  });
  Future<Result<void>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
}
