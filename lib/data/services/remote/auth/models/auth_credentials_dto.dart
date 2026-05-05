import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportying_app/data/services/remote/users/models/user_dto.dart';

part 'auth_credentials_dto.freezed.dart';
part 'auth_credentials_dto.g.dart';

@freezed
abstract class AuthCredentialsDto with _$AuthCredentialsDto {
  const factory AuthCredentialsDto({
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
    required UserDto user,
  }) = _AuthCredentialsDto;

  factory AuthCredentialsDto.fromJson(Map<String, dynamic> json) => _$AuthCredentialsDtoFromJson(json);
}
