import 'package:attendee/domain/models/user.dart';
import 'package:attendee/domain/repositories/user_repository.dart';
import 'package:attendee/network/datasources/user_datasource.dart';
import 'package:attendee/network/dtos/requests/user_update_request_dto.dart';
import 'package:attendee/utils/helpers/result.dart';
import 'package:dio/dio.dart';

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

  @override
  Future<Result<User>> editUserInfo({
    required String? firstName,
    required String? lastName,
    required String? phoneNumber,
    required MultipartFile? avatarBinary,
  }) async {
    try {
      final dto = UserUpdateRequestDto(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        avatarBinary: avatarBinary,
      );
      final user = await _userDatasource.updateUserInfo(formData: dto.toForm);
      return Result.ok(user);
    } catch (error) {
      return Result.error(error);
    }
  }
}
