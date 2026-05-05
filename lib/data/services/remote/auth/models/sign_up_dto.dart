import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_dto.freezed.dart';
part 'sign_up_dto.g.dart';

@freezed
abstract class SignUpDto with _$SignUpDto {
  const factory SignUpDto({
    required String name,
    String? surname,
    required String mail,
    required int phonePrefix,
    required int phoneNumber,
    required String password,
  }) = _SignUpDto;

  factory SignUpDto.fromJson(Map<String, dynamic> json) => _$SignUpDtoFromJson(json);
}
