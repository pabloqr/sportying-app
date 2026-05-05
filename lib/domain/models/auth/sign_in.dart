import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in.freezed.dart';

@freezed
abstract class SignIn with _$SignIn {
  const factory SignIn({required String mail, required String password}) = _SignIn;
}
