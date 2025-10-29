import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class SignInResponseDto {
  final String accessToken;
  final String refreshToken;

  const SignInResponseDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseDtoFromJson(json);

  ({String accessToken, String refreshToken}) toDomain() =>
      (accessToken: accessToken, refreshToken: refreshToken);
}
