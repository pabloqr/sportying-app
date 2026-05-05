import 'package:sportying_app/data/services/remote/auth/models/tokens_dto.dart';
import 'package:sportying_app/domain/models/auth/tokens.dart';

extension TokensDtoMapper on TokensDto {
  Tokens toDomain() {
    return Tokens(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn);
  }
}

extension TokensMapper on Tokens {
  TokensDto toDto() {
    return TokensDto(accessToken: accessToken, refreshToken: refreshToken, expiresIn: expiresIn);
  }
}
