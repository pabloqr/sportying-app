import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up.freezed.dart';

@freezed
abstract class SignUp with _$SignUp {
  const factory SignUp({
    required String name,
    String? surname,
    required String mail,
    required int phonePrefix,
    required int phoneNumber,
    required String password,
  }) = _SignUp;
}
