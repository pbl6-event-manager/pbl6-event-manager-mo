import 'package:attendee/domain/models/user.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:dio/dio.dart';

abstract class UserRepository {
  Future<Result<User>> getUserInfo();

  Future<Result<User>> editUserInfo({
    required String? firstName,
    required String? lastName,
    required String? phoneNumber,
    required MultipartFile? avatarBinary,
  });
}
