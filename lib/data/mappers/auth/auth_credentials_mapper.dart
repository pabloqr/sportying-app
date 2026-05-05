import 'package:sportying_app/data/mappers/user_mapper.dart';
import 'package:sportying_app/data/services/remote/auth/models/auth_credentials_dto.dart';
import 'package:sportying_app/domain/models/auth/auth_credentials.dart';

extension AuthCredentialsDtoMapper on AuthCredentialsDto {
  AuthCredentials toDomain() {
    return AuthCredentials(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      user: user.toDomain(),
    );
  }
}

extension AuthCredentialsMapper on AuthCredentials {
  AuthCredentialsDto toDto() {
    return AuthCredentialsDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      user: user.toDto(),
    );
  }
}
