import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens.freezed.dart';

@freezed
abstract class Tokens with _$Tokens {
  const factory Tokens({required String accessToken, required String refreshToken, required int expiresIn}) = _Tokens;
}
