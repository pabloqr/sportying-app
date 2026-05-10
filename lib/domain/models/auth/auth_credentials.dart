import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sportying_app/domain/models/users/user.dart';

part 'auth_credentials.freezed.dart';

@freezed
abstract class AuthCredentials with _$AuthCredentials {
  const factory AuthCredentials({
    required User user,
    required String accessToken,
    required String refreshToken,
    required int expiresIn,
  }) = _AuthCredentials;
}
