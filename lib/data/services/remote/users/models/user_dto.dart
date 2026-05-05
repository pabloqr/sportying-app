import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required String role,
    required int id,
    required String name,
    required String surname,
    required String mail,
    required int phonePrefix,
    required int phoneNumber,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}
