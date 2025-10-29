import "package:dio/dio.dart";

class UserUpdateRequestDto {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final MultipartFile? avatarBinary;

  const UserUpdateRequestDto({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.avatarBinary,
  });

  FormData get toForm => FormData.fromMap(
    {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "avatar": avatarBinary,
    }..removeWhere((key, value) => value == null),
  );
}
