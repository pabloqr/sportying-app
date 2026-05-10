import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_dto.freezed.dart';
part 'sign_in_dto.g.dart';

@freezed
abstract class SignInDto with _$SignInDto {
  const factory SignInDto({required String mail, required String password}) = _SignInDto;

  factory SignInDto.fromJson(Map<String, dynamic> json) => _$SignInDtoFromJson(json);
}
