import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens_dto.freezed.dart';
part 'tokens_dto.g.dart';

@freezed
abstract class TokensDto with _$TokensDto {
  const factory TokensDto({required String accessToken, required String refreshToken, required int expiresIn}) =
      _TokensDto;

  factory TokensDto.fromJson(Map<String, dynamic> json) => _$TokensDtoFromJson(json);
}
